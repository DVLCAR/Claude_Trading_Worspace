# WorldMonitor Integration

Intégration du repo `koala73/worldmonitor` comme couche fondamentale et macro.

Le repo complet n'est pas copié ici : WorldMonitor est une grosse application web/desktop sous licence AGPL-3.0. Pour ce workspace, l'intégration propre consiste à connecter son MCP distant et à documenter les outils utiles au trading crypto.

## Source

- Repo : https://github.com/koala73/worldmonitor
- MCP : https://worldmonitor.app/mcp
- Finance Monitor : https://finance.worldmonitor.app
- Commodity Monitor : https://commodity.worldmonitor.app
- Energy Monitor : https://energy.worldmonitor.app
- Licence upstream : AGPL-3.0-only

## Setup

```bash
scripts/setup-worldmonitor-mcp.sh
```

Le script ajoute ce serveur à `~/.claude/.mcp.json` :

```json
{
  "mcpServers": {
    "worldmonitor": {
      "url": "https://worldmonitor.app/mcp"
    }
  }
}
```

Redémarre Claude Code après setup. Au premier appel, Claude devrait lancer le flux OAuth WorldMonitor. Le MCP n'est pas disponible en free tier.

## Usage local

WorldMonitor n'est pas utilisé pour trouver une entrée.
Il sert à répondre :

- contexte macro risk-on ou risk-off,
- news macro dans les 30 minutes,
- stress crypto ou stablecoins,
- ETF flows et sentiment,
- tensions géopolitiques,
- sanctions,
- énergie et chokepoints,
- outages ou risque d'infrastructure.

La règle locale est dans `context/FUNDAMENTAL_ANALYSIS.md`.
