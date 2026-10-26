#!/usr/bin/env bash
# Installe la skill Claude Code `besoin2plan`, avec le kit de la méthode embarqué.
#
#   ./installer-skill.sh                 installe dans ~/.claude/skills/besoin2plan
#   ./installer-skill.sh --force         remplace une version déjà installée (l'ancienne est gardée à côté)
#   SKILLS_DIR=<projet>/.claude/skills ./installer-skill.sh     installe pour un seul projet
set -euo pipefail

ICI="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIR="${SKILLS_DIR:-$HOME/.claude/skills}"
DEST="$SKILLS_DIR/besoin2plan"
FORCE="${1:-}"

if [ -e "$DEST" ]; then
  if [ "$FORCE" != "--force" ]; then
    echo "La skill est déjà installée dans $DEST."
    echo "Relancez avec --force pour la remplacer (l'ancienne version sera conservée à côté)."
    exit 1
  fi
  SAUVE="$DEST.avant-$(date +%Y%m%d-%H%M%S)"
  mv "$DEST" "$SAUVE"
  echo "Ancienne version conservée dans $SAUVE"
fi

mkdir -p "$DEST/reference"
cp "$ICI/skill/besoin2plan/SKILL.md" "$ICI/skill/besoin2plan/README-INSTALL.md" "$DEST/"
cp -r "$ICI/conception" "$DEST/reference/kit"
cp -r "$ICI/conformite" "$DEST/reference/kit/conformite"
cp -r "$ICI/run" "$DEST/reference/kit/run"
cp "$ICI/ESSENTIEL.md" "$ICI/USAGE.md" "$DEST/reference/kit/"

echo "Skill installée dans $DEST (kit $(cat "$DEST/reference/kit/KIT-VERSION.txt"))."
echo "Dans Claude Code : /besoin2plan <répertoire>"
