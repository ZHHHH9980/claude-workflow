# claude-workflow

Personal Claude Code development workflow. Event-driven rules that inject the right context at the right time.

## Core Idea

- `CLAUDE.md` only holds hard rules (4 条, ~9 lines) — maximum signal-to-noise ratio
- Detailed guidance lives in `refs/`, injected by git hooks at the right moment (feat commit → PROGRESS.md format, fix commit → REVIEW.md format)
- No preloading, no attention dilution

## Structure

```
claude-workflow/
├── global/
│   └── CLAUDE.md              # 4 hard rules → symlinked to ~/.claude/CLAUDE.md
├── refs/                      # Event-driven reference snippets
│   ├── on-feat-commit.md      # Injected by commit-msg hook on feat:
│   ├── on-fix-commit.md       # Injected by commit-msg hook on fix:
│   ├── on-project-init.md     # Referenced during project setup
│   └── on-restart.md          # Handoff note template for session restarts
├── hooks/
│   ├── hooks.json             # SessionStart hook config
│   └── session-start.sh       # Auto-pull + symlink + Jarvis registration
├── templates/
│   ├── CLAUDE.md              # Project-level CLAUDE.md template
│   ├── PROGRESS.md            # Progress tracking template
│   └── REVIEW.md              # Lessons learned template
├── skills/
│   └── sync-workflow/SKILL.md # Manual sync skill
├── .claude-plugin/
│   └── plugin.json            # Plugin manifest
├── install.sh                 # Install & project init
└── ralph.sh                   # Autonomous task runner
```

## Install

```bash
git clone https://github.com/ZHHHH9980/claude-workflow.git ~/Documents/claude-workflow
cd ~/Documents/claude-workflow
./install.sh
```

Symlinks `global/CLAUDE.md` to `~/.claude/CLAUDE.md` and registers the plugin.

## Init a New Project

```bash
~/Documents/claude-workflow/install.sh init
```

Copies templates (`CLAUDE.md`, `PROGRESS.md`, `REVIEW.md`) into the current project.

## How It Works

### Layered Config

| Layer | File | Purpose |
|-------|------|---------|
| Global | `~/.claude/CLAUDE.md` | 4 hard rules, applies to all projects |
| Project | `./CLAUDE.md` | Project-specific tech stack, conventions, architecture |

### Event-Driven Rules

Rules are not preloaded — they're injected by hooks when relevant:

| Event | Hook | Injects |
|-------|------|---------|
| `feat:` commit | `commit-msg` | `refs/on-feat-commit.md` — PROGRESS.md format |
| `fix:` commit | `commit-msg` | `refs/on-fix-commit.md` — REVIEW.md format + "add automated checks" |
| Session start | `SessionStart` | Auto-pull latest workflow, refresh symlink |
| Project init | `install.sh init` | Templates + `refs/on-project-init.md` guidance |
| Session restart | Manual | `refs/on-restart.md` — handoff note template |

### Why Event-Driven

Putting all rules in CLAUDE.md dilutes model attention. With 172 lines of mixed rules and templates, hard rules had ~5% signal-to-noise ratio. Now:

- CLAUDE.md: 9 lines, 4 rules, ~100% signal
- Everything else: injected at the exact moment it's needed

## Iterate

Update `global/CLAUDE.md` or `refs/`, push, and every project picks up changes on next session start.
