Update REVIEW.md in the project root.

What belongs here:
- Bug investigations and root causes
- Architecture decisions and rationale
- Third-party library gotchas
- Anything worth not stepping on twice

Format:

```
## [YYYY-MM-DD] Short title

**Problem**: What happened
**Cause**: Why it happened
**Fix**: How it was resolved
**Lesson**: How to avoid it next time
```

If the bug was caused by a missing automated check (e.g. no lint rule, no CI gate, no type check), the fix should include adding that check — not just documenting it here.
