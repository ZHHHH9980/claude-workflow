#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}✓${NC} $1"; }
warn() { echo -e "${YELLOW}!${NC} $1"; }

# Subcommand: init — copy templates into current project
if [ "$1" = "init" ]; then
    for file in CLAUDE.md PROGRESS.md REVIEW.md; do
        if [ -f "$file" ]; then
            warn "$file already exists, skipping"
        else
            cp "$SCRIPT_DIR/templates/$file" "./$file"
            info "Created $file"
        fi
    done

    # Copy tasks/ directory
    if [ -d "tasks" ]; then
        warn "tasks/ already exists, skipping"
    else
        mkdir -p tasks
        cp "$SCRIPT_DIR/templates/tasks/prd-example.md" tasks/
        info "Created tasks/ directory with example PRD"
    fi

    # Add workflow files to .gitignore
    GITIGNORE_ENTRIES="PROGRESS.md
REVIEW.md
prd.json
progress.txt
.last-branch"
    if [ -f ".gitignore" ]; then
        while IFS= read -r entry; do
            if ! grep -qF "$entry" .gitignore; then
                echo "$entry" >> .gitignore
                info "Added $entry to .gitignore"
            fi
        done <<< "$GITIGNORE_ENTRIES"
    else
        echo "$GITIGNORE_ENTRIES" > .gitignore
        info "Created .gitignore with workflow files"
    fi

    # Symlink ralph.sh into project
    if [ -f "ralph.sh" ]; then
        warn "ralph.sh already exists, skipping"
    else
        ln -sf "$SCRIPT_DIR/ralph.sh" ./ralph.sh
        info "Linked ralph.sh"
    fi

    echo ""
    info "Project initialized. Edit CLAUDE.md to add project context."
    exit 0
fi

# Default: install global config + plugin
mkdir -p "$CLAUDE_DIR"

# Backup existing CLAUDE.md if it's not already a symlink
if [ -f "$CLAUDE_DIR/CLAUDE.md" ] && [ ! -L "$CLAUDE_DIR/CLAUDE.md" ]; then
    BACKUP="$CLAUDE_DIR/CLAUDE.md.backup.$(date +%Y%m%d%H%M%S)"
    cp "$CLAUDE_DIR/CLAUDE.md" "$BACKUP"
    warn "Backed up existing ~/.claude/CLAUDE.md → $BACKUP"
fi

ln -sf "$SCRIPT_DIR/global/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
info "Linked global/CLAUDE.md → ~/.claude/CLAUDE.md"

echo ""
info "Install complete"
echo "  Global config: ~/.claude/CLAUDE.md → $SCRIPT_DIR/global/CLAUDE.md"
echo "  Init a project: $SCRIPT_DIR/install.sh init"
echo ""
echo "  Note: Register the plugin in ~/.claude/plugins/installed_plugins.json"
echo "  and enable it in ~/.claude/settings.json if not already done."
