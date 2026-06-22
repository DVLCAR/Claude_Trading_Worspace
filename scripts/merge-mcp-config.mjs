import { existsSync, mkdirSync, readFileSync, writeFileSync } from "node:fs";
import { homedir } from "node:os";
import { dirname, join, resolve } from "node:path";

const args = process.argv.slice(2);

function usage() {
  console.error(`Usage:
  node scripts/merge-mcp-config.mjs /absolute/path/to/src/server.js
  node scripts/merge-mcp-config.mjs --remote <server-name> <https-url>`);
  process.exit(1);
}

if (args.length === 0) usage();

const configPath =
  process.env.CLAUDE_MCP_CONFIG || join(homedir(), ".claude", ".mcp.json");

let config = {};
if (existsSync(configPath)) {
  try {
    config = JSON.parse(readFileSync(configPath, "utf8"));
  } catch (error) {
    console.error(`Cannot parse existing MCP config at ${configPath}: ${error.message}`);
    process.exit(1);
  }
}

config.mcpServers = config.mcpServers || {};

let description;

if (args[0] === "--remote") {
  const [, name, url] = args;
  if (!name || !url) usage();

  try {
    const parsed = new URL(url);
    if (parsed.protocol !== "https:") {
      throw new Error("remote MCP URLs must use https");
    }
  } catch (error) {
    console.error(`Invalid remote MCP URL: ${error.message}`);
    process.exit(1);
  }

  config.mcpServers[name] = { url };
  description = `${name} -> ${url}`;
} else {
  const serverPath = resolve(args[0]);
  config.mcpServers.claudeverstradingview = {
    command: "node",
    args: [serverPath],
  };
  description = `claudeverstradingview -> node ${serverPath}`;
}

mkdirSync(dirname(configPath), { recursive: true });
writeFileSync(configPath, `${JSON.stringify(config, null, 2)}\n`);

console.log(`Updated ${configPath}`);
console.log(description);
