# claude-workflow

我的 Claude Code 开发工作流配置。适用于所有项目的通用开发方法论。

## 核心理念

- 用 Ralph 驱动任务流程
- 用 `PROGRESS.md` 追踪进度
- 用 `REVIEW.md` 沉淀经验
- 全局配置 + 项目配置分层管理

## 文件结构

```
claude-workflow/
├── global/
│   └── CLAUDE.md          # 全局工作流 → symlink 到 ~/.claude/CLAUDE.md
├── templates/
│   ├── CLAUDE.md          # 项目级 CLAUDE.md 模板
│   ├── PROGRESS.md        # 进度记录模板
│   └── REVIEW.md          # 问题沉淀模板
└── install.sh             # 安装脚本
```

## 安装

```bash
git clone <your-repo-url> ~/claude-workflow
cd ~/claude-workflow
./install.sh
```

## 新项目初始化

```bash
# 在项目根目录执行
~/claude-workflow/install.sh init
```

会自动复制 templates 下的模板文件到当前项目。

## 工作流说明

### 分层配置

| 层级 | 文件 | 作用 |
|------|------|------|
| 全局 | `~/.claude/CLAUDE.md` | 通用工作流约定，所有项目生效 |
| 项目 | `./CLAUDE.md` | 项目技术栈、规范、架构决策 |

### 三个文件的职责

| 文件 | 记什么 | 什么时候写 |
|------|--------|-----------|
| `CLAUDE.md` | 项目上下文、开发规范 | 架构变更时 |
| `PROGRESS.md` | 做了什么、进度如何 | 每次完成任务后 |
| `REVIEW.md` | 踩了什么坑、学到什么 | 遇到值得记录的问题时 |

## 迭代

这个仓库本身也在持续迭代。改了 `global/CLAUDE.md` 后重新运行 `install.sh` 即可同步到全局。
