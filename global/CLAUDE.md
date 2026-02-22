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
