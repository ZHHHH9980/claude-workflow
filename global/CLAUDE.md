# Development Workflow

## Task Management

Use Ralph to define and drive task workflows. Before starting work, check for Ralph task definitions (`prd.json` or related config).

## Progress Tracking (PROGRESS.md)

After completing tasks or reaching milestones, **always** update `PROGRESS.md` in the project root.

Rules:
- Reverse chronological order (newest first)
- Record what was done and which key files changed
- Reference Ralph task IDs when applicable
- Keep it concise — not a diary

Format:

```
## YYYY-MM-DD
- ✅ Completed X (files: `path/to/file`)
- 🔄 In progress: finished A, B pending
- ❌ Blocked/dropped: reason
```

## Lessons Learned (REVIEW.md)

Capture bugs, decisions, and hard-won lessons in `REVIEW.md` in the project root.

What belongs here:
- Bug investigations and root causes
- Architecture decisions and rationale
- Third-party library gotchas
- Performance optimization findings
- Anything worth not stepping on twice

Format:

```
## [YYYY-MM-DD] Short title

**Problem**: What happened
**Cause**: Why it happened
**Fix**: How it was resolved
**Lesson**: How to avoid it next time
```

## Work Rhythm

1. **Before starting:** read `PROGRESS.md` for current status, check `prd.json` for Ralph tasks
2. **Create PRD:** use `ralph-skills:prd` skill → saved to `tasks/prd-feature.md`
3. **Convert PRD:** use `ralph-skills:ralph` skill → generates `prd.json`
4. **Run Ralph:** `./ralph.sh --tool claude` (runs autonomous loop until `<promise>COMPLETE</promise>`)
5. **While working:** capture notable issues in `REVIEW.md` as they happen
6. **After finishing:** update `PROGRESS.md`, mark task status in `prd.json`

## Ralph Task IDs

When updating `PROGRESS.md`, reference Ralph task IDs (e.g. `US-001`) when applicable:

```
## 2026-02-22
- ✅ US-001: Added status column migration (files: `db/migrations/001_add_status.sql`)
- 🔄 US-002: In progress — server action written, UI pending
```

## Files to .gitignore

Add these to every project's `.gitignore` — they are local tracking files, never push to GitHub:

```
PROGRESS.md
REVIEW.md
prd.json
progress.txt
.last-branch
```

## Git Worktrees

Use worktrees for parallel feature development on the same repo. Skip for simple/single-feature projects — the overhead isn't worth it.

When to use:
- Multiple features in parallel on the same repo
- Long-running feature that needs isolation from main

When to skip:
- Simple projects or single active feature
- Greenfield projects (just use main branch)

## Dangerous Commands — NEVER Run

**NEVER use broad process-killing commands.** These will destroy the user's running browser sessions, other Claude Code instances, and any dependent processes.

Banned:
- `killall "Google Chrome"` — kills ALL Chrome including user's main browser
- `killall Safari` / `killall Firefox` — same problem
- `pkill -f <broad-pattern>` — can match unintended processes
- Any `kill` command without a specific PID you verified first

**Instead, always:**
1. Use `lsof -i :<port>` or `ps aux | grep <exact-process>` to find the specific PID
2. Verify the PID is the right process before killing
3. Use `kill <specific-PID>` — never `killall` or broad `pkill`
4. If you need to restart Chrome with debug flags, tell the user to quit and reopen manually — don't kill it programmatically

**Why this matters:** The user runs multiple Chrome profiles, multiple Claude Code sessions, and MCP servers that depend on browser processes. One `killall` can cascade-crash everything.

## Handoff Notes on Restart

Whenever a full Claude Code restart is required (e.g. MCP config changes, environment changes), you MUST leave a handoff note BEFORE exiting. No exceptions.

**When to trigger:** Any time you say "restart Claude Code", "exit and reopen", or "relaunch".

**What to write:**

```
## Handoff Note — [date]

**What I was doing:** [one sentence]
**Next step:** [exact next action]
**Relevant state:**
- [key file / config / credential / URL]
- [anything that would be lost from memory]
**Why restarting:** [reason]
```
