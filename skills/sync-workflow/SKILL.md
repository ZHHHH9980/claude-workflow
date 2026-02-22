---
name: sync-workflow
description: "Sync development workflow from claude-workflow repo. Pull latest global config, templates, and re-link ~/.claude/CLAUDE.md. Use when: sync workflow, update workflow, pull workflow."
user-invocable: true
---

# Sync Workflow

Pull the latest development workflow configuration from the claude-workflow repo.

## Steps

1. Run `git pull` in the claude-workflow repo directory
2. Verify the symlink `~/.claude/CLAUDE.md` points to `global/CLAUDE.md`
3. Report what changed (if anything)

## Repo Location

The claude-workflow repo is at: `~/Documents/claude-workflow/`

## Commands

```bash
cd ~/Documents/claude-workflow && git pull origin main
ls -la ~/.claude/CLAUDE.md
```

If the symlink is broken, fix it:
```bash
ln -sf ~/Documents/claude-workflow/global/CLAUDE.md ~/.claude/CLAUDE.md
```

## Init New Project

If the user wants to initialize workflow files in the current project:
```bash
~/Documents/claude-workflow/install.sh init
```

This copies `CLAUDE.md`, `PROGRESS.md`, `REVIEW.md` templates to the current directory.
