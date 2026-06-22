#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORLD_MONITOR_URL="${WORLD_MONITOR_MCP_URL:-https://worldmonitor.app/mcp}"

if ! command -v node >/dev/null 2>&1; then
  echo "Node.js 18+ is required before configuring the WorldMonitor MCP."
  exit 1
fi

node "$ROOT_DIR/scripts/merge-mcp-config.mjs" --remote worldmonitor "$WORLD_MONITOR_URL"

echo
echo "Next steps:"
echo "1. Restart Claude Code."
echo "2. Trigger a WorldMonitor question so Claude opens the OAuth flow."
echo "3. Sign in with a WorldMonitor Pro/API account when prompted."
echo "4. Use get_market_data or get_news_intelligence for a first health check."
