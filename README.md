# claude-trading-workspace

Workspace personnel pour **Claude Code** et **Codex** dédié au trading sous l'approche **SMC / ICT** (Smart Money Concepts / Inner Circle Trader, école Kasper), enrichi d'un filtre fondamental via **WorldMonitor**.

Ce n'est **pas** un outil d'investing (long terme, fondamentaux, buy & hold). C'est un workspace d'**analyse de marché court et moyen terme** sur crypto, en timeframes 1H / 4H / Daily.

---

## Statut

- **Mode** : passion personnelle, principalement le week-end.
- **Trading** : démo uniquement. Pas d'argent réel engagé.
- **Pas une source de revenu**, pas un projet prioritaire.

---

## Ce que fait ce workspace

L'assistant joue le rôle de **sparring partner** et de **valideur de setups**. Concrètement :

- Analyser un setup en préparation contre une checklist 8 points (tendance HTF, POI, liquidité, Discount/Premium, OTE, killzone, news, RR).
- Appliquer un **filtre fondamental WorldMonitor** (macro, crypto, news, géopolitique, énergie, chokepoints, infrastructure) qui peut bloquer ou dégrader un setup.
- Tenir un journal de trades structuré pour repérer les patterns d'erreur.
- Refuser un trade qui ne coche pas tous les critères, sans complaisance.
- Lire en direct un graph TradingView via le serveur MCP `claudeverstradingview`.

## Ce que ce workspace ne fait pas

- Pas de signaux ("achète maintenant").
- Pas de surveillance temps réel ni d'alertes push.
- Pas de conseil financier.
- Pas de prédiction de cours.
- Le filtre fondamental ne crée jamais une entrée, il bloque ou laisse passer.

---

## Architecture

```
.
├── CLAUDE.md                    # Racine pour Claude Code, chargé à chaque session
├── AGENTS.md                    # Racine pour Codex, contenu aligné
├── README.md                    # Ce fichier
├── context/
│   ├── SOUL.md                  # Posture de l'assistant (sparring partner SMC/ICT)
│   ├── CONTEXT.md               # Profil de trader + glossaire SMC/ICT (Kasper)
│   ├── TRADING_SKILLS.md        # Compétences MCP adaptées au plan
│   ├── FUNDAMENTAL_ANALYSIS.md  # Filtre macro/fondamental WorldMonitor
│   ├── HISTORY.md               # Journal des sessions et des trades
│   └── import/                  # Screenshots, exports, notes externes
├── fundamentals/
│   └── worldmonitor/            # Guide d'intégration du MCP distant
├── mcp/
│   └── claudeverstradingview/   # Serveur MCP TradingView embarqué (vendoré)
└── scripts/
    ├── setup-tradingview-mcp.sh
    ├── setup-worldmonitor-mcp.sh
    └── merge-mcp-config.mjs
```

`CLAUDE.md` et `AGENTS.md` importent `SOUL.md`, `CONTEXT.md`, `TRADING_SKILLS.md` et `FUNDAMENTAL_ANALYSIS.md` à chaque session. `HISTORY.md` est lu à la demande.

---

## Stack MCP

Ce workspace combine deux serveurs MCP, configurés via les scripts dans `scripts/`. Les scripts fusionnent les serveurs dans `~/.claude/.mcp.json` sans écraser ceux déjà présents.

### 1. claudeverstradingview (technique, embarqué)

Serveur MCP qui connecte l'assistant à TradingView Desktop via Chrome DevTools Protocol et expose des outils de lecture / pilotage du chart.

- Embarqué dans `mcp/claudeverstradingview/`.
- Setup : `scripts/setup-tradingview-mcp.sh`, puis lancer TradingView Desktop via `mcp/claudeverstradingview/scripts/launch_tv_debug_mac.sh`.
- Source upstream : projet tiers non affilié à TradingView.
- Le fichier runtime `mcp/claudeverstradingview/rules.json` est généré localement depuis `rules.example.json` et ignoré par git.

### 2. WorldMonitor (fondamental, distant)

Serveur MCP distant qui fournit news, macro, crypto, énergie, chokepoints, géopolitique et risque pays.

- Endpoint : `https://worldmonitor.app/mcp`.
- Guide : `fundamentals/worldmonitor/`.
- Setup : `scripts/setup-worldmonitor-mcp.sh`, puis OAuth au premier appel.
- Source upstream : `koala73/worldmonitor` (AGPL-3.0). Ici on utilise l'endpoint public, on ne vendore pas l'application.
- Compte Pro/API requis côté WorldMonitor.

---

## Watchlist actuelle

| Symbole | Source | Note |
|---|---|---|
| BTC/USD | BITSTAMP | Exchange régulé EU |
| ETH/USD | BITSTAMP | Exchange régulé EU |
| SOL/USD | COINBASE | Exchange régulé US |

Choix volontaire : pas de Binance / USDT pour rester sur des exchanges régulés et des paires USD réelles.

---

## Pré-requis

- macOS pour lancer TradingView Desktop avec debug port (seul `launch_tv_debug_mac.sh` est fourni).
- TradingView Desktop ouvert avec le script de debug pour que le MCP technique réponde.
- Compte WorldMonitor Pro/API pour le filtre fondamental live.
- Plan TradingView Basic suffit pour démarrer, limité à 2 indicateurs par chart.

---

## Workspaces voisins

Ce workspace est **strictement isolé** d'un autre workspace personnel (Ascensia, projet professionnel prioritaire). Aucun mélange de contexte entre les deux. Les outils MCP deviennent accessibles globalement après setup, mais ils ne doivent être utilisés que dans ce workspace.

---

## Avertissement

Projet personnel à but éducatif et de recherche. Aucune décision financière ne doit être prise sur la base de ce workspace. Les compétences MCP aident à lire et pratiquer, elles ne garantissent aucune rentabilité. Le trading comporte un risque de perte en capital.
