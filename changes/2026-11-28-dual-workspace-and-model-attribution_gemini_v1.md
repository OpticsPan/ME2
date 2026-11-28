# 2026-11-28　双工作区接入与 Gemini / GPT 产出区分规范

> 产出方：Gemini ｜ 日期：2026-11-28 ｜ 版本：v1

- 将本机 Gemini 工作目录 `D:\work\ME2_Gemini` 接入 GitHub 仓库 `OpticsPan/ME2`（`main` 跟踪 `origin/main`），与既有 GPT 工作目录 `D:\work\ME2` 共用本机只读参考资料区 `D:\work\ME2\参考文献`。
- 在 [协作规则](../AGENTS.md#model-attribution) 新增「模型产出标记（Gemini 与 GPT 区分）」与「[双工作区同步](../AGENTS.md#dual-workspace-sync)」规范：自 2026-11-28 起，所有带版本号的新增成果文件、文首元信息、首页更新历史、成果索引及 Git 提交均显式区分 `Gemini` 与 `GPT` 产出；历史成果保留原文件名确保链接可回查。
- 新增 [Gemini 工作区入口](../GEMINI.md)，便于 Antigravity 与其他 Gemini 客户端直接载入路径、产出方标记与同步约定；并在 [Git 忽略规则](../.gitignore) 补充常规本机缓存忽略项。
- 为 [仓库首页](../README.md#更新历史) 与 [成果索引](../outputs/README.md) 新增「产出方」列，补齐 2026-11-20 至 2026-11-26 历史条目的产出方标注，并登记本次变更。
