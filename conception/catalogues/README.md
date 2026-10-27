<!-- KIT-VERSION: 1.2.0 -->
# Les deux catalogues — ce que la plateforme rend, et comment écrire le reste

Un agent qui écrit le plan technique ne connaît pas votre plateforme. Laissé à lui-même, il
réécrit ce qu'elle fournit déjà : un envoi de courriel, un coffre à secrets, un disjoncteur, une
file de messages. Le code compile, les tests passent, et la plateforme se retrouve avec deux
versions du même service, qui divergent dès le mois suivant.

« Réutiliser la plateforme » ne suffit pas comme consigne. Il faut dire **où regarder** : c'est le
rôle de ces deux catalogues.

## Deux questions différentes

| | [Catalogue des **services**](services/README.md) | [Catalogue des **mécanismes**](mecanismes/README.md) |
|---|---|---|
| La question | *Ce besoin, la plateforme le rend-elle déjà ?* | *Ce qui reste à écrire, par quel mécanisme du framework ?* |
| Portée | **autour** de l'app : identité, secrets, API publiées, messagerie, courrier, fichiers, signature, mise en ligne | **dans** l'app : workers, actions, bus interne, persistance, résilience, règles, sécurité, écrans |
| Ce que fait la brique | elle **consomme** le service et cite sa fiche `howto-NN` | elle **suit** la fiche `UC-XXX-NN`, pas le code d'un voisin |
| Une fiche dit | comment appeler le service, le vérifier, et ses pièges | le mécanisme à employer, ce que le framework interdit, un exemple complet |

## L'ordre compte

Au plan technique (M6), chaque brique est **routée avant d'être écrite** :

1. **les services d'abord** : si la plateforme rend le besoin, la brique le consomme ;
2. **les mécanismes ensuite** : ce qui reste s'écrit comme la fiche le prescrit ;
3. **sinon, `NON COUVERT`**, écrit avant de coder ; la fiche manquante est rédigée une fois la
   solution trouvée (M7).

Interrogé à l'envers, l'agent trouve d'abord comment *écrire* un envoi de courriel, et l'écrit.
La table de routage vit au §3 bis du [plan technique](../TEMPLATE-M6-plan-technique.md) ; le
[contrôle avant go](../TEMPLATE-CONTROLE-AVANT-GO.md) refuse une brique sans référence et une
référence qui n'existe pas.

## Ce que contient ce dossier

Les deux catalogues d'une plateforme réelle, [TheSocle](https://thesocle.io) : **44 services**
rendus par son hub et **148 mécanismes** de son framework.

- **Quatre fiches sont réelles**, pour montrer le niveau attendu :
  - services : [howto-37](services/howto-37-publier-des-messages-nats-depuis-une-app.md)
    (publier des événements) et [howto-16](services/howto-16-storage-s3-quotas.md) (stockage de
    fichiers) ;
  - mécanismes : [UC-RES-01](mecanismes/UC-RES-01-disjoncteur.md) (disjoncteur) et
    [UC-DOM-02](mecanismes/UC-DOM-02-separer-les-couches.md) (séparer les couches).
- **Les 186 autres sont des gabarits à remplir** : titre, besoin couvert et sections, prêts à
  rédiger. Chaque catalogue a son modèle de fiche :
  [service](services/GABARIT-FICHE-SERVICE.md), [mécanisme](mecanismes/GABARIT-FICHE-MECANISME.md).

## Faire les vôtres

Votre plateforme n'a pas ces 192 entrées, et ce n'est pas le but. Gardez la structure, rayez ce
qui ne vous concerne pas, renommez le reste. **Commencez court** : dix services et vingt
mécanismes bien écrits valent mieux qu'un catalogue complet et vide. Puis :

1. déclarez les deux dossiers au §10 du [contrat d'architecture](../CONTRAT-ARCHITECTURE.md) ;
2. donnez leurs chemins au contrôle avant go (`CATALOGUE_SERVICES`, `CATALOGUE_MECANISMES`) ;
3. à chaque `NON COUVERT` levé, ajoutez la fiche : le catalogue grandit au rythme des chantiers.
