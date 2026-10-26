# Exemple — le profil de plateforme TheSocle

La méthode Besoin → Plan est indépendante de toute plateforme. Mais deux de ses pièces n'ont de
sens qu'une fois remplies pour **votre** plateforme :

- le **contrat d'architecture**, qui dit ce que toute application hérite sans le redécider ;
- le **contrôle avant go**, qui vérifie à l'arrêt ⑥ que la conception respecte ce contrat.

Le kit fournit les deux en gabarit, dans `conception/`. Ce dossier montre la version **remplie et
utilisée en production** sur TheSocle, la plateforme Java orientée workers de LMVI Conseil, sur
laquelle la méthode a été mise au point.

| Fichier | Ce que c'est |
|---|---|
| [`CONTRAT-ARCHITECTURE.md`](CONTRAT-ARCHITECTURE.md) | Onze règles : stockage S3, appels par la passerelle d'API, standard de tables PostgreSQL, secrets dans Vault, identité portée par le proxy, déploiement par image, design system, résilience, observabilité, services à réutiliser, clause zéro-mock. |
| [`TEMPLATE-CONTROLE-AVANT-GO.md`](TEMPLATE-CONTROLE-AVANT-GO.md) | La grille complète : neuf sections, une soixantaine de lignes, un verdict par ligne. |
| [`controle-avant-go.sh`](controle-avant-go.sh) | Les ~25 points mécaniques de la grille : nomenclature SQL, moment d'un trigger, propriétaire des tables, secrets, package, constructions interdites, manifeste, traçabilité. |

## Comment s'en servir

1. **Lisez-le comme un modèle de niveau de détail.** Une règle de contrat utile est vérifiable :
   « le trigger `update_changed_fields` est en `BEFORE UPDATE` » se contrôle, « la base est
   propre » ne se contrôle pas.
2. **Écrivez le vôtre** dans `conception/CONTRAT-ARCHITECTURE.md`, une fois pour toute votre
   plateforme. Chaque règle a gagné sa place par un incident ou une décision : gardez cette
   discipline, n'ajoutez pas de règle de confort.
3. **Reportez chaque règle** dans la section 1 de `conception/TEMPLATE-CONTROLE-AVANT-GO.md`.
4. **Automatisez ce qui se vérifie sans interprétation** dans un `controle-plateforme.sh` posé à
   côté de `conception/controle-avant-go.sh` : le script générique le lance de lui-même. Le script
   de ce dossier est un bon point de départ ; il est autonome et peut aussi remplacer le générique.

Les références internes que ce dossier contient encore, noms de services, chemins de documents
de la plateforme, sont laissées telles quelles : c'est un exemple réel, pas un gabarit.
