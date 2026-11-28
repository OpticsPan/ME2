# ME2 Gemini 工作区约定

本仓库所有协作规范统一维护于 [AGENTS.md](AGENTS.md)，在 Gemini / Antigravity 环境下作业须严格遵守该文件，并额外注意以下身份与路径约定：

- **工作目录与远端**：当前工作目录为 `D:\work\ME2_Gemini`，对应 GitHub 仓库 `OpticsPan/ME2`（分支 `main`）。开工前与推送前均须执行 `git status` 与 `git fetch origin` 并与 `origin/main` 对齐，避免与 `D:\work\ME2`（GPT 工作区）冲突。
- **默认产出方标记（`Gemini`）**：
  - 新建带版本成果文件名加 `_Gemini_vN`（例如 `outputs/reports/主题_Gemini_v1.md`、`outputs/images/图名_Gemini_v1.png`）；变更日志命名 `changes/YYYY-MM-DD-主题_gemini_v1.md`。
  - 新建 Markdown 文档在 H1 标题下首行写 `> 产出方：Gemini ｜ 日期：YYYY-MM-DD ｜ 版本：v1`；脚本文件首部注 `Producer: Gemini`。
  - 更新 [README.md](README.md#更新历史) 与 [outputs/README.md](outputs/README.md) 时在「产出方」列标注 `Gemini`。
  - Git 提交标题以 `[Gemini] ` 开头，正文末尾附 `Generated-By: Gemini`。
- **只读共享参考资料**：Level 1–3 原件与 MinerU 索引共用本机只读目录 `D:\work\ME2\参考文献`（严禁写入或复制整套资料）；所有中间文件写入 `D:\work\ME2_Gemini\work\`。
