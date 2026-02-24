Add these to every project's `.gitignore`:

```
PROGRESS.md
REVIEW.md
prd.json
progress.txt
.last-branch
```

Work Rhythm:
1. Before starting: read `PROGRESS.md` for current status, check `prd.json` for Ralph tasks
2. Create PRD: use `ralph-skills:prd` skill → saved to `tasks/prd-feature.md`
3. Convert PRD: use `ralph-skills:ralph` skill → generates `prd.json`
4. Run Ralph: `./ralph.sh --tool claude`
5. While working: capture notable issues in `REVIEW.md` as they happen
6. After finishing: update `PROGRESS.md`, mark task status in `prd.json`
