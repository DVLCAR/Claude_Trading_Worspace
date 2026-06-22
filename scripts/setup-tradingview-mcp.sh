#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MCP_DIR="$ROOT_DIR/mcp/claudeverstradingview"
SERVER_PATH="$MCP_DIR/src/server.js"

if ! command -v node >/dev/null 2>&1; then
  echo "Node.js 18+ is required before installing the TradingView MCP."
  exit 1
fi

if ! command -v npm >/dev/null 2>&1; then
  echo "npm is required before installing the TradingView MCP."
  exit 1
fi

if [ ! -d "$MCP_DIR" ]; then
  echo "Missing MCP directory: $MCP_DIR"
  exit 1
fi

cd "$MCP_DIR"
npm install

if [ ! -f "$MCP_DIR/rules.json" ]; then
  cp "$MCP_DIR/rules.example.json" "$MCP_DIR/rules.json"
  echo "Created $MCP_DIR/rules.json from the SMC/ICT template."
fi

node "$ROOT_DIR/scripts/merge-mcp-config.mjs" "$SERVER_PATH"

echo
echo "Next steps:"
echo "1. Launch TradingView Desktop with:"
echo "   $MCP_DIR/scripts/launch_tv_debug_mac.sh"
echo "2. Restart Claude Code."
echo "3. Ask Claude to run tv_health_check, then morning_brief."
