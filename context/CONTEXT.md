# CONTEXT.md — Workspace Trading

Qui je suis, ce que je trade, mes règles. Fichier factuel et évolutif.
La posture est dans SOUL.md, pas ici.

---

## Identité de trader

- **Sandro**, né le 21 juillet 2006.
- **Statut** : passion personnelle, principalement le week-end. **Ce n'est ni un revenu ni un projet prioritaire.** Mes projets prioritaires (Ascensia, Projet Trio) sont dans un workspace séparé.
- **École suivie** : **Kasper** — approche **SMC / ICT**.

---

## Profil opérationnel

- **Capital** : démarrage en **démo**. Pas d'argent réel engagé tant que la démo n'a pas montré des résultats concrets sur plusieurs sessions. Plafond mental envisagé pour un éventuel passage réel : **50 à 100€**, et seulement après validation de la démo.
- **Plateforme d'analyse** : TradingView Desktop, plan **Basic**. Upgrade éventuel à Essential si les limites (2 indicateurs/chart, pas de sauvegarde de templates) deviennent bloquantes.
- **Pont TradingView** : serveur MCP intégré dans `mcp/claudeverstradingview/`, activable via `scripts/setup-tradingview-mcp.sh`.
- **Radar fondamental** : MCP distant WorldMonitor (`https://worldmonitor.app/mcp`), activable via `scripts/setup-worldmonitor-mcp.sh`, pour news, macro, crypto, énergie, géopolitique et risque de transmission.
- **Broker d'exécution envisagé** : `app.liquid.trade`. **À vérifier sérieusement avant tout dépôt réel** (voir HISTORY pour le détail des alertes remontées par la due diligence initiale). Pour l'instant : **analyse uniquement, aucune exécution**.

---

## Style de trading

- **Timeframes utilisés** : **1H, 4H, Daily**. Pas de scalping inférieur à 1H.
- **Approche entonnoir** : HTF (Daily, 4H) pour la tendance et les zones, MTF (1H) pour les POI, LTF (15m si besoin) pour le trigger d'entrée uniquement.
- **Style** : swing / intraday long, pas de scalp.
- **Watchlist** : **BTCUSD, ETHUSD, SOLUSD**. (Crypto only pour l'instant, pas de FX ni d'indices.)

---

## Disponibilité et killzones

- **Activité principale** : le week-end.
- **Possibilité en semaine** : oui, si Claude détecte un setup propre et que je peux valider un trade dans la journée. **À condition** que ça ne tape pas dans mes créneaux commerciaux Ascensia du matin (priorité absolue).
- **Killzones suivies** : London (8h-11h FR), New York (14h30-17h FR). Le week-end, marchés crypto 24/7 mais focus sur les sessions à fort volume.

---

## Règles dures non négociables

1. **Pas de trade sans setup complet** validé par la checklist du CLAUDE.md (8 points).
2. **RR minimum 1:2** sur chaque trade. Pas d'entrée en dessous.
3. **Max 2 positions ouvertes** simultanément.
4. **Stop session après 3 SL d'affilée**. Fermeture écran obligatoire, reprise le lendemain ou le week-end suivant.
5. **Pas de trade pendant les news macro majeures** (FOMC, CPI, NFP) ni dans les 30 minutes avant/après.
6. **Pas de trade contre la tendance HTF** sans justification de RR exceptionnel (>1:3).
7. **Pas de revenge trading** : un SL pris, on attend au minimum 1H avant de re-regarder le marché.
8. **Aucune entrée en démo n'est journalisée comme "vraie victoire"**. La démo sert à valider la méthode, pas à se rassurer.
9. **Filtre fondamental obligatoire quand WorldMonitor est disponible** : news, macro, crypto, énergie, géopolitique et infrastructure peuvent bloquer un setup. Le fondamental ne crée jamais une entrée.

---

## Glossaire SMC / ICT (version Kasper)

Référence interne autoritaire. Quand un terme du glossaire apparaît dans une analyse, c'est cette définition qui fait foi.

### Structures de marché
- **HTF / MTF / LTF** : High / Medium / Low Timeframe. Analyse "entonnoir" : HTF (Daily, 4H) pour la tendance, MTF (1H, 15m) pour les zones, LTF (5m, 1m) pour les entrées.
- **BOS** (Break of Structure) : cassure de structure, valide la continuation de tendance.
- **CHoCH** (Change of Character) : retournement de tendance, validé par cassure (corps de bougie) du dernier point bas/haut protégé.

