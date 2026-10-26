<!-- KIT-VERSION: 1.0.0 -->
<!-- PROUVE-SUR: — (version plateforme prouvée sur TheSocle, cf. exemples/profil-thesocle/) -->
# Contrôle avant go — `<APP>`

> **Quand** : à l'arrêt ⑥, juste avant le go du développement. Après M6, avant la première ligne
> de code.
>
> **Ce que ça contrôle** : que ce qui vient d'être conçu respecte ce que la plateforme impose, et
> que la chaîne est tracée de bout en bout. La référence est le **`CONTRAT-ARCHITECTURE.md`** du
> kit — une app ne redécide pas ces points, elle s'y conforme. Cette grille ne réénonce pas les
> règles : elle les **interroge**.
>
> **Règle d'usage** : **tout écart non levé bloque le go.** Un écart se lève de deux façons, et de
> deux seulement — on corrige la conception, ou on en fait une **décision d'arbitrage M4
> explicite et datée**. « On verra plus tard » n'est pas une levée.
>
> **Une partie du travail est mécanique** : `./controle-avant-go.sh <dossier-app>` rend un verdict
> sur les points marqués 🤖. Lance-le d'abord, puis remplis à la main ce qu'il ne sait pas juger.
> La version complète d'une plateforme réelle (neuf sections, ~25 points mécaniques) est dans
> [`exemples/profil-thesocle/`](../exemples/profil-thesocle/) : partez-en pour écrire la vôtre.

| | |
|---|---|
| Application | `<APP>` |
| Chantier | `docs/chantier/` |
| Contrôlé le | `<date>` |
| Contrôlé par | `<qui>` |
| Version du kit | `<KIT-VERSION>` |
| Verdict global | ☐ GO ☐ GO SOUS RÉSERVE ☐ NO-GO |

**Verdicts possibles par ligne** : `OK` · `ÉCART` · `S.O.` (sans objet, avec la raison) ·
`À VÉRIFIER` (le contrôle n'a pas pu être fait — compte comme un écart).

---

## 1. Contrat d'architecture — une ligne par règle

Recopiez ici chaque règle de votre `CONTRAT-ARCHITECTURE.md`, une par ligne. La grille de
l'exemple TheSocle montre le niveau de détail attendu : une règle vérifiable, pas un principe.

| # | Ce que le contrat impose | Verdict | Preuve / écart |
|---|---|---|---|
| 1.1 | `{{§1 stockage : …}}` | | |
| 1.2 | `{{§3 base : …}}` | | |
| 1.3 | `{{§5 identité : …}}` | | |
| 1.n | `{{…}}` | | |

## 2. Secrets

| # | Ce qu'on impose | Verdict | Preuve / écart |
|---|---|---|---|
| 2.1 | 🤖 Aucun secret dans le dépôt : ni configuration, ni `Dockerfile`, ni doc, ni fixture | | |
| 2.2 | Tout secret vient du coffre désigné au contrat | | |
| 2.3 | L'absence d'un secret fait échouer le démarrage — pas de repli silencieux | | |
| 2.4 | 🤖 Aucune clé ni URL de fournisseur LLM en dur | | |

## 3. Ce qui ne doit pas être réécrit

| # | Ce qu'on impose | Verdict | Preuve / écart |
|---|---|---|---|
| 3.1 | Aucune brique de M6 ne refait un **service fourni** par la plateforme (contrat §10) | | |
| 3.2 | Chaque brique nouvelle de M6 porte une logique **que seule cette app connaît** | | |

> C'est la ligne la plus rentable de cette grille. Un service réécrit ne se voit pas à la revue de
> code : il se voit trois mois plus tard, quand les deux versions ont divergé.

## 4. Traçabilité — le lien entre le besoin et le code

| # | Ce qu'on impose | Verdict | Preuve / écart |
|---|---|---|---|
| 4.1 | Chaque exigence de M1 se retrouve dans au moins une US de M2 | | |
| 4.2 | 🤖 Chaque US de M2 est couverte par une brique de M6 (matrice de couverture) | | |
| 4.3 | 🤖 Les colonnes Tests et Gate de la matrice sont remplies — aucune US sans test | | |
| 4.4 | 🤖 Les maillons M1, M2, M4, M5 et M6 sont présents dans le chantier | | |
| 4.5 | Chaque arbitrage de M4 a une décision datée, pas une intention | | |
| 4.6 | Le phasage M5 livre quelque chose d'utilisable à la fin de chaque phase | | |
| 4.7 | Les relectures M1, M4 et M6 sont archivées dans `tracking/relectures/`, par un relecteur différent en nature | | |

## 5. Qualité — la clause zéro-mock

| # | Ce qu'on impose | Verdict | Preuve / écart |
|---|---|---|---|
| 5.1 | Aucun simulacre prévu : pas de bouchon, pas de fausse donnée, pas de « en dur pour l'instant » | | |
| 5.2 | Sans dépendance réelle, l'état affiché est **honnête** (`en_attente`), jamais un faux résultat | | |
| 5.3 | Chaque phase se termine par une **démonstration réelle**, pas par une case cochée | | |
| 5.4 | Ce qui n'est pas faisable maintenant est écrit comme tel, pas contourné en silence | | |

---

## Écarts relevés

| # | Ligne | Écart constaté | Levée choisie | Décision M4 ? | Date |
|---|---|---|---|---|---|
| | | | ☐ corriger ☐ arbitrer | | |

---

## Conclusion

> **Go** : aucune ligne en ÉCART ni en À VÉRIFIER.
> **Go sous réserve** : des écarts subsistent, tous rattachés à une décision M4 datée, et aucun ne
> touche la section 2 (secrets) ni une règle que le contrat déclare non négociable.
> **No-go** : tout le reste.

Signé : `<qui>` — `<date>`
