# FUNDAMENTAL_ANALYSIS.md

Couche d'analyse fondamentale et macro pour compléter TradingView.
Source principale : WorldMonitor MCP (`koala73/worldmonitor`).

---

## Principe

WorldMonitor sert de **filtre de contexte**, pas de générateur de trade.

TradingView répond à la question :
> Est-ce que le setup SMC/ICT existe sur le chart ?

WorldMonitor répond à la question :
> Est-ce que le contexte macro, crypto, géopolitique, liquidité ou news rend ce setup acceptable maintenant ?

Un signal fondamental favorable ne valide jamais une entrée seul.
Un signal fondamental rouge peut bloquer un setup techniquement propre.

---

## Connexion MCP

Serveur distant :

```json
{
  "mcpServers": {
    "worldmonitor": {
      "url": "https://worldmonitor.app/mcp"
    }
  }
}
```

Setup local :

```bash
scripts/setup-worldmonitor-mcp.sh
```

WorldMonitor exige un compte Pro/API pour son MCP. Le mode gratuit ne suffit pas.
Claude gère l'OAuth au premier appel si le client MCP le supporte.

---

## Outils WorldMonitor utiles

### Marchés et crypto

- `get_market_data` : crypto, commodities, ETF flows, sentiment, Fear & Greed.
- `get_economic_data` : calendrier macro, Fed Funds, COT, yield curve, earnings.
- `get_prediction_markets` : probabilités Polymarket/Kalshi sur événements géopolitiques, finance, élections.
- `get_country_macro` : inflation, croissance, chômage, balances externes.

### News et risque géopolitique

- `get_news_intelligence` : news classées par menace, signaux GDELT, alertes multi-sources.
- `get_country_risk` : CII, instabilité, sanctions, advisory.
- `get_conflict_events` : conflits, unrest, événements armés.
- `get_sanctions_data` : pression sanctions et entités OFAC.
- `get_military_posture` : posture militaire par théâtre.

### Transmission vers les marchés

- `get_energy_intelligence` : pétrole, gaz, stockage, disruptions, politiques de crise.
- `get_chokepoint_status` : Hormuz, Suez, Bab-el-Mandeb, Panama, Malacca.
- `get_supply_chain_data` : stress shipping, customs, flux commerciaux.
- `get_infrastructure_status` : outages internet/cloud.

---

## Routine avant session

Dans `/prime`, après le brief TradingView :

1. `get_market_data` avec `asset_class: ["crypto", "sentiment", "etf", "commodity"]`.
2. `get_economic_data` avec `dataset: ["econ-calendar", "fedfunds", "cot"]`.
3. `get_news_intelligence` avec `topic: "economy"` puis `topic: "conflict"` si nécessaire.
4. `get_prediction_markets` avec `category: "finance"` et `category: "geopolitical"` si le contexte est tendu.
5. `get_energy_intelligence` ou `get_chokepoint_status` seulement si pétrole, guerre, sanctions ou shipping deviennent pertinents.

Toujours vérifier `cached_at` et `stale`.
Si une donnée est stale, la noter comme faible, pas comme vérité fraîche.

---

## Routine avant validation d'un setup

Après la lecture technique TradingView, appliquer ce filtre :

1. **News macro immédiate** : FOMC, CPI, NFP, décision de taux, événement crypto majeur dans les 30 minutes avant/après = stop.
2. **Stress crypto** : stablecoin depeg, ETF flows extrêmes, hack/exploit majeur, régulation brutale = risque élevé ou stop.
3. **Régime macro** : liquidity squeeze, dollar/yields très agressifs, risk-off global = prudence.
4. **Géopolitique** : escalade militaire, sanctions majeures, pays critique en CII élevé = prudence ou stop.
5. **Énergie / chokepoints** : Hormuz, Suez, Bab-el-Mandeb, pétrole/gaz en choc = prudence sur risk assets.
6. **Infrastructure** : outage cloud/exchange/internet significatif = stop si l'exécution ou la liquidité peuvent être affectées.

Sortie obligatoire :

- `fondamental favorable`
- `fondamental neutre`
- `fondamental risque élevé`
- `fondamental stop`

Un setup ne peut être validé que si la checklist SMC/ICT est complète **et** que le filtre fondamental n'est pas `stop`.

---

## Format de réponse

Quand WorldMonitor est utilisé, répondre court :

```text
Technique : [valide / incomplet / refus]
Fondamental : [favorable / neutre / risque élevé / stop]
Ce qui bloque : [...]
Prochaine action : [...]
```

Si le MCP WorldMonitor n'est pas connecté, ne pas inventer de news.
Dire clairement :

> WorldMonitor n'est pas disponible, donc je ne peux pas confirmer le filtre fondamental live. On ne transforme pas ça en feu vert.

---

## Règle finale

La technique donne le setup.
Le fondamental donne le contexte.
La discipline décide si on attend.
