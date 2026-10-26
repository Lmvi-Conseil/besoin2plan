#!/usr/bin/env bash
# Contrôle avant go — les points mécaniques génériques de TEMPLATE-CONTROLE-AVANT-GO.md
#
#   ./controle-avant-go.sh <dossier-app>
#
# Rend un verdict par point : OK, ECART, S.O. ou A VERIFIER.
# Sortie 0 si aucun écart, 1 sinon — utilisable en garde-fou.
#
# Cette version ne contrôle que ce qui vaut pour toute plateforme : secrets, traçabilité de la
# chaîne. Les règles de VOTRE contrat d'architecture s'ajoutent dans un script frère,
# `controle-plateforme.sh`, posé à côté de celui-ci : s'il existe, il est lancé à la suite et son
# verdict compte. L'exemple TheSocle (exemples/profil-thesocle/) montre une version complète.
#
# Ce script ne juge QUE ce qui se vérifie sans interprétation. Tout le reste (architecture,
# habilitations, traçabilité du besoin) reste à l'œil humain : un script qui prétendrait trancher
# ces points-là donnerait une fausse assurance.

set -uo pipefail

APP_DIR="${1:-}"
[ -n "$APP_DIR" ] && [ -d "$APP_DIR" ] || { echo "usage: $0 <dossier-app>" >&2; exit 2; }
APP_DIR="$(cd "$APP_DIR" && pwd)"
ICI="$(cd "$(dirname "$0")" && pwd)"

OK=0; ECARTS=0; SO=0; INCONNU=0
VERT=$'\033[32m'; ROUGE=$'\033[31m'; JAUNE=$'\033[33m'; GRIS=$'\033[90m'; RAZ=$'\033[0m'

ok()      { printf "  ${VERT}OK${RAZ}         %-6s %s\n" "$1" "$2"; OK=$((OK+1)); }
ecart()   { printf "  ${ROUGE}ECART${RAZ}      %-6s %s\n" "$1" "$2"; ECARTS=$((ECARTS+1)); }
so()      { printf "  ${GRIS}S.O.${RAZ}       %-6s %s\n" "$1" "$2"; SO=$((SO+1)); }
inconnu() { printf "  ${JAUNE}A VERIFIER${RAZ} %-6s %s\n" "$1" "$2"; INCONNU=$((INCONNU+1)); }
titre()   { printf "\n\033[1m%s\033[0m\n" "$1"; }

CHANTIER="$APP_DIR/docs/chantier"
echo "Contrôle avant go — $(basename "$APP_DIR")"
echo "  chantier : ${CHANTIER#$APP_DIR/}"

# ================================================================ 2. Secrets ===
titre "2. Secrets"

FUITES=$(grep -rlEi '(password|secret|api[_-]?key|token)[[:space:]]*[:=][[:space:]]*["'"'"']?[A-Za-z0-9/+_-]{16,}' \
         "$APP_DIR" --include=*.yml --include=*.yaml --include=*.properties --include=*.json \
         --include=*.env --include=*.md --include=*.toml \
         --exclude-dir=node_modules --exclude-dir=target --exclude-dir=.git --exclude-dir=_kit 2>/dev/null \
         | grep -vE '(\$\{|example|sample|CHANGEME|xxx|<.*>)' | head -5)
[ -z "$FUITES" ] && ok "2.1" "aucun secret apparent dans le dépôt" \
                 || { ecart "2.1" "secret possible dans :"; echo "$FUITES" | sed "s|$APP_DIR/|             |"; }

SRC=$(find "$APP_DIR" -type d \( -name src -o -name app -o -name lib \) -not -path '*/node_modules/*' \
      -not -path '*/.git/*' -not -path '*/docs/*' 2>/dev/null | head -5)
if [ -n "$SRC" ]; then
  if grep -rqE 'api\.(openai|anthropic|mistral)\.(com|ai)|sk-[A-Za-z0-9]{20}' $SRC 2>/dev/null; then
    ecart "2.4" "URL ou clé de fournisseur LLM en dur"
  else ok "2.4" "aucun fournisseur LLM en dur"; fi
else
  so "2.4" "pas encore de code — c'est le but d'un contrôle avant go"
fi

# =========================================================== 4. Traçabilité ====
titre "4. Traçabilité"

# La source de vérité est le README de M6 ; le fichier .generated est un brouillon.
MATRICE="$CHANTIER/M6-plan-technique/README.md"
[ -f "$MATRICE" ] || MATRICE=$(find "$CHANTIER" -name 'matrice-couverture*' 2>/dev/null | head -1)

