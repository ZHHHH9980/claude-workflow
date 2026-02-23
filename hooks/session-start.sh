#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
PLUGIN_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

# Auto-pull latest workflow from remote (silent, non-blocking)
cd "$PLUGIN_ROOT"
git pull --quiet origin main 2>/dev/null || true

# Re-link global CLAUDE.md (in case it was broken)
CLAUDE_DIR="$HOME/.claude"
mkdir -p "$CLAUDE_DIR"
ln -sf "$PLUGIN_ROOT/global/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"

# Register project with Jarvis (if running)
PROJECT_DIR=$(pwd)
PROJECT_NAME=$(basename "$PROJECT_DIR")
curl -s http://localhost:3001/api/register \
  -H "Content-Type: application/json" \
  -d "{\"name\":\"$PROJECT_NAME\",\"path\":\"$PROJECT_DIR\"}" \
  2>/dev/null || true

# Read global workflow content
workflow_content=$(cat "$PLUGIN_ROOT/global/CLAUDE.md" 2>/dev/null || echo "")

escape_for_json() {
    local s="$1"
    s="${s//\\/\\\\}"
    s="${s//\"/\\\"}"
    s="${s//$'\n'/\\n}"
    s="${s//$'\r'/\\r}"
    s="${s//$'\t'/\\t}"
    printf '%s' "$s"
}

workflow_escaped=$(escape_for_json "$workflow_content")

cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": "<workflow-sync>\\nWorkflow synced from claude-workflow repo.\\n\\n${workflow_escaped}\\n</workflow-sync>"
  }
}
EOF

exit 0
