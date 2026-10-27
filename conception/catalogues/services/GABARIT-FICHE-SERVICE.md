<!-- KIT-VERSION: 1.2.0 -->
# Gabarit — fiche de service

> Une fiche de service répond à une question : **« ce besoin, la plateforme le rend-elle déjà, et
> comment je le consomme ? »** Elle se lit avant d'écrire une brique. Si la réponse est oui, la
> brique consomme le service et cite la fiche ; elle ne le réimplémente pas.
>
> Exemples réels : [howto-37](howto-37-publier-des-messages-nats-depuis-une-app.md) (publier des événements),
> [howto-16](howto-16-storage-s3-quotas.md) (stockage de fichiers).

```markdown
# HOWTO NN — <le service, dit comme un besoin>

**Prérequis :** <ce qui doit exister avant : service démarré, clé, droit>
**Temps estimé :** <minutes>

## 1. Contexte
Le besoin, pour qui, et ce que la plateforme rend à la place du code de l'app.

## 2. Architecture
Qui appelle qui ; par quelle porte (action MCP, API publiée, bibliothèque) ; ce qui est
automatique et ce qui reste à l'appelant.

## 3. Étapes
Une étape = un geste vérifiable, avec la commande ou le code complet. Zéro pseudo-code.

## 4. Vérifier
Comment prouver que ça marche, depuis l'app, avec un résultat attendu.

## 5. Pièges courants
Symptôme · cause · correction. Ce qui a déjà coûté une demi-journée à quelqu'un.

## 6. Pour aller plus loin
Fiches voisines du catalogue.
```
