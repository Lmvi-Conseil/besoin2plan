# Historique des versions — Besoin → Plan

Le kit suit le versionnage sémantique. Chaque fichier porte un marqueur `KIT-VERSION` ; un
chantier note la version qu'il a copiée dans `_kit/KIT-VERSION.txt` et reste figé sur elle.
**Règle de cadence : une version du kit = un retour d'expérience de chantier réel.**

## 1.1.0 — 2026-10-27 · le routage avant la brique, la preuve d'un écran

Reprend les versions internes 1.10.0 et 1.11.0.

- **La preuve d'un écran** (interne 1.10.0, retour d'expérience du 2026-10-26 : cinq défauts
  d'écran en une soirée, invisibles à 202 tests de services verts). Une story d'écran a deux
  preuves, son test de services et son scénario de bout en bout au navigateur, dans le rôle.
  M7 donne la liste fixe de la gate d'écran : dans le rôle, dans une fenêtre réelle avec son
  ascenseur, un bouton ou une raison par état, une sortie par étape, un texte qui dit l'état
  réel. **Une capture pleine page n'est pas une preuve.** `TEMPLATE-TESTS.md` gagne l'axe Écran,
  `TEMPLATE-M5-phasage.md` cite la liste dans la gate.
- **Le routage avant la brique** (interne 1.11.0). M6 disait « réutiliser la plateforme » sans
  dire où regarder. Chaque brique est désormais routée, dans cet ordre, vers le catalogue des
  services puis le catalogue des mécanismes, sinon marquée `NON COUVERT` avant de coder.
  - `METHODE-Besoin2Plan.md` : M6, M7, DoD, checklist ;
  - `TEMPLATE-M6-plan-technique.md` : §3 bis, la table de routage ;
  - `CONTRAT-ARCHITECTURE.md` : §10, les deux catalogues à déclarer ;
  - `TEMPLATE-CONTROLE-AVANT-GO.md` : lignes 3.3 à 3.6 ;
  - `controle-avant-go.sh` : 3.3 (chaque brique routée) et 3.4 (chaque référence existe dans
    `CATALOGUE_SERVICES` ou `CATALOGUE_MECANISMES`).
- **L'exemple TheSocle** suit : ses deux catalogues réels (43 guides, 148 fiches), sa grille
  (lignes 5.6 à 5.9) et son script, qui corrige au passage un blocage quand l'app n'a aucun
  fichier SQL.

## 1.0.0 — 2026-10-26 · première version publique

Première publication, sous licence ouverte, de la méthode et de son kit.

- **La méthode** : chaîne M0→M7, six arrêts du commanditaire, relectures M1/M4/M6 par un agent
  différent en nature, hiérarchie épic → feature → story obligatoire, matrice de couverture
  jusqu'aux tests, boucles de retour et critère d'arrêt.
- **Le kit** : 18 gabarits de conception et le gabarit du contrat d'architecture, 5 de conformité, 4 d'exploitation ; le prompt pilote ;
  le générateur de fiches, de matrice et de squelettes de tests ; un jeu de données complet issu
  d'un chantier réel.
- **Le contrôle avant go** rendu générique : un gabarit de contrat d'architecture, une grille et
  un script qui ne vérifient que ce qui vaut pour toute plateforme, et un point d'extension
  `controle-plateforme.sh` pour vos propres règles.
- **Un exemple réel** : le contrat d'architecture et le contrôle avant go complets de la
  plateforme TheSocle, dans `exemples/profil-thesocle/`.
- **La skill Claude Code** `besoin2plan`, kit embarqué, avec son installeur.
- **Deux zips par release** : le kit seul, et la skill avec son kit.

Tous les marqueurs `KIT-VERSION` repartent à 1.0.0. Le contenu méthodologique est celui de la
dernière version interne, 1.9.0, débarrassé de ses références à l'infrastructure de LMVI Conseil.

## Lignée interne, avant publication

La méthode a vécu dix versions internes avant d'être publiée. Elles sont résumées ici pour qu'on
sache d'où vient chaque règle.

| Version | Date | Ce qu'elle a apporté |
|---|---|---|
| 1.0.0 | 2026-07-05 | Version initiale, distillée de la conception réelle de l'Atelier de décomposition de Régie : chaîne M0→M7, dix gabarits, générateur. |
| 1.1.0 | 2026-07-06 | Après une revue critique : la fiche story devient purement métier, le rattachement aux phases et aux briques vit dans la seule matrice de couverture. Boucles de retour, versionnage par fichier. |
| 1.2.0 | 2026-07-06 | Le mode d'emploi, avec un prompt prêt à coller par maillon. |
| 1.3.0 | 2026-07-06 | Chaque phase devient un mini-cycle complet : développement, recette, livraison. |
| 1.4.x | 2026-07-06 | Les trois piliers : fiches de règles, matrice d'habilitations, plan de test ; puis le prompt pilote unique qui déroule tout le chantier. |
| 1.5.0 | 2026-07-06 | Pilier conformité : PV de recette, RGPD, risques, avenants, audit. Parcours et maquettes, reprise de l'existant. |
| 1.6.0 | 2026-07-06 | Pilier exploitation : environnements, exploitation, CI et revue, documentation et formation. |
| 1.7.x | 2026-07-06 → 22 | Le principe de preuve externe ; profils et modes d'entrée ; le seuil ; le critère d'arrêt ; **la relecture par un autre modèle, pilotée par l'agent** ; le retour d'expérience et les marqueurs `PROUVE-SUR`. |
| 1.8.x | 2026-07-22 → 09-03 | Le niveau Feature : la hiérarchie épic → feature → story devient obligatoire. Correctifs de cohérence. |
| 1.9.0 | 2026-09-22 | Le contrôle avant go : l'arrêt ⑥ ne se présente plus sans sa grille remplie et son verdict. |
