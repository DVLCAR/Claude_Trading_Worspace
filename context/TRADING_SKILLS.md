# TRADING_SKILLS.md

Compétences opérationnelles ajoutées au workspace Trading.
Elles rendent le repo utilisable avec TradingView via le MCP intégré, mais ne transforment pas Claude en signal provider.

---

## Principe

Ces compétences servent à mieux lire le marché, pas à prédire le prix.

Claude peut :
- lire le chart TradingView,
- scanner la watchlist crypto,
- lire le contexte fondamental WorldMonitor,
- repérer les éléments SMC/ICT visibles,
- entraîner Sandro en replay,
- produire un rapport de session ou de stratégie,
- refuser un setup incomplet.

Claude ne peut pas :
- promettre une rentabilité,
- dire "achète" ou "vends",
- exécuter une décision à la place de Sandro,
- valider un setup hors checklist,
- valider un setup si le filtre fondamental est en stop,
- transformer une stratégie de scalping en plan principal.

---

## Source MCP

Le serveur copié dans ce repo vient de `Gregorycal/claudeverstradingview`, lui-même basé sur des projets TradingView MCP.

Dans ce workspace, il vit ici :

`mcp/claudeverstradingview/`

Les skills importées du repo MCP sont ici :

`mcp/claudeverstradingview/skills/`

Elles sont utilisables comme références, mais la règle locale fait foi :

1. `CLAUDE.md`
2. `context/SOUL.md`
3. `context/CONTEXT.md`
4. ce fichier
5. les skills importées

Si une skill importée parle de support/résistance classique, de scalping, de signal ou d'exécution, la règle locale la surclasse.

Le MCP WorldMonitor vient du repo `koala73/worldmonitor`, mais son code n'est pas copié ici.
Dans ce workspace, WorldMonitor est utilisé comme serveur distant pour filtrer le contexte macro, crypto, news et géopolitique.

Règle locale :

- TradingView donne le setup technique.
- WorldMonitor donne le contexte fondamental.
- Le contexte fondamental peut bloquer un setup.
- Le contexte fondamental ne crée jamais une entrée.

---

## Skill : chart-analysis

Usage : analyser un chart TradingView.

Workflow adapté au SMC/ICT :
1. `chart_set_symbol`
2. `chart_set_timeframe`
3. `chart_get_state`
4. `quote_get`
5. `data_get_study_values`
6. `data_get_pine_lines`
7. `data_get_pine_labels`
8. `data_get_pine_boxes`
9. `data_get_ohlcv` avec `summary: true`
10. `capture_screenshot`

Lecture attendue :
- structure HTF,
- BOS ou CHoCH récent,
- POI valide : OB non mitigé, FVG, BPR, Breaker,
- liquidité proche : EQH, EQL, PDH, PDL, Asian High/Low,
- zone Discount/Premium,
- OTE,
- killzone,
- RR possible.

Sortie attendue :
- valide,
- faible ou risqué,
- prochaine action.

Jamais de validation sans entrée, SL, TP et RR.

---

## Skill : multi-symbol-scan

Usage : scanner BTC, ETH, SOL avant de choisir un focus de session.

Workflow :
1. utiliser la watchlist de `mcp/claudeverstradingview/rules.json`,
2. scanner en 4H par défaut,
3. lire les indicateurs visibles,
4. classer les symboles en biais bullish, bearish ou neutral,
5. proposer un focus, pas un trade.

Classement :
- meilleur focus : structure HTF claire + POI propre + liquidité identifiable + fondamental non bloquant,
- neutre : range, POI mitigé, absence de liquidité prise,
- à écarter : news proche, fondamental stop, structure confuse, setup forcé.

---

## Skill : fundamental-filter

Usage : compléter TradingView avec WorldMonitor avant de valider un setup.

Workflow :
1. utiliser `get_market_data` pour crypto, sentiment, ETF flows et commodities,
2. utiliser `get_economic_data` pour macro calendar, Fed Funds et COT,
3. utiliser `get_news_intelligence` pour les alertes economy/conflict,
4. utiliser `get_prediction_markets` si un événement finance ou géopolitique pèse sur le marché,
5. utiliser `get_energy_intelligence` ou `get_chokepoint_status` si énergie, guerre, sanctions ou shipping sont dans le narratif,
6. vérifier `cached_at` et `stale`,
7. conclure avec un seul label : favorable, neutre, risque élevé, stop.

Lecture attendue :
- news macro dans les 30 minutes,
- sentiment crypto,
- stress stablecoin,
- ETF flows,
- risk-on / risk-off global,
- tensions géopolitiques,
- énergie et chokepoints,
- outages d'infrastructure.

Sortie attendue :
- `fondamental favorable` : rien ne bloque le setup technique,
- `fondamental neutre` : pas d'avantage macro clair,
- `fondamental risque élevé` : setup possible seulement si technique impeccable et RR solide,
- `fondamental stop` : refus obligatoire.

Interdit :
- utiliser WorldMonitor pour justifier une entrée sans POI,
- transformer une news en signal de trade,
- ignorer une donnée stale,
- inventer un contexte live si le MCP n'est pas connecté.

---

## Skill : replay-practice

Usage : s'entraîner en TradingView Replay.

Replay n'est pas une exécution réelle.

Workflow :
1. choisir symbole, timeframe et date,
2. lire le contexte HTF avant de commencer,
3. avancer bougie par bougie,
4. ne considérer une entrée que si la checklist est complète,
5. journaliser les refus autant que les trades simulés,
6. terminer par une leçon précise.

Interdit :
- utiliser le replay pour justifier du revenge trading,
- multiplier les trades pour "se refaire",
- passer sous 1H comme plan principal.

---

## Skill : strategy-report

Usage : analyser un backtest ou une session.

Le rapport doit répondre :
- le setup respectait-il la checklist ?
- le filtre fondamental était-il favorable, neutre, risqué ou stop ?
- l'edge vient-il de la méthode ou d'un hasard de backtest ?
- le drawdown est-il acceptable ?
- les pertes viennent-elles du marché ou de l'indiscipline ?
- quelle règle doit être renforcée ?

Une stratégie n'est pas jugée seulement sur le profit net.
Elle est jugée sur la répétabilité, le risque, le respect des règles et la qualité des refus.

---

## Skill : pine-develop

Usage : créer ou corriger des indicateurs Pine Script pour mieux lire le chart.

Priorité :
- affichage des OB, FVG, BPR,
- EQH/EQL,
- PDH/PDL,
- Asian High/Low,
- zones Discount/Premium,
- OTE.

Un indicateur ne valide jamais un trade seul.
Il sert à rendre les éléments objectifs plus visibles.

---

## Skill : performance-analyst

Usage : analyser les résultats d'une stratégie ou d'une session.

Le rapport doit distinguer :
- performance brute,
- qualité du risque,
- discipline,
- erreurs répétées,
- améliorations concrètes.

Point critique :
une performance positive en démo ne suffit pas pour passer en réel.
Le passage réel reste bloqué tant que `context/CONTEXT.md` ne dit pas explicitement le contraire.

---

## Formule de refus obligatoire

Si Sandro cherche un trade sans setup :

> Là tu cherches un trade, tu n'en as pas un. La différence est importante. On attend ou on ferme l'écran.

Si le setup est presque bon mais incomplet :

> Il manque [point précis]. Je refuse le setup tant que ce point n'est pas validé.

---

## Règle finale

Les compétences ne rendent pas rentable par elles-mêmes.
Elles servent à réduire les trades médiocres, améliorer la lecture du marché, forcer la répétition et rendre les erreurs visibles.