### Liquidité
- **EQH / EQL** (Equal Highs/Lows) : deux ou plusieurs points hauts ou bas alignés. Vu comme un piège à liquidité, pas un support/résistance.
- **Swing High / Swing Low** : derniers points hauts/bas majeurs, aimants à liquidité.
- **PDH / PDL** (Previous Day High/Low) : extrêmes de la veille.
- **Asian High / Asian Low** : extrêmes de la session asiatique (1h-6h), souvent liquidés à l'ouverture européenne (London Reversal).
- **Sweep / Prise de liquidité** : mèche qui dépasse un niveau sans clôture au-delà. Manipulation pour chasser les stops.

### Zones d'intérêt (POI)
- **Order Block (OB)** : dernière bougie baissière avant un fort rallye haussier (OB Bullish), ou inverse. Valide seulement si en tendance, créant un déséquilibre, et **jamais retouché** (non mitigé).
- **Imbalance / FVG** (Fair Value Gap) : vide sur 3 bougies, le haut de la 1ère ne touche pas le bas de la 3ème. Le marché tend à revenir le combler.
- **BPR** (Balanced Price Range) : FVG dans une FVG. Imbalance baissière explosée par imbalance haussière (ou inverse). Très puissant.
- **Breaker Block** : OB qui a échoué, devient résistance/support inversé.
- **CISD** (Change in State of Delivery) : OB spécifique créé à l'instant du retournement (lors d'un CHoCH).
- **Mitigation** : un POI déjà touché (même par une mèche) est dit "mitigated" et perd quasi toute probabilité.

### Filtrage Fibonacci
- **Equilibrium (0.5)** : niveau central de Fibonacci sur la structure.
- **Zone Discount (<0.5)** : zone d'achat uniquement.
- **Zone Premium (>0.5)** : zone de vente uniquement.
- **OTE / Golden Zone** : entre 0.618 et 0.786 de Fibonacci. Zone d'entrée optimale.

### Modèles et timing
- **AMD / PO3** (Power of 3) : Accumulation → Manipulation → Distribution.
- **Killzones** : London Killzone 8h-11h FR, NY Killzone 14h30-17h FR (préférée de Kasper).
- **Slippage & News** : interdiction de trader 30 min avant/après une annonce majeure.
- **RR** : Kasper recommande 1:1 ou 1:2 fixe pour maintenir un win rate élevé.

---

## Indicateurs Pine attendus sur le chart

Pour que le `morning_brief` du MCP TradingView retourne quelque chose d'utile, je dois avoir sur mon chart les indicateurs suivants (à compléter au fur et à mesure) :

- **Indicateur Ribbon** (multi-EMA) : utilisé dans `mcp/claudeverstradingview/rules.example.json` pour le critère de biais si disponible.
- **EMA 20 4H** : niveau-clé de référence.
- **RSI** : confirmation de biais.
- **Indicateur SMC custom** (POI, OB, FVG) si disponible : lu via `data_get_pine_lines`, `data_get_pine_labels`, `data_get_pine_boxes`.

> En plan Basic, je suis limité à 2 indicateurs par chart. À prioriser : Ribbon + indicateur SMC custom si disponible.

Le fichier runtime `mcp/claudeverstradingview/rules.json` est généré localement depuis `rules.example.json` et ignoré par git.

---

## Priorité du moment

`[À METTRE À JOUR]` — pour l'instant : **valider en démo, sur plusieurs week-ends, que la méthode produit des résultats reproductibles avant tout passage en réel**. Pas de débat avant ce jalon.

---

## Points de vigilance personnels

- **Risque général** : tendance à se réfugier dans la technique pour éviter l'inconfort commercial Ascensia. Le trading peut servir d'évitement déguisé. Si une session trading menace de manger un créneau commercial, le trading saute.
- **Risque trader** : chercher un trade par ennui plutôt que prendre un trade par setup. Voir SOUL.md, section "Inflation d'activité".

> Le traitement de ces angles morts est dans SOUL.md. Ici c'est juste le constat.
