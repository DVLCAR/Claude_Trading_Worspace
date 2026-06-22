# Trading Workspace History

> Journal chronologique des sessions de trading et décisions importantes.
> Le plus récent en haut. Mis à jour via `/review` ou `/update`, pas à la main.

---

## Format d'une entrée de session

```
## AAAA-MM-JJ — Session [matin/après-midi/week-end]

**Contexte :** paires suivies, état d'esprit, conditions de marché.
**Trades pris :** [vide si aucun, c'est valide]
**Trades refusés (et pourquoi) :** ce que j'ai vu et écarté, et la raison.
**Erreurs / patterns du jour :** ce qui revient.
**Décision / règle ajoutée :** s'il y a lieu.
```

## Format d'une entrée de trade

```
### Trade — AAAA-MM-JJ HH:MM — [Paire] [Long/Short]

- **Timeframe d'entrée :** [60 / 240 / D]
- **Contexte HTF :** [haussier / baissier / range, BOS/CHoCH récent]
- **POI utilisé :** [OB / FVG / BPR / Breaker, niveau]
- **Liquidité prise avant entrée :** [EQH / EQL / Asian H / PDH...]
- **Killzone :** [London / NY / hors zone]
- **Entrée :** prix
- **SL :** prix (raison du placement)
- **TP :** prix (raison du placement)
- **RR visé :** [1:2 / 1:3]
- **Résultat :** [TP / SL / BE / partial / en cours]
- **Erreur ou bonne décision :** ce qu'il faut retenir.
```

---

## 2026-06-22 — Intégration WorldMonitor + vendoring du MCP TradingView

**Contexte :** ajout d'une couche fondamentale au workspace. Jusqu'ici, le workspace ne couvrait que le technique (SMC/ICT via TradingView). Limite identifiée : un setup chart propre peut tomber pile sur une news macro, un stress crypto, une escalade géopolitique ou un outage exchange. Sans filtre fondamental, ces cas passent à travers la checklist 8 points.

**Décisions :**
- **WorldMonitor (MCP distant)** ajouté comme radar fondamental. Endpoint `https://worldmonitor.app/mcp`. Compte Pro/API requis. Source upstream `koala73/worldmonitor` sous AGPL-3.0, on utilise l'endpoint public, on ne vendore pas l'app.
- **claudeverstradingview vendoré** dans `mcp/claudeverstradingview/` au lieu d'être cloné séparément dans `~/`. Le repo devient autoportant.
- Deux scripts de setup ajoutés dans `scripts/` : `setup-tradingview-mcp.sh`, `setup-worldmonitor-mcp.sh`, plus `merge-mcp-config.mjs` pour fusionner les serveurs dans `~/.claude/.mcp.json` sans écraser ceux déjà présents.
- Deux nouveaux fichiers de contexte créés et importés à chaque session : `context/TRADING_SKILLS.md` (compétences MCP) et `context/FUNDAMENTAL_ANALYSIS.md` (filtre macro/fondamental).
- `AGENTS.md` ajouté en racine comme pendant Codex de `CLAUDE.md` (contenu aligné).

**Règle ajoutée (CONTEXT.md règle dure n°9 + checklist étendue) :**
- Filtre fondamental obligatoire quand WorldMonitor est disponible. Sortie obligatoire : `fondamental favorable` / `fondamental neutre` / `fondamental risque élevé` / `fondamental stop`. Un `fondamental stop` refuse le trade même si la checklist technique est complète.
- Le fondamental ne crée jamais une entrée. Il filtre.
- Si WorldMonitor n'est pas connecté, le dire clairement, ne pas inventer le contexte live.

**Fichiers mis à jour pour refléter WorldMonitor :**
- `CLAUDE.md` : aligné sur `AGENTS.md` (imports étendus, section MCP combinée, règle critique filtre fondamental, `/prime` et `/setup` enrichis).
- `README.md` : architecture actuelle, stack MCP à deux serveurs, pré-requis macOS et compte WorldMonitor.
- `context/SOUL.md` : ajout du principe "Fondamental comme filtre, jamais comme déclencheur". Discipline de recherche pointe désormais sur WorldMonitor en source primaire, web fallback uniquement.

