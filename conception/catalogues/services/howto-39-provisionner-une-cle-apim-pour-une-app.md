<!-- KIT-VERSION: 1.2.0 -->
# HOWTO 39 — Provisionner une clé APIM pour une app (accès LLM et autres APIs)

> **À rédiger pour votre plateforme** — gabarit : [GABARIT-FICHE-SERVICE.md](GABARIT-FICHE-SERVICE.md)
> · exemples réels : [howto-37](howto-37-publier-des-messages-nats-depuis-une-app.md), [howto-16](howto-16-storage-s3-quotas.md).

| | |
|---|---|
| Famille | Exposer et appeler des API |
| Besoin couvert | une clé pour appeler un LLM ou toute API APIM |
| Côté | `app` |
| À couvrir | Côté consommateur : frapper la clé `apim_prod_<40hex>`, scope, Vault, injection dans l'app, preuve depuis le conteneur. Pourquoi `create_api_key` ne convient pas. |

## 1. Contexte
<!-- Le besoin, pour qui ; ce que la plateforme rend à la place du code de l'app. -->

## 2. Architecture
<!-- Qui appelle qui, par quelle porte ; ce qui est automatique, ce qui reste à l'appelant. -->

## 3. Étapes
<!-- Une étape = un geste vérifiable, code complet. -->

## 4. Vérifier
<!-- La preuve depuis l'app, avec le résultat attendu. -->

## 5. Pièges courants
<!-- Symptôme · cause · correction. -->

## 6. Pour aller plus loin
