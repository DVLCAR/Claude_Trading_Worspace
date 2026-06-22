# Workspace Notes

This directory is a vendored copy of the TradingView MCP project used by the trading workspace.

Source inspected and copied on 2026-06-22:

`Gregorycal/claudeverstradingview`

The MCP code is included so Claude Code can connect to TradingView Desktop through Chrome DevTools Protocol on localhost port 9222.

## Local Adaptations

- `rules.json` is intentionally not tracked.
- `rules.example.json` has been replaced with Sandro's SMC/ICT demo-only crypto template.
- The upstream short-term scalping runner was removed from this workspace copy.
- Session storage was aligned to `~/.claudeverstradingview/sessions/`.

## Priority Rules

The local trading workspace rules override generic MCP instructions:

1. `../../CLAUDE.md`
2. `../../context/SOUL.md`
3. `../../context/CONTEXT.md`
4. `../../context/TRADING_SKILLS.md`
5. imported MCP skill files

If an imported skill suggests generic support/resistance, short-timeframe scalping, or execution-like wording, use the local SMC/ICT rules instead.

## Safety

This MCP gives Claude better market visibility.
It does not make Claude a financial adviser and does not guarantee profitability.
