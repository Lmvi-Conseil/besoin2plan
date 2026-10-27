# besoin2plan — la skill Claude Code

La skill déroule la méthode Besoin → Plan sur un répertoire que vous lui donnez. Elle monte le
chantier, y dépose le kit, puis exécute le prompt pilote du kit. Elle s'arrête à chaque décision
qui vous revient et ne produit aucun code avant votre go.

## 1. Installer

Trois voies, au choix.

**Depuis la release (le plus simple).** Téléchargez `besoin2plan-skill-v1.1.0.zip` depuis la
[dernière release](https://github.com/Lmvi-Conseil/besoin2plan/releases/latest), puis :

```bash
mkdir -p ~/.claude/skills
unzip besoin2plan-skill-v1.1.0.zip -d ~/.claude/skills/
```

**Depuis un clone du dépôt.**

```bash
git clone https://github.com/Lmvi-Conseil/besoin2plan.git
cd besoin2plan
./installer-skill.sh            # ajoute --force pour remplacer une version déjà installée
```

**Pour un seul projet.** Remplacez `~/.claude/skills/` par `<projet>/.claude/skills/` : la skill
ne sera visible que dans ce dépôt.

Dans les trois cas, la skill s'installe dans `besoin2plan/`, avec le kit embarqué dans
`reference/kit/`.

## 2. Prérequis

- **Claude Code.**
- **Python 3.9 ou plus, avec PyYAML**, pour le générateur de fiches. Il ne sert qu'à partir du
  maillon M2 : `pip install pyyaml`.
- **Un relecteur externe.** La méthode exige une relecture de M1, M4 et M6 par un relecteur
  différent en nature du rédacteur. Par défaut, Claude pilote
  [opencode](https://opencode.ai) avec un autre modèle. Si opencode n'est pas installé, la skill
  le dit et vous demande quel relecteur employer : un autre outil en ligne de commande, ou vous.
  Elle ne présente jamais sa propre relecture comme externe.

La skill n'appelle aucune API et n'a besoin d'aucune clé : elle travaille sur des fichiers locaux.

## 3. Utiliser

```text
/besoin2plan <répertoire>
```

| Situation | Ce que fait la skill |
|---|---|
| le répertoire n'a pas de chantier | elle crée `docs/chantier/`, y copie le kit, et démarre M0 |
| un cahier des charges est dans `docs/specifications/` | mode « CdC fourni » : M0 et M1 s'en extraient, avec traçabilité |
| aucun document | mode « besoin exprimé » : elle vous demande le besoin en trois phrases |
| `docs/chantier/PILOTAGE.md` existe | elle reprend le chantier là où il s'était arrêté |

Exemples :

```text
/besoin2plan apps/facturation       # monte le chantier et démarre M0
/besoin2plan apps/facturation       # relancé plus tard : reprend depuis PILOTAGE.md
```

Sans argument, la skill demande le répertoire cible.

## 4. Ce qu'elle produit

Sous `<répertoire>/docs/chantier/` :

- `PILOTAGE.md` : l'état du chantier et ses mesures, maillon par maillon ;
- `KIT-FRICTIONS.md` : une ligne par friction rencontrée avec le kit ;
- `us-data.yml` : la source de vérité des US, features, épics, règles et rôles ;
- les livrables des maillons M0 à M7, et les sorties brutes des relectures dans
  `tracking/relectures/`.

Elle **ne produit aucun code** avant le go du commanditaire, l'arrêt ⑥.

## 5. Le kit embarqué

Le kit dans `reference/kit/` ne sert qu'à **monter** un chantier neuf. Dès qu'un chantier possède
son propre `docs/chantier/_kit/`, c'est cette copie qui fait autorité. Un chantier reste figé à la
version du kit avec laquelle il a démarré : la skill ne le met jamais à niveau en cours de route.
