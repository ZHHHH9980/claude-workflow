#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

# 颜色
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}✓${NC} $1"; }
warn() { echo -e "${YELLOW}!${NC} $1"; }

# 子命令：init - 在当前项目初始化模板文件
if [ "$1" = "init" ]; then
    for file in CLAUDE.md PROGRESS.md REVIEW.md; do
        if [ -f "$file" ]; then
            warn "$file 已存在，跳过"
        else
            cp "$SCRIPT_DIR/templates/$file" "./$file"
            info "已创建 $file"
        fi
    done
    echo ""
    info "项目初始化完成，请编辑 CLAUDE.md 填写项目信息"
    exit 0
fi

# 默认：安装全局配置
mkdir -p "$CLAUDE_DIR"

if [ -f "$CLAUDE_DIR/CLAUDE.md" ] && [ ! -L "$CLAUDE_DIR/CLAUDE.md" ]; then
    BACKUP="$CLAUDE_DIR/CLAUDE.md.backup.$(date +%Y%m%d%H%M%S)"
    cp "$CLAUDE_DIR/CLAUDE.md" "$BACKUP"
    warn "已备份原有 ~/.claude/CLAUDE.md → $BACKUP"
fi

ln -sf "$SCRIPT_DIR/global/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
info "已链接 global/CLAUDE.md → ~/.claude/CLAUDE.md"

echo ""
info "安装完成"
echo "  全局配置: ~/.claude/CLAUDE.md → $SCRIPT_DIR/global/CLAUDE.md"
echo "  初始化项目: $SCRIPT_DIR/install.sh init"
