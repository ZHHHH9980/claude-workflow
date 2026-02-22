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

1. Before starting: read `PROGRESS.md` for current status, check Ralph tasks for goals
2. While working: capture notable issues in `REVIEW.md` as they happen
3. After finishing: update `PROGRESS.md`, mark task status

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


Whenever a full Claude Code restart is required (e.g. MCP config changes, environment changes), you MUST leave a handoff note BEFORE exiting. No exceptions.

**When to trigger:** Any time you say "restart Claude Code", "exit and reopen", or "relaunch".

**What to write (say out loud or paste into chat):**

```
## Handoff Note — [date]

**What I was doing:** [one sentence]
**Next step:** [exact next action]
**Relevant state:**
- [key file / config / credential / URL]
- [anything that would be lost from memory]
**Why restarting:** [reason]
```

**Example (this session):**

```
## Handoff Note — 2026-02-22

**What I was doing:** Trying to get chrome-devtools MCP to connect to my own Chrome profile instead of a new instance, so I can read my Xiaohongshu feed.
**Next step:** After restart, verify 9222 port is open (curl http://127.0.0.1:9222/json/version), then ask Claude to browse 小红书 feed and push filtered content to Telegram.
**Relevant state:**
- Chrome must be started FIRST with: open -a "Google Chrome" --args --remote-debugging-port=9222
- MCP config already updated: ~/.claude/claude_mcp_config.json has --browserUrl http://127.0.0.1:9222
- news-capturer project: /Users/a1/Documents/news-capturer (Notion + Telegram fully configured)
- Telegram bot: @howa_news_digest_bot, chat_id in .env.local
**Why restarting:** MCP reads --browserUrl config only at startup; Chrome must be running on 9222 before Claude Code launches.
```
