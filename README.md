# claude-trading-workspace

Workspace personnel pour **Claude Code** dédié au trading sous l'approche **SMC / ICT** (Smart Money Concepts / Inner Circle Trader, école Kasper).

Ce n'est **pas** un outil d'investing (long terme, fondamentaux, buy & hold). C'est un workspace d'**analyse de marché court et moyen terme** sur crypto, en timeframes 1H / 4H / Daily.

---

## Statut

- **Mode** : passion personnelle, principalement le week-end.
- **Trading** : démo uniquement. Pas d'argent réel engagé.
- **Pas une source de revenu**, pas un projet prioritaire.

---

## Ce que fait ce workspace

Claude joue le rôle de **sparring partner** et de **valideur de setups**. Concrètement :

- Analyser un setup en préparation contre une checklist 8 points (tendance HTF, POI, liquidité, Discount/Premium, OTE, killzone, news, RR).
- Tenir un journal de trades structuré pour repérer les patterns d'erreur.
- Refuser un trade qui ne coche pas tous les critères, sans complaisance.
- Lire en direct un graph TradingView via le serveur MCP `claudeverstradingview` (voir plus bas).

---

## Architecture

```
.
├── CLAUDE.md                # Racine, chargé à chaque session
├── README.md                # Ce fichier
└── context/
    ├── SOUL.md              # Posture de l'assistant (sparring partner SMC/ICT)
    ├── CONTEXT.md           # Profil de trader + glossaire SMC/ICT (Kasper)
    ├── HISTORY.md           # Journal des sessions et des trades
    └── import/              # Screenshots, exports, notes externes
```

Le `CLAUDE.md` importe `SOUL.md` et `CONTEXT.md` à chaque session. `HISTORY.md` est lu à la demande.

---

## Dépendance externe : serveur MCP TradingView

Ce workspace s'appuie sur le serveur MCP **claudeverstradingview** de Kasper, qui connecte Claude Code à TradingView Desktop via Chrome DevTools Protocol et expose 81 outils de lecture / pilotage du chart.

- Repo : https://github.com/kaspertrading/claudeverstradingview
- Installé séparément dans `~/claudeverstradingview/`
- Configuré globalement dans `~/.claude/.mcp.json`
- Le fichier `rules.json` (watchlist, critères de biais, règles de risque) vit dans ce repo-là, **pas ici**.

---

## Watchlist actuelle

| Symbole | Source | Note |
|---|---|---|
| BTC/USD | BITSTAMP | Exchange régulé EU |
| ETH/USD | BITSTAMP | Exchange régulé EU |
| SOL/USD | COINBASE | Exchange régulé US |

Choix volontaire : pas de Binance / USDT pour rester sur des exchanges régulés et des paires USD réelles.

---

## Workspaces voisins

Ce workspace est **strictement isolé** d'un autre workspace personnel (Ascensia, projet professionnel prioritaire). Aucun mélange de contexte entre les deux.

---

## Avertissement

Projet personnel à but éducatif et de recherche. Aucune décision financière ne doit être prise sur la base de ce workspace. Le trading comporte un risque de perte en capital.
