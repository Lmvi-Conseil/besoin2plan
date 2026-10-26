<!-- KIT-VERSION: 1.0.0 -->
<!-- PROUVE-SUR: — (gabarit ; version remplie prouvée sur TheSocle, cf. exemples/profil-thesocle/) -->
# Contrat d'architecture — {{nom de la plateforme}}

> **Le document transversal** : les règles que **toute** application de votre plateforme hérite —
> le *« où / comment »* commun (stockage, APIs, base, secrets, identité, déploiement, front,
> qualité). Une app ne redécide pas ces points : elle **s'y conforme**. Toute dérogation est une
> **décision M4 explicite et datée**.
>
> Ce gabarit est à remplir **une fois par plateforme**, pas une fois par chantier. Le plan
> technique (M6) et le câblage (M7) s'y réfèrent ; le contrôle avant go (arrêt ⑥) l'interroge
> ligne à ligne. Un exemple entièrement rempli est fourni :
> [`exemples/profil-thesocle/CONTRAT-ARCHITECTURE.md`](../exemples/profil-thesocle/CONTRAT-ARCHITECTURE.md).
>
> Version de plateforme : `{{version}}` · revu le `{{date}}`.

---

## 1. Stockage des fichiers → `{{S3 / disque partagé / …}}`
- Où vivent les médias, fichiers et artefacts : `{{…}}` — jamais sur le disque local d'un
  conteneur éphémère.
- Ce que la base stocke : `{{la référence (bucket, clé), pas le binaire}}`.

## 2. APIs → `{{passerelle d'API, appels directs…}}`
- Appels sortants et inter-applications : `{{par où ils passent}}`.
- **LLM** : `{{passerelle, fournisseur, fallback}}` — aucune clé ni fournisseur en dur dans une app.

## 3. Base de données → `{{moteur + standard}}`
- Découpage : `{{un schéma par app, rôle propriétaire…}}`.
- Standard de tables : `{{préfixes, colonnes techniques, triggers, nommage}}`.
- Multi-tenant : `{{colonne ou mécanisme d'isolation}}`.

## 4. Secrets → `{{coffre}}`
- Tout secret vit dans `{{Vault / gestionnaire de secrets}}` — jamais en clair, ni dans un fichier
  versionné, ni dans une doc.

## 5. Identité → `{{IAM / SSO}}`
- Qui authentifie : `{{la plateforme — l'app lit l'identité, elle ne la gère pas}}`.
- Où sont déclarés rôles et scopes : `{{manifeste, console IAM…}}`.
- Comment le tenant est transmis : `{{en-tête, claim…}}`.

## 6. Déploiement → `{{chaîne}}`
- `{{build image → registre → cible d'exécution}}`.
- Règles de promotion : `{{même image du staging à la prod…}}`.

## 7. Frontend → `{{design system}}`
- Shell, composants, charte : `{{…}}`.

## 8. Résilience → `{{mécanisme}}`
- Tout appel externe passe par `{{disjoncteur + réessai + limiteur}}`.
- Constructions interdites : `{{…}}`.

## 9. Observabilité → `{{métriques, logs, santé}}`
- Où vont métriques et logs : `{{…}}` · route de santé : `{{/health…}}`.
- Ce que la plateforme supervise, et ce qui reste à la charge de l'app : `{{…}}`.

## 10. Services fournis (à réutiliser, ne jamais recoder)
`{{IAM · secrets · stockage · mail · antivirus · sauvegarde · passerelle d'API · LLM · DNS · TLS · …}}`

## 11. Qualité → **clause zéro-mock**
- **Zéro mock / simulation / régression.** Sans dépendance réelle → état **honnête**
  (`en_attente`), jamais un faux résultat. **Preuve réelle à chaque gate**.
- Versionnage : `{{ce qui est bumpé ensemble}}`.

---

> **Comment une app l'utilise** : elle **ne réécrit aucun** de ces points ; son plan technique (M6)
> et son câblage (M7) **s'y réfèrent**. Toute dérogation doit être une **décision explicite** (M4).