if [ -n "${MATRICE:-}" ] && [ -f "$MATRICE" ]; then
  ok "4.2" "matrice de couverture : ${MATRICE#$CHANTIER/}"
  # On lit l'en-tête pour trouver les colonnes Tests et Gate, puis on ne contrôle
  # QUE celles-là : la colonne Statut vaut « à faire » avant le go, c'est normal.
  RESULTAT=$(awk -F'|' '
    /^\|/ && !entete {
      for (i=1; i<=NF; i++) {
        c=$i; gsub(/^[ \t]+|[ \t]+$/,"",c)
        if (c ~ /^Tests?$/) ct=i
        if (c ~ /^Gate$/)   cg=i
      }
      if (ct) { entete=1; next }
    }
    entete && /^\|[ \t]*(US-)?[A-Z][0-9]/ {
      n++
      t=(ct?$ct:""); g=(cg?$cg:"")
      gsub(/^[ \t]+|[ \t]+$/,"",t); gsub(/^[ \t]+|[ \t]+$/,"",g)
      vide = (t=="" || t=="-" || t ~ /compl[ée]ter|à d[ée]finir|TODO/)
      if (cg && (g=="" || g=="-" || g ~ /compl[ée]ter|à d[ée]finir/)) vide=1
      if (vide) k++
    }
    END { printf "%d %d", n+0, k+0 }' "$MATRICE")
  LIGNES_US=$(echo "$RESULTAT" | cut -d' ' -f1)
  NON_RENSEIGNE=$(echo "$RESULTAT" | cut -d' ' -f2)
  if [ "${LIGNES_US:-0}" -eq 0 ]; then
    inconnu "4.3" "aucune colonne Tests trouvée dans la matrice"
  elif [ "${NON_RENSEIGNE:-0}" -eq 0 ]; then
    ok "4.3" "$LIGNES_US US, colonnes Tests et Gate renseignées"
  else
    ecart "4.3" "$NON_RENSEIGNE US sur $LIGNES_US sans test ou sans gate"
  fi
else
  ecart "4.2" "aucune matrice de couverture dans docs/chantier — M6 incomplet"
fi

for m in M1-spec-besoins M2-user-stories M4-arbitrages M5-phasage M6-plan-technique; do
  [ -d "$CHANTIER/$m" ] && ok "4.4" "$m présent" || ecart "4.4" "$m absent du chantier"
done

if [ -d "$CHANTIER/tracking/relectures" ] && [ -n "$(ls -A "$CHANTIER/tracking/relectures" 2>/dev/null)" ]; then
  ok "4.7" "$(ls "$CHANTIER/tracking/relectures" | wc -l) relecture(s) archivée(s) dans tracking/relectures/"
else
  inconnu "4.7" "aucune relecture archivée dans tracking/relectures/ (profil express : relecteur humain ?)"
fi

# ======================================================== contrôles plateforme =
PLATEFORME="$ICI/controle-plateforme.sh"
if [ -x "$PLATEFORME" ]; then
  titre "Contrat d'architecture — $(basename "$PLATEFORME")"
  "$PLATEFORME" "$APP_DIR"; RC=$?
  [ "$RC" -eq 0 ] || ECARTS=$((ECARTS+1))
else
  titre "Contrat d'architecture"
  inconnu "1.x" "pas de controle-plateforme.sh : les règles du contrat sont à vérifier à la main"
fi

# ================================================================== verdict ====
titre "Verdict"
printf "  %d OK · %s%d écart(s)%s · %d à vérifier · %d sans objet\n" \
       "$OK" "$ROUGE" "$ECARTS" "$RAZ" "$INCONNU" "$SO"

if [ "$ECARTS" -gt 0 ] || [ "$INCONNU" -gt 0 ]; then
  echo
  echo "  Les points marqués ECART bloquent le go tant qu'ils ne sont pas levés"
  echo "  (corrigés, ou arbitrés par une décision M4 datée)."
  echo "  Les points A VERIFIER comptent comme des écarts : un contrôle non fait"
  echo "  n'est pas un contrôle réussi."
  exit 1
fi
echo "  Rien ne s'oppose au go sur les points mécaniques."
echo "  Reste à remplir à la main les lignes non marquées du TEMPLATE-CONTROLE-AVANT-GO.md."
