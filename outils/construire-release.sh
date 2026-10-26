#!/usr/bin/env bash
# Construit les deux zips d'une release dans dist/ :
#   besoin2plan-kit-<v>.zip     le dossier _kit/ prêt à déposer dans un chantier
#   besoin2plan-skill-<v>.zip   la skill Claude Code, kit embarqué, à dézipper dans ~/.claude/skills/
# et leur fichier SHA256SUMS.
#
#   outils/construire-release.sh
set -euo pipefail

RACINE="$(cd "$(dirname "$0")/.." && pwd)"
V="$(cat "$RACINE/conception/KIT-VERSION.txt")"
DIST="$RACINE/dist"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

rm -rf "$DIST"; mkdir -p "$DIST"

# zip par Python : pas de dépendance à l'outil `zip`, absent de bien des machines
zipper() { python3 -c 'import shutil,sys; shutil.make_archive(sys.argv[1], "zip", sys.argv[2], sys.argv[3])' "$1" "$2" "$3"; }

# --- le kit : _kit/ = conception + piliers conformité et run + l'essentiel en une page
mkdir -p "$TMP/kit"
cp -r "$RACINE/conception" "$TMP/kit/_kit"
cp -r "$RACINE/conformite" "$TMP/kit/_kit/conformite"
cp -r "$RACINE/run" "$TMP/kit/_kit/run"
cp "$RACINE/ESSENTIEL.md" "$RACINE/USAGE.md" "$TMP/kit/_kit/"
cp "$RACINE/LICENSE" "$RACINE/LICENSE-CC-BY-4.0" "$TMP/kit/_kit/"
zipper "$DIST/besoin2plan-kit-$V" "$TMP/kit" _kit

# --- la skill : même contenu que installer-skill.sh
SKILLS_DIR="$TMP/skills" "$RACINE/installer-skill.sh" >/dev/null
cp "$RACINE/LICENSE" "$RACINE/LICENSE-CC-BY-4.0" "$TMP/skills/besoin2plan/"
zipper "$DIST/besoin2plan-skill-$V" "$TMP/skills" besoin2plan

(cd "$DIST" && sha256sum ./*.zip > SHA256SUMS)
ls -l "$DIST"
cat "$DIST/SHA256SUMS"
