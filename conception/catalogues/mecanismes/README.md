<!-- KIT-VERSION: 1.2.0 -->
# Catalogue des mécanismes — index

> 148 fiches, 17 thèmes. ⭐ = fiche réelle ; les autres sont à rédiger pour votre framework à
> partir du [gabarit](GABARIT-FICHE-MECANISME.md).

| Thème | Pour | Fiches |
|---|---|---|
| [UC-WRK · Workers et cycle de vie](#uc-wrk) | écrire une unité de traitement et la faire tourner au bon rythme | 12 |
| [UC-BUS · KvBus](#uc-bus) | faire communiquer les workers d'une même instance | 8 |
| [UC-ACT · Actions REST et MCP](#uc-act) | exposer les capacités des workers aux humains, aux frontends et aux agents IA | 14 |
| [UC-DB · TechDB](#uc-db) | persister et exploiter l'état technique de l'instance | 12 |
| [UC-DOM · Domaine applicatif et couches](#uc-dom) | placer les règles de gestion et les données métier au bon endroit | 8 |
| [UC-SEC · Sécurité et identité](#uc-sec) | savoir qui appelle, avec quels droits, pour quel tenant | 12 |
| [UC-CFG · Configuration](#uc-cfg) | configurer une application sans toucher au code | 6 |
| [UC-SUP · Supervision et exploitation](#uc-sup) | surveiller, redémarrer, drainer et arrêter une instance | 12 |
| [UC-OPS · Workers intégrés du framework](#uc-ops) | utiliser les workers d'exploitation livrés avec le socle | 10 |
| [UC-RES · Résilience des appels sortants](#uc-res) | appeler un système tiers sans se laisser entraîner par ses pannes | 5 |
| [UC-RUL · Moteurs de décision et code dynamique](#uc-rul) | décider et calculer sans redéployer | 9 |
| [UC-PIP · Pipelines](#uc-pip) | chaîner des étapes de traitement | 5 |
| [UC-INT · Intégrations et transports](#uc-int) | s'insérer dans la plateforme et parler aux autres systèmes | 8 |
| [UC-UI · Pages et frontend](#uc-ui) | servir des interfaces d'exploitation et d'application | 7 |
| [UC-FIL · Repository et fichiers](#uc-fil) | exposer des fichiers éditables et leurs validateurs | 5 |
| [UC-CTR · Contrats et conformité](#uc-ctr) | garder les moteurs indiscernables dans la durée | 6 |
| [UC-DEV · Outillage du développeur](#uc-dev) | démarrer, contrôler et livrer une application | 9 |

## UC-WRK

**Workers et cycle de vie** — écrire une unité de traitement et la faire tourner au bon rythme.

| Ma brique doit… | Fiche |
|---|---|
| Exécuter une tâche toutes les N millisecondes | [`UC-WRK-01`](UC-WRK-01-planifier-par-intervalle.md) |
| Exécuter une tâche à heure fixe (cron) | [`UC-WRK-02`](UC-WRK-02-planifier-par-cron.md) |
| Worker passif : jamais planifié, piloté par ses actions | [`UC-WRK-03`](UC-WRK-03-worker-passif.md) |
| Faire découvrir ses workers automatiquement | [`UC-WRK-04`](UC-WRK-04-decouverte-automatique.md) |
| Ordonner démarrage et arrêt par priorités | [`UC-WRK-05`](UC-WRK-05-priorites-demarrage-arret.md) |
| Désactiver un worker sans le supprimer | [`UC-WRK-06`](UC-WRK-06-desactiver-un-worker.md) |
| Injecter ses dépendances par le constructeur | [`UC-WRK-07`](UC-WRK-07-injecter-ses-dependances.md) |
| Publier santé et statistiques d'un worker | [`UC-WRK-08`](UC-WRK-08-sante-et-statistiques.md) |
| Worker événementiel : consommer un flux en continu | [`UC-WRK-09`](UC-WRK-09-worker-evenementiel.md) |
| Worker d'appel externe protégé | [`UC-WRK-10`](UC-WRK-10-worker-appel-externe-protege.md) |
| Travail bloquant ou non bloquant (sync / async) | [`UC-WRK-11`](UC-WRK-11-bloquant-ou-asynchrone.md) |
| Partager un état entre workers sans base | [`UC-WRK-12`](UC-WRK-12-registre-partage.md) |

## UC-BUS

**KvBus** — faire communiquer les workers d'une même instance.

| Ma brique doit… | Fiche |
|---|---|
| Stocker une valeur clé/valeur avec expiration | [`UC-BUS-01`](UC-BUS-01-cle-valeur-avec-expiration.md) |
| Opérations atomiques (incrément, compare-and-set) | [`UC-BUS-02`](UC-BUS-02-operations-atomiques.md) |
| Publier un événement à tous les abonnés | [`UC-BUS-03`](UC-BUS-03-publication-simple.md) |
| S'abonner à un sujet, et seulement à l'initialisation | [`UC-BUS-04`](UC-BUS-04-s-abonner-a-un-sujet.md) |
| Publication fiable : groupe de consommateurs, au moins une fois | [`UC-BUS-05`](UC-BUS-05-publication-fiable.md) |
| File des messages en échec : inspecter, rejouer, purger | [`UC-BUS-06`](UC-BUS-06-file-des-echecs.md) |
| Rendre un consommateur idempotent | [`UC-BUS-07`](UC-BUS-07-consommateur-idempotent.md) |
| Changer d'implémentation de bus (mémoire vers Redis) | [`UC-BUS-08`](UC-BUS-08-bus-interchangeable.md) |

## UC-ACT

**Actions REST et MCP** — exposer les capacités des workers aux humains, aux frontends et aux agents IA.

| Ma brique doit… | Fiche |
|---|---|
| Déclarer une action avec ses paramètres typés | [`UC-ACT-01`](UC-ACT-01-declarer-une-action.md) |
| Valider les paramètres d'une action | [`UC-ACT-02`](UC-ACT-02-valider-les-parametres.md) |
| Imposer un délai maximal d'exécution | [`UC-ACT-03`](UC-ACT-03-delai-maximal.md) |
| Exiger un scope pour une action | [`UC-ACT-04`](UC-ACT-04-exiger-un-scope.md) |
| Action en lecture seule ou à confirmation requise | [`UC-ACT-05`](UC-ACT-05-lecture-seule-et-confirmation.md) |
| Auditer les invocations sans secret en clair | [`UC-ACT-06`](UC-ACT-06-auditer-les-invocations.md) |
| Invoquer une action en REST (synchrone) | [`UC-ACT-07`](UC-ACT-07-invoquer-en-rest.md) |
| Invoquer une action en asynchrone et suivre le job | [`UC-ACT-08`](UC-ACT-08-invoquer-en-asynchrone.md) |
| Exposer les actions comme outils MCP | [`UC-ACT-09`](UC-ACT-09-exposer-en-outils-mcp.md) |
| Publier la spécification des actions | [`UC-ACT-10`](UC-ACT-10-publier-la-specification.md) |
| Publier un OpenAPI exact, sécurité comprise | [`UC-ACT-11`](UC-ACT-11-publier-un-openapi.md) |
| Distinguer un refus métier d'une panne | [`UC-ACT-12`](UC-ACT-12-refus-metier-ou-panne.md) |
| Consommer les actions depuis un agent IA | [`UC-ACT-13`](UC-ACT-13-consommer-depuis-un-agent.md) |
| Agréger plusieurs instances dans un catalogue (MCPagger) | [`UC-ACT-14`](UC-ACT-14-agreger-avec-mcpagger.md) |

## UC-DB

**TechDB** — persister et exploiter l'état technique de l'instance.

| Ma brique doit… | Fiche |
|---|---|
| Persister l'état technique d'une instance | [`UC-DB-01`](UC-DB-01-persister-l-etat-technique.md) |
| Choisir le moteur : H2, PostgreSQL, SQLite | [`UC-DB-02`](UC-DB-02-choisir-le-moteur.md) |
| Faire évoluer le schéma par migrations tracées | [`UC-DB-03`](UC-DB-03-migrations-tracees.md) |
| Interroger la TechDB en SQL en lecture seule | [`UC-DB-04`](UC-DB-04-interroger-en-sql.md) |
| Lire les événements récents par action | [`UC-DB-05`](UC-DB-05-lire-les-evenements.md) |
| Purger selon une rétention | [`UC-DB-06`](UC-DB-06-purger-selon-la-retention.md) |
| Sauvegarder et restaurer | [`UC-DB-07`](UC-DB-07-sauvegarder-et-restaurer.md) |
| Console TechDB d'exploitation | [`UC-DB-08`](UC-DB-08-console-techdb.md) |
| Isoler les données métier par tenant | [`UC-DB-09`](UC-DB-09-isoler-par-tenant.md) |
| Refuser un accès sans tenant à une table partitionnée | [`UC-DB-10`](UC-DB-10-refuser-sans-tenant.md) |
| Écrire les tables métier en SQL brut | [`UC-DB-11`](UC-DB-11-tables-metier-en-sql.md) |
| Travailler avec des bases applicatives tierces | [`UC-DB-12`](UC-DB-12-bases-applicatives-tierces.md) |

## UC-DOM

**Domaine applicatif et couches** — placer les règles de gestion et les données métier au bon endroit.

| Ma brique doit… | Fiche |
|---|---|
| Modéliser une entité métier avec l'ORM Django | [`UC-DOM-01`](UC-DOM-01-modeliser-avec-l-orm.md) |
| Séparer les couches de l'application ⭐ | [`UC-DOM-02`](UC-DOM-02-separer-les-couches.md) |
| Faire franchir la frontière par des échanges immuables | [`UC-DOM-03`](UC-DOM-03-echanges-immuables.md) |
| Porter les règles de gestion dans un service | [`UC-DOM-04`](UC-DOM-04-regles-de-gestion-en-service.md) |
| Fournir l'heure et la configuration au domaine | [`UC-DOM-05`](UC-DOM-05-fournir-heure-et-configuration.md) |
| Porter l'intégrité par des contraintes en base | [`UC-DOM-06`](UC-DOM-06-integrite-par-contraintes.md) |
| Écritures de masse dans un QuerySet dédié | [`UC-DOM-07`](UC-DOM-07-ecritures-de-masse.md) |
| Générer et appliquer les migrations d'une application métier | [`UC-DOM-08`](UC-DOM-08-migrations-applicatives.md) |

## UC-SEC

**Sécurité et identité** — savoir qui appelle, avec quels droits, pour quel tenant.

| Ma brique doit… | Fiche |
|---|---|
| Protéger l'API d'administration par clé | [`UC-SEC-01`](UC-SEC-01-cle-d-administration.md) |
| Protéger /mcp par clé | [`UC-SEC-02`](UC-SEC-02-cle-mcp.md) |
| Accepter les JWT délégués du Hub | [`UC-SEC-03`](UC-SEC-03-jwt-delegues-du-hub.md) |
| Accepter un JWT délégué sur les actions REST | [`UC-SEC-04`](UC-SEC-04-jwt-sur-les-actions-rest.md) |
| Transmettre scopes et tenant jusqu'à l'action | [`UC-SEC-05`](UC-SEC-05-transmettre-scopes-et-tenant.md) |
| Ne croire l'en-tête de tenant que derrière un proxy de confiance | [`UC-SEC-06`](UC-SEC-06-proxy-de-confiance.md) |
| Fermer par défaut toute surface non publique | [`UC-SEC-07`](UC-SEC-07-fermer-par-defaut.md) |
| Déclarer les routes publiques d'une application | [`UC-SEC-08`](UC-SEC-08-routes-publiques.md) |
| Protéger des routes par session OIDC | [`UC-SEC-09`](UC-SEC-09-session-oidc.md) |
| S'enregistrer auprès du registre de workers | [`UC-SEC-10`](UC-SEC-10-registre-de-workers.md) |
| Garde de licence TheSocle | [`UC-SEC-11`](UC-SEC-11-garde-de-licence.md) |
| Lire ses secrets au démarrage (Vault) | [`UC-SEC-12`](UC-SEC-12-secrets-au-demarrage.md) |

## UC-CFG

**Configuration** — configurer une application sans toucher au code.

| Ma brique doit… | Fiche |
|---|---|
| Configurer par fichier avec substitution d'environnement | [`UC-CFG-01`](UC-CFG-01-configurer-par-fichier.md) |
| Partager les mêmes clés entre les moteurs | [`UC-CFG-02`](UC-CFG-02-memes-cles-partout.md) |
| Refuser au démarrage une configuration invalide | [`UC-CFG-03`](UC-CFG-03-refuser-une-configuration-invalide.md) |
| Lire une clé applicative typée | [`UC-CFG-04`](UC-CFG-04-lire-une-cle-typee.md) |
| Basculer par profils d'environnement | [`UC-CFG-05`](UC-CFG-05-profils-d-environnement.md) |
| Documenter les clés d'une application | [`UC-CFG-06`](UC-CFG-06-documenter-ses-cles.md) |

## UC-SUP

**Supervision et exploitation** — surveiller, redémarrer, drainer et arrêter une instance.

| Ma brique doit… | Fiche |
|---|---|
| Répondre aux sondes de vivacité et de disponibilité | [`UC-SUP-01`](UC-SUP-01-sondes-de-sante.md) |
| Lister les workers, leur état et leurs statistiques | [`UC-SUP-02`](UC-SUP-02-lister-les-workers.md) |
| Redémarrer automatiquement un worker malade | [`UC-SUP-03`](UC-SUP-03-redemarrage-automatique.md) |
| Redémarrer un worker à la main | [`UC-SUP-04`](UC-SUP-04-redemarrage-manuel.md) |
| Déclencher hors cycle un worker planifié | [`UC-SUP-05`](UC-SUP-05-declencher-hors-cycle.md) |
| Drainer puis arrêter proprement | [`UC-SUP-06`](UC-SUP-06-drain-et-arret-ordonne.md) |
| Drain HTTP seul, annulable | [`UC-SUP-07`](UC-SUP-07-drain-http.md) |
| Exposer des métriques Prometheus | [`UC-SUP-08`](UC-SUP-08-metriques-prometheus.md) |
| Escalade quand le redémarrage ne suffit pas | [`UC-SUP-09`](UC-SUP-09-escalade-du-superviseur.md) |
| Journaliser avec un contexte de corrélation | [`UC-SUP-10`](UC-SUP-10-journaliser-avec-contexte.md) |
| Agréger et expédier un rapport d'erreurs | [`UC-SUP-11`](UC-SUP-11-rapport-d-erreurs.md) |
| Tableau de bord d'exploitation des workers | [`UC-SUP-12`](UC-SUP-12-tableau-de-bord.md) |

## UC-OPS

**Workers intégrés du framework** — utiliser les workers d'exploitation livrés avec le socle.

| Ma brique doit… | Fiche |
|---|---|
| Piloter le système par commandes | [`UC-OPS-01`](UC-OPS-01-piloter-par-commandes.md) |
| Hygiène périodique automatique | [`UC-OPS-02`](UC-OPS-02-hygiene-periodique.md) |
| Gérer les files d'échec | [`UC-OPS-03`](UC-OPS-03-gerer-les-files-d-echec.md) |
| Limiter une ressource par sémaphores nommés | [`UC-OPS-04`](UC-OPS-04-semaphores-nommes.md) |
| Servir des routes HTTP applicatives | [`UC-OPS-05`](UC-OPS-05-routes-http-applicatives.md) |
| Recevoir un webhook externe | [`UC-OPS-06`](UC-OPS-06-recevoir-un-webhook.md) |
| Servir une page HTML depuis un worker | [`UC-OPS-07`](UC-OPS-07-page-html-depuis-un-worker.md) |
| Charger des plugins à chaud | [`UC-OPS-08`](UC-OPS-08-plugins-a-chaud.md) |
| Déboguer en cours d'exécution | [`UC-OPS-09`](UC-OPS-09-deboguer-en-execution.md) |
| Catalogue des actions pour l'exploitant | [`UC-OPS-10`](UC-OPS-10-catalogue-des-actions.md) |

## UC-RES

**Résilience des appels sortants** — appeler un système tiers sans se laisser entraîner par ses pannes.

| Ma brique doit… | Fiche |
|---|---|
| Couper les appels après une série d'échecs ⭐ | [`UC-RES-01`](UC-RES-01-disjoncteur.md) |
| Réessayer avec attente croissante | [`UC-RES-02`](UC-RES-02-reessais-avec-attente.md) |
| Refuser au-delà d'un débit autorisé | [`UC-RES-03`](UC-RES-03-limiter-le-debit.md) |
| Combiner disjoncteur, reprises et débit | [`UC-RES-04`](UC-RES-04-combiner-les-protections.md) |
| Imposer un délai à tout appel HTTP sortant | [`UC-RES-05`](UC-RES-05-timeout-obligatoire.md) |

## UC-RUL

**Moteurs de décision et code dynamique** — décider et calculer sans redéployer.

| Ma brique doit… | Fiche |
|---|---|
| Modéliser une décision en graphe (JDM) | [`UC-RUL-01`](UC-RUL-01-decision-en-graphe.md) |
| Choisir le type de nœud adapté (JDM) | [`UC-RUL-02`](UC-RUL-02-types-de-noeuds.md) |
| Écrire un évaluateur d'expression (JDM) | [`UC-RUL-03`](UC-RUL-03-evaluateur-d-expression.md) |
| Auditer et mettre en cache les décisions | [`UC-RUL-04`](UC-RUL-04-auditer-les-decisions.md) |
| Exécuter un moteur de règles métier | [`UC-RUL-05`](UC-RUL-05-moteur-de-regles.md) |
| Tracer les règles déclenchées | [`UC-RUL-06`](UC-RUL-06-tracer-les-regles.md) |
| Compiler du code à la volée (Janino) | [`UC-RUL-07`](UC-RUL-07-compiler-a-la-volee.md) |
| Exposer des interfaces de calcul dynamique | [`UC-RUL-08`](UC-RUL-08-interfaces-de-calcul.md) |
| Exécuter un script dynamique | [`UC-RUL-09`](UC-RUL-09-script-dynamique.md) |

## UC-PIP

**Pipelines** — chaîner des étapes de traitement.

| Ma brique doit… | Fiche |
|---|---|
| Chaîner des étapes en pipeline (V1) | [`UC-PIP-01`](UC-PIP-01-pipeline-v1.md) |
| Déclarer une étape typée (V2) | [`UC-PIP-02`](UC-PIP-02-etape-typee-v2.md) |
| Orchestrer un pipeline V2 | [`UC-PIP-03`](UC-PIP-03-orchestrer-un-pipeline.md) |
| Appliquer les motifs de pipeline courants | [`UC-PIP-04`](UC-PIP-04-motifs-de-pipeline.md) |
| Agréger des résultats de plusieurs sources | [`UC-PIP-05`](UC-PIP-05-agreger-des-resultats.md) |

## UC-INT

**Intégrations et transports** — s'insérer dans la plateforme et parler aux autres systèmes.

| Ma brique doit… | Fiche |
|---|---|
| Consommer un sujet Kafka | [`UC-INT-01`](UC-INT-01-consommer-kafka.md) |
| Exposer un service gRPC | [`UC-INT-02`](UC-INT-02-exposer-grpc.md) |
| Tenir des sessions gRPC | [`UC-INT-03`](UC-INT-03-sessions-grpc.md) |
| Relier deux instances en pair-à-pair | [`UC-INT-04`](UC-INT-04-pair-a-pair-grpc.md) |
| Servir gRPC-Web à un frontend | [`UC-INT-05`](UC-INT-05-grpc-web.md) |
| S'insérer derrière la Gateway TheSocle | [`UC-INT-06`](UC-INT-06-derriere-la-gateway.md) |
| Appeler un autre Socle en client authentifié | [`UC-INT-07`](UC-INT-07-appeler-un-autre-socle.md) |
| Déployer via le manifeste du Hub | [`UC-INT-08`](UC-INT-08-manifeste-de-deploiement.md) |

## UC-UI

**Pages et frontend** — servir des interfaces d'exploitation et d'application.

| Ma brique doit… | Fiche |
|---|---|
| Servir le tableau de bord des workers | [`UC-UI-01`](UC-UI-01-servir-le-tableau-de-bord.md) |
| Servir la console TechDB | [`UC-UI-02`](UC-UI-02-servir-la-console-techdb.md) |
| Servir le catalogue des actions | [`UC-UI-03`](UC-UI-03-servir-le-catalogue.md) |
| Héberger un frontend FrontendShell | [`UC-UI-04`](UC-UI-04-heberger-un-frontend.md) |
| Servir un formulaire piloté par un schéma | [`UC-UI-05`](UC-UI-05-formulaire-par-schema.md) |
| Rendre une page avec un moteur de gabarits | [`UC-UI-06`](UC-UI-06-moteur-de-gabarits.md) |
| Exposer l'interface MCPagger | [`UC-UI-07`](UC-UI-07-interface-mcpagger.md) |

## UC-FIL

**Repository et fichiers** — exposer des fichiers éditables et leurs validateurs.

| Ma brique doit… | Fiche |
|---|---|
| Exposer un dépôt de fichiers éditables | [`UC-FIL-01`](UC-FIL-01-depot-de-fichiers.md) |
| Déclarer un type de fichier et son validateur | [`UC-FIL-02`](UC-FIL-02-type-de-fichier-et-validateur.md) |
| Éditer ces fichiers depuis FrontendEditorZen | [`UC-FIL-03`](UC-FIL-03-editer-depuis-editorzen.md) |
| Versionner et auditer les modifications | [`UC-FIL-04`](UC-FIL-04-versionner-et-auditer.md) |
| Charger au démarrage des définitions du dépôt | [`UC-FIL-05`](UC-FIL-05-charger-des-definitions.md) |

## UC-CTR

**Contrats et conformité** — garder les moteurs indiscernables dans la durée.

| Ma brique doit… | Fiche |
|---|---|
| Écrire un contrat hors du code | [`UC-CTR-01`](UC-CTR-01-ecrire-un-contrat.md) |
| Jouer la suite de conformité croisée | [`UC-CTR-02`](UC-CTR-02-suite-de-conformite.md) |
| Annoncer sa version de contrat | [`UC-CTR-03`](UC-CTR-03-version-de-contrat.md) |
| Faire échouer la CI sur une régression de contrat | [`UC-CTR-04`](UC-CTR-04-conformite-en-ci.md) |
| Faire évoluer un contrat dans les trois moteurs | [`UC-CTR-05`](UC-CTR-05-faire-evoluer-un-contrat.md) |
| Vérifier qu'un backend est indiscernable d'un autre | [`UC-CTR-06`](UC-CTR-06-backends-indiscernables.md) |

## UC-DEV

**Outillage du développeur** — démarrer, contrôler et livrer une application.

| Ma brique doit… | Fiche |
|---|---|
| Créer un projet neuf | [`UC-DEV-01`](UC-DEV-01-creer-un-projet.md) |
| Obtenir un squelette complet en couches | [`UC-DEV-02`](UC-DEV-02-squelette-en-couches.md) |
| Partir du bon modèle de worker | [`UC-DEV-03`](UC-DEV-03-choisir-un-modele-de-worker.md) |
| Contrôler son code contre les conventions | [`UC-DEV-04`](UC-DEV-04-revue-des-conventions.md) |
| Bloquer un commit non conforme | [`UC-DEV-05`](UC-DEV-05-hook-de-pre-commit.md) |
| Construire et lancer la pile Docker | [`UC-DEV-06`](UC-DEV-06-pile-docker.md) |
| Mettre en place la CI | [`UC-DEV-07`](UC-DEV-07-mettre-en-place-la-ci.md) |
| Emporter le framework et sa doc hors du dépôt | [`UC-DEV-08`](UC-DEV-08-archive-du-starter-pack.md) |
| Faire tourner une application de démonstration | [`UC-DEV-09`](UC-DEV-09-application-de-demonstration.md) |
