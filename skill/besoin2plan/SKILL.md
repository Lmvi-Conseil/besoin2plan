---
name: besoin2plan
description: >-
  Déroule la méthode Besoin→Plan (LMVI Conseil) (chaîne M0→M7 : vision, spec de besoins, US/RG, arbitrages,
  phasage, plan technique) sur un répertoire CIBLE passé en argument, en pilotant le kit méthode
  vendoré dans le chantier — et non en le réécrivant. Monte le chantier s'il n'existe pas, ou
  reprend un chantier en cours depuis son PILOTAGE.md. S'arrête aux points de décision du
  commanditaire et ne produit AUCUN code avant le go (arrêt ⑥). À utiliser quand l'utilisateur
  demande « /besoin2plan <dir> », « déroule la méthode Besoin2Plan sur <dir> », « monte le chantier
  de <app> », « lance le cadrage de <app> », « reprends le chantier de <dir> », ou « où en est le
  chantier <dir> ». Sans argument : demander quel répertoire.
---

# besoin2plan — dérouler la méthode Besoin→Plan sur un répertoire cible

Applique la méthode **Besoin→Plan** de LMVI Conseil à un **répertoire cible** donné en argument, et non au
répertoire courant. Toute mention de `docs/chantier/` se lit **`<CIBLE>/docs/chantier/`**, et toute
commande git s'exécute **dans `<CIBLE>`** (`git -C <CIBLE> …`).

Cette skill **pilote le kit, elle ne le remplace pas.** Elle localise le chantier, s'assure que le
kit y est présent, puis exécute le prompt pilote du kit. La méthode a une seule autorité : le
`_kit/` de l'instance. Rien de la méthode n'est reformulé ici — ce qui suit ne décrit que
l'amorçage, la reprise et les garde-fous.

> **`$SKILL_DIR`** dans les commandes = le dossier de cette skill, indiqué en tête de l'invocation
> (« Base directory for this skill »).

## 0. Résolution de l'argument
- L'argument = le répertoire cible (chemin **absolu**, ou **relatif à la racine du dépôt courant**).
  Normalise-le en chemin absolu `<CIBLE>`.
- **Sans argument → demande** à l'utilisateur quel répertoire, et n'exécute rien avant sa réponse.
- Vérifie que `<CIBLE>` existe. Sinon, signale-le et arrête.

## 1. Localiser ou monter le chantier

Le chantier vit dans `<CIBLE>/docs/chantier/`. Trois cas :

**a. `_kit/` présent** → c'est **lui** l'autorité, quelle que soit sa version. Une instance est
figée à la version avec laquelle elle a démarré : ne la mets **jamais** à niveau en cours de
chantier. Utilise ses fichiers tels quels.

**b. `docs/chantier/` absent** → monte-le :

```bash
mkdir -p "<CIBLE>/docs/specifications"
mkdir -p "<CIBLE>/docs/chantier"/{M0-vision,M1-spec-besoins,M4-arbitrages,M5-phasage,M6-plan-technique,M7-execution,inputs,tracking}
cp -r "$SKILL_DIR/reference/kit" "<CIBLE>/docs/chantier/_kit"
```

**c. `docs/chantier/` présent mais sans `_kit/`** → copie seulement le `_kit` (commande ci-dessus,
sans les `mkdir`), sans toucher au reste.

**Version du kit** : elle est dans `_kit/KIT-VERSION.txt` pour le kit embarqué ici. Attention —
chaque fichier du kit porte **sa propre** `KIT-VERSION`, qui ne reflète que la dernière
modification de CE fichier. Ne présente jamais la version d'un fichier isolé comme celle du kit :
c'est faux, et un bootstrap l'a déjà fait dire « v1.4.0 » pour un kit v1.7.0. En l'absence de
`KIT-VERSION.txt`, annonce la version comme indéterminée plutôt que d'en deviner une.

## 2. Déterminer le mode d'exécution

**Reprise** si `<CIBLE>/docs/chantier/PILOTAGE.md` existe → lis-le en entier, restitue en 5 lignes
l'état (maillon courant, fait/reste, décisions en attente), puis reprends là où le chantier s'était
arrêté. Ne recommence jamais un maillon déjà signé.

**Entrée à froid** sinon → détermine le **mode d'entrée** avant de lancer le pilote :
- Un document de besoin ou de cadrage existe dans `<CIBLE>/docs/specifications/` → mode
  **« CdC fourni »**, avec le chemin de ce document. Si plusieurs, demande lequel fait référence.
- Sinon → mode **« besoin exprimé »** : demande le besoin à l'utilisateur en trois phrases, et
  n'exécute rien avant sa réponse.

## 3. Exécuter le pilote

Lis `<CIBLE>/docs/chantier/_kit/PROMPT-PILOTE.md` et **exécute le prompt qu'il contient**, en y
injectant le mode d'entrée déterminé au §2. Ce prompt est la consigne opératoire : ses règles de
pilotage — profil et arrêts, relecture externe, tenue du journal, invariants — priment sur toute
habitude. Lis aussi `_kit/ESSENTIEL.md`, `_kit/METHODE-Besoin2Plan.md` et `_kit/PROFILS.md` comme
le pilote le demande.

Travaille **sous `<CIBLE>/docs/chantier/`** : c'est là que se créent `PILOTAGE.md`,
`KIT-FRICTIONS.md`, `us-data.yml` et les livrables de maillon.

## 4. Garde-fous propres à cette skill

- **Le kit est en lecture seule.** Ne modifie jamais un fichier de `_kit/`, même pour corriger une
  erreur manifeste : il est gelé pendant le chantier. Toute friction se consigne à chaud dans
  `KIT-FRICTIONS.md`, une ligne par friction.
- **Aucun code avant l'arrêt ⑥.** Pas de source, pas de schéma, pas de squelette d'implémentation,
  même « pour gagner du temps ». Le seul écrit autorisé avant le go est un livrable de la chaîne.
- **La relecture externe est une preuve, pas une formalité.** Le pilote impose un relecteur
  différent en nature (opencode par défaut) en M1/M4/M6, avec archivage de sa sortie brute dans
  `tracking/relectures/`. Si le relecteur est indisponible, **dis-le et demande** quel autre
  relecteur employer. Ne présente jamais ta propre relecture comme externe.
- **Un seul chantier à la fois par cible.** Si `PILOTAGE.md` indique un chantier terminé et que
  l'utilisateur demande un nouveau cadrage, demande s'il faut archiver l'existant avant.
- **Ne commite pas** sans demande explicite.
- **Le seuil compte** : si le besoin tient dans un message et se prouve par un test, `PROFILS.md`
  dit de ne rien dérouler. Signale-le plutôt que de monter un chantier pour un correctif.

## 5. Réponse finale

Message de confirmation **en 150 mots maximum** : le répertoire cible, la version du kit utilisée,
le mode (montage / reprise) et le mode d'entrée, le maillon atteint, et **la décision attendue de
l'utilisateur**. Rien de plus — le détail vit dans `PILOTAGE.md`.
