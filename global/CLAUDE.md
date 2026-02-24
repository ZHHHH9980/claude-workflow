# Hard Rules — Always Follow

1. **改代码前先开 branch**，不在 main 上直接改。复杂项目基于 git worktree。开发前先询问清楚，确定要开发再查 https://github.com/ZHHHH9980/claude-workflow 的完整流程。
2. **改完自测通过再交付。** 不要把半成品交给用户手动验证。
3. **不跑 killall 等危险命令。** 用 `lsof -i :<port>` 找到具体 PID 再 kill，永远不要 `killall`、`pkill -f <broad-pattern>`。
4. **不要往 CLAUDE.md 加内容。** 新规则优先放到对应的事件 hook 里（如 pre-commit、commit-msg），保持 CLAUDE.md 精简。只有全局性、无法归入任何 hook 的硬规则才加到这里。

详细的格式模板、Ralph 用法、worktree 操作指南等参考 `~/Documents/claude-workflow/global/WORKFLOW-REFERENCE.md`，需要时再读。
