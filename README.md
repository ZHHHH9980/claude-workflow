# claude-workflow

My personal Claude Code development workflow. A reusable, iterable system for AI-assisted development across all projects.

## Core Idea

- Drive tasks with Ralph
- Track progress in `PROGRESS.md`
- Capture lessons in `REVIEW.md`
- Layered config: global workflow + per-project context

## Structure

```
claude-workflow/
├── global/
│   └── CLAUDE.md              # Global workflow → symlinked to ~/.claude/CLAUDE.md
├── templates/
│   ├── CLAUDE.md              # Project-level CLAUDE.md template
│   ├── PROGRESS.md            # Progress tracking template
│   └── REVIEW.md              # Lessons learned template
├── hooks/
│   ├── hooks.json             # SessionStart hook config
│   └── session-start.sh       # Auto-sync on session start
├── skills/
│   └── sync-workflow/SKILL.md # Manual sync skill
├── .claude-plugin/
│   └── plugin.json            # Plugin manifest
└── install.sh                 # Install script
```

## Install

```bash
git clone https://github.com/ZHHHH9980/claude-workflow.git ~/Documents/claude-workflow
cd ~/Documents/claude-workflow
./install.sh
```

This symlinks `global/CLAUDE.md` to `~/.claude/CLAUDE.md` and registers the plugin.

## Init a New Project

```bash
~/Documents/claude-workflow/install.sh init
```

Copies template files (`CLAUDE.md`, `PROGRESS.md`, `REVIEW.md`) into the current project directory.

## How It Works

### Layered Config

| Layer | File | Purpose |
|-------|------|---------|
| Global | `~/.claude/CLAUDE.md` | Universal workflow rules, applies to all projects |
| Project | `./CLAUDE.md` | Project-specific tech stack, conventions, architecture |

### Three Files, Three Jobs

| File | What to write | When to write |
|------|--------------|---------------|
| `CLAUDE.md` | Project context, dev conventions | On architecture changes |
| `PROGRESS.md` | What was done, current status | After completing tasks |
| `REVIEW.md` | Bugs, decisions, lessons learned | When hitting notable issues |

### Auto-Sync

The plugin includes a `SessionStart` hook that automatically pulls the latest workflow config from GitHub when you start a new Claude session.

### Default Before Coding

Workflow loading is mandatory before implementation work:
- SessionStart injects `<workflow-sync>` context automatically.
- If a session misses it, run `~/Documents/claude-workflow/hooks/session-start.sh` manually before coding.

## Iterate

This repo is meant to evolve. Update `global/CLAUDE.md`, push, and every project picks up the changes on next session start.
