#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
PLUGIN_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
CALLER_DIR="$(pwd)"

# Auto-pull latest workflow from remote (silent, non-blocking)
cd "$PLUGIN_ROOT"
git pull --quiet origin main 2>/dev/null || true

# Re-link global CLAUDE.md (in case it was broken)
CLAUDE_DIR="$HOME/.claude"
mkdir -p "$CLAUDE_DIR"
ln -sf "$PLUGIN_ROOT/global/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"

# Register project with Jarvis (if running)
PROJECT_DIR="$CALLER_DIR"
PROJECT_NAME=$(basename "$PROJECT_DIR")
curl -s http://localhost:3001/api/register \
  -H "Content-Type: application/json" \
  -d "{\"name\":\"$PROJECT_NAME\",\"path\":\"$PROJECT_DIR\"}" \
  2>/dev/null || true

exit 0