**Conséquences pratiques :**
- `/prime` ajoute un brief fondamental après le brief technique.
- `/setup` insère le filtre fondamental entre la lecture chart et la validation finale.
- Les sessions sans WorldMonitor connecté restent valides, mais l'assistant doit déclarer l'absence du filtre live au lieu de le simuler.

**Prochaine action :** lancer `scripts/setup-tradingview-mcp.sh` puis `scripts/setup-worldmonitor-mcp.sh` sur le Mac, redémarrer Claude Code, faire un `/prime` test sur BTC pour vérifier que les deux MCP répondent et que le brief fondamental ressort proprement.

---

## 2026-06-21 — Choix des sources d'exchange pour la watchlist

**Contexte :** validation des sources de données TradingView pour les 3 symboles de la watchlist. Le rules.json initial proposait Binance (USDT) par défaut, choix non discuté.

**Décisions :**
- BTC : `BITSTAMP:BTCUSD` (exchange régulé EU, paire USD réelle).
- ETH : `BITSTAMP:ETHUSD` (idem).
- SOL : `COINBASE:SOLUSD` (Coinbase régulé US, paire USD réelle).
- Refus explicite de Binance/USDT : exposition réglementaire FR/AMF, stablecoin moins propre pour analyse SMC long terme.

**Conséquences :**
- Les structures de marché lues seront légèrement différentes de celles d'analyses SMC communautaires (qui utilisent souvent Binance). Décalage de volume et parfois de niveaux de quelques pips.
- Avantage : alignement avec un environnement réglementé, plus cohérent si bascule un jour en réel sur Kraken/Bitstamp/Coinbase.

**Prochaine action :** ouvrir TradingView Desktop, vérifier que les 3 symboles sont chargeables et que les bougies 4H/1H/Daily sont disponibles en Basic.

---

## 2026-06-21 — Setup du workspace + alerte broker

**Contexte :** finalisation de l'archi à 4 fichiers du workspace trading. Décision d'utiliser le MCP server de Kasper (`claudeverstradingview`) pour l'intégration TradingView Desktop. Plan TradingView : Basic. Mode : démo uniquement.

**Décisions :**
- Architecture validée : workspace de posture (CLAUDE/SOUL/CONTEXT/HISTORY) séparé du repo MCP de Kasper.
- Watchlist initiale : BTCUSDT, ETHUSDT, SOLUSDT (par défaut Kasper, validée).
- Timeframes : 1H / 4H / Daily. Pas de scalp.
- Règles dures : RR 1:2 min, max 2 positions, stop session après 3 SL d'affilée, 1h d'attente après un SL.
- Priorité absolue Ascensia : aucune session trading n'empiète sur les créneaux commerciaux du matin (lundi-vendredi 8h-12h FR).

**Changements de contexte :**
- `CONTEXT.md` créé avec profil complet + glossaire SMC/ICT version Kasper.
- `rules.json` créé pour le `morning_brief`, mode DEMO_ONLY.

**Alerte broker (à traiter sérieusement avant tout passage en réel) :**
- Le broker envisagé `app.liquid.trade` n'a **pas** été vérifié officiellement.
- Plusieurs entités utilisent le nom "Liquid" dans le crypto/trading. L'une d'elles (`liquidbrokers.com`, Liquid Markets Pty Ltd, Australie) présente des **signaux d'alerte sérieux** :
  - Licence ASIC en mode "Appointed Representative" hors du périmètre retail autorisé par le principal (Pulse Markets).
  - Classée "scam broker" par BrokersView en 2026.
  - Trustpilot 3 étoiles avec plaintes répétées de chasse aux stops et retraits bloqués.
  - Entité enregistrée fin 2023, domaine racheté en 2024, opérationnelle depuis décembre 2024.
- **Action requise avant tout dépôt réel** : vérifier l'identité exacte de `app.liquid.trade`, son enregistrement légal, et comparer à des alternatives propres (Bitstamp, Kraken EU, courtier régulé MiFID II en France).
- Pour l'instant : **analyse uniquement, zéro exécution sur Liquid Trade**.

**Décision / règle ajoutée :**
- Une "Priorité du moment" est inscrite dans CONTEXT.md : valider en démo sur plusieurs week-ends que la méthode produit des résultats reproductibles avant tout passage en réel.

---

[Les prochaines entrées s'ajoutent au-dessus de cette ligne, plus récent en haut.]
