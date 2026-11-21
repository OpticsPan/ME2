# ME2

本仓库归档 ME2 的项目成果与变更记录。晶圆台 IFM 以 [技术文档](outputs/reports/ifm_model.md)、[ifm_raw 原始参考](outputs/reports/ifm_raw.md)、[ifm_corr 工程扩展式](outputs/reports/ifm_corr.md) 和 [MATLAB v9 仿真](outputs/code/sim_ws_ifm_6dof_animation_v9.m) 为入口。按类型浏览 [成果索引](outputs/README.md)，协作规则见 [AGENTS.md](AGENTS.md)。

## 更新历史

| 日期 | 变更内容 | 成果链接 |
| --- | --- | --- |
| 2026-11-21 | 统一 IFM 模型命名，归档使用 ifm_corr 工程扩展式的 MATLAB v9 仿真。 | [模型说明](outputs/reports/ifm_corr.md#corr-runtime) · [MATLAB v9](outputs/code/sim_ws_ifm_6dof_animation_v9.m) · [变更日志](changes/2026-11-21-ifm-corr-matlab-v9-archive_v1.md) |
| 2026-11-21 | 将附件 v10 完整技术说明迁入 ifm_model.md，归档 Python 附件和原始 IFM 模型。 | [网页技术说明](outputs/reports/ifm_model.md) · [变更日志](changes/2026-11-21-ifm-manuscript-web-archive_v1.md) |
| 2026-11-21 | 将 IFM 技术说明替换为用户附件生成的 v10 原稿。 | [v10 原稿](outputs/reports/ifm_model_v10.pdf) · [技术说明入口](outputs/reports/ifm_model.md) · [变更日志](changes/2026-11-21-ifm-manuscript-v10_v1.md) |
| 2026-11-21 | 归档 ifm_raw 和 ifm_corr，按附件重写 IFM 技术文档、撤下旧模型。 | [IFM 技术文档](outputs/reports/ifm_model.md) · [变更日志](changes/2026-11-21-ifm-model-consolidation_v1.md) |
| 2026-11-21 | 比较同批八路光程下 C0 与附件 v7 C3 的逐组六自由度误差。 | [六自由度误差对照](outputs/reports/WS-IFM-C0-v7C3%E5%85%AD%E8%87%AA%E7%94%B1%E5%BA%A6%E8%AF%AF%E5%B7%AE_v1.md#six-pose-summary) · [变更日志](changes/2026-11-21-ws-ifm-c0-v7-c3-six-dof-errors_v1.md) |
| 2026-11-21 | 验证本次附件 C3 与 MATLAB v7，复跑 121 帧原扫描和 81 个历史位姿。 | [附件 C3 的 FreeCAD 验证](outputs/reports/WS-IFM%E9%99%84%E4%BB%B6C3-FreeCAD%E9%AA%8C%E8%AF%81_v1.md#attached-c3-result) · [变更日志](changes/2026-11-21-ws-ifm-attached-c3-freecad_v1.md) |
| 2026-11-21 | 用同一批 81 组 FreeCAD 八路读数逐组复算 C0/C3，归档位姿、误差与共同输入。 | [撤下记录](changes/2026-11-21-ifm-model-consolidation_v1.md#retired-ifm) · [变更日志](changes/2026-11-21-ws-ifm-c0-c3-freecad-81-cases_v1.md) |
| 2026-11-21 | 并排归档 C0 与 C3 六条完整公式，原位保留 47 项并标注待确认内容。 | [撤下记录](changes/2026-11-21-ifm-model-consolidation_v1.md#retired-ifm) · [变更日志](changes/2026-11-21-ws-ifm-c0-c3-formula-table_v1.md) |
| 2026-11-21 | 保留 C0 六式 47 项，逐项核对符号、下标和幂次，并用 81 组 FreeCAD 工况验算。 | [撤下记录](changes/2026-11-21-ifm-model-consolidation_v1.md#retired-ifm) · [变更日志](changes/2026-11-21-ws-ifm-c0-sign-index-review_v1.md) |
| 2026-11-21 | 核对 C0 在 ZXY 两种约定下的偏航、Abbe 项和 Ryz 高度增益。 | [撤下记录](changes/2026-11-21-ifm-model-consolidation_v1.md#retired-ifm) · [变更日志](changes/2026-11-21-ws-ifm-c0-zxy-review_v1.md) |
| 2026-11-21 | 复核 ASML 公开专利、Level 1–3 与 C0 的 WS-IFM 旋转顺序证据。 | [旋转顺序核对](outputs/reports/WS-IFM%E5%85%AB%E8%BD%B4%E8%A7%A3%E7%AE%97%E5%85%AC%E5%BC%80%E8%B5%84%E6%96%99%E8%B0%83%E7%A0%94_v2.md#rotation-order) · [变更日志](changes/2026-11-21-ws-ifm-rotation-order-evidence_v1.md) |
| 2026-11-21 | 调研八轴 IFM 的公开布局和解算公式，核对其与 C0 的对应关系。 | [八轴解算调研](outputs/reports/WS-IFM%E5%85%AB%E8%BD%B4%E8%A7%A3%E7%AE%97%E5%85%AC%E5%BC%80%E8%B5%84%E6%96%99%E8%B0%83%E7%A0%94_v1.md#findings) · [变更日志](changes/2026-11-21-ws-ifm-eight-axis-public-research_v1.md) |
| 2026-11-21 | 说明 WS-IFM 如何从八路光程解算六自由度，核对 C0 中 Ry 的输入来源。 | [撤下记录](changes/2026-11-21-ifm-model-consolidation_v1.md#retired-ifm) · [变更日志](changes/2026-11-21-ws-ifm-six-dof-observability_v1.md) |
| 2026-11-21 | 逐项解读 C0 的 Ryz 公式，核对 Z 差分和校准常数。 | [撤下记录](changes/2026-11-21-ifm-model-consolidation_v1.md#retired-ifm) · [变更日志](changes/2026-11-21-ws-ifm-c0-ryz-terms_v1.md) |
| 2026-11-21 | 推导 WS-IFM-C3 的 Rx 与八通道解算，核对 C0 和 Level 1–3 标定常数并复算。 | [撤下记录](changes/2026-11-21-ifm-model-consolidation_v1.md#retired-ifm) · [变更日志](changes/2026-11-21-ws-ifm-c3-model-calibration_v1.md) |
| 2026-11-21 | 将 MATLAB v6 修正式命名为 C2，整理 C0 → C1 → C2 的八项公式变更与推导。 | [撤下记录](changes/2026-11-21-ifm-model-consolidation_v1.md#retired-ifm) · [变更日志](changes/2026-11-21-ws-ifm-c0-c1-c2-formula-derivation_v1.md) |
| 2026-11-21 | 比较 WS-IFM C0、C1 和修正 C1，复现 MATLAB 扫描残差并以 FreeCAD 交叉验证。 | [撤下记录](changes/2026-11-21-ifm-model-consolidation_v1.md#retired-ifm) · [变更日志](changes/2026-11-21-ws-ifm-c0-c1-matlab-simulation_v1.md) |
| 2026-11-21 | 对原始 WS-IFM v1 作零位一阶展开，用 FreeCAD 验证 35 组位姿和单轴斜率。 | [撤下记录](changes/2026-11-21-ifm-model-consolidation_v1.md#retired-ifm) · [变更日志](changes/2026-11-21-ws-ifm-original-v1-first-order-freecad_v1.md) |
| 2026-11-21 | 修正 WS-IFM 附件六式，核对 50 项参数并复验原 29 组工况。 | [撤下记录](changes/2026-11-21-ifm-model-consolidation_v1.md#retired-ifm) · [变更日志](changes/2026-11-21-ws-ifm-attachment-revision_v1.md) |
| 2026-11-21 | 用 FreeCAD 重跑 29 组位姿，验证新附件的 WS-IFM 六式并定位解算误差。 | [撤下记录](changes/2026-11-21-ifm-model-consolidation_v1.md#retired-ifm) · [变更日志](changes/2026-11-21-ws-ifm-attachment-freecad-validation_v1.md) |
| 2026-11-21 | 从 Level 1–3 资料核对 WS-IFM 机器常数校准项目、工位及报表参数。 | [机器常数校准项目](outputs/reports/WS-IFM%E6%9C%BA%E5%99%A8%E5%B8%B8%E6%95%B0%E6%A0%A1%E5%87%86%E9%A1%B9%E7%9B%AE_v1.md#core-calibrations) · [变更日志](changes/2026-11-21-ws-ifm-machine-constant-calibrations_v1.md) |
| 2026-11-21 | 用同一批 20 组 FreeCAD 读数逐组对比 WS-IFM v1 和 v2 的位姿解算及误差。 | [撤下记录](changes/2026-11-21-ifm-model-consolidation_v1.md#retired-ifm) · [变更日志](changes/2026-11-21-ws-ifm-v1-v2-freecad-comparison_v1.md) |
| 2026-11-21 | 将 WS-IFM v2 改为左右栏新旧对照，正文保留按 v1 参数定义的修正式。 | [撤下记录](changes/2026-11-21-ifm-model-consolidation_v1.md#retired-ifm) · [变更日志](changes/2026-11-21-ws-ifm-v2-side-by-side_v1.md) |
| 2026-11-21 | 按 v1 的参数定义重写 WS-IFM v2 主式，并验证参考点换算和转角二阶解算。 | [撤下记录](changes/2026-11-21-ifm-model-consolidation_v1.md#retired-ifm) · [变更日志](changes/2026-11-21-ws-ifm-v2-v1-symbols_v1.md) |
| 2026-11-21 | 补全 WS-IFM v2 的八项展开式，集中列出几何符号与 CAD 取值。 | [撤下记录](changes/2026-11-21-ifm-model-consolidation_v1.md#retired-ifm) · [变更日志](changes/2026-11-21-ws-ifm-v2-symbolic-expansion_v1.md) |
| 2026-11-21 | 展开 WS-IFM v2 的 X 解算式，并用 20 组 FreeCAD 光程复核等价性。 | [变更日志](changes/2026-11-21-ws-ifm-v2-x-expanded-formula_v1.md) |
| 2026-11-21 | 在 WS-IFM v2 内并列呈现 v1 原式和最新八路逐项公式。 | [撤下记录](changes/2026-11-21-ifm-model-consolidation_v1.md#retired-ifm) · [变更日志](changes/2026-11-21-ws-ifm-v2-formula-comparison_v1.md) |
| 2026-11-21 | 补充 WS-IFM 八路逐项解算，复用 20 组 FreeCAD 光程核对位姿及两个冗余差。 | [撤下记录](changes/2026-11-21-ifm-model-consolidation_v1.md#retired-ifm) · [变更日志](changes/2026-11-21-ws-ifm-sequential-eight-readouts_v1.md) |
| 2026-11-21 | 为 WS-IFM v2 添加逐式修正对照及 FreeCAD 六自由度位姿回读验证。 | [撤下记录](changes/2026-11-21-ifm-model-consolidation_v1.md#retired-ifm) · [变更日志](changes/2026-11-21-ws-ifm-freecad-six-dof-verification_v1.md) |
| 2026-11-21 | 核对当前 CAD 下的 IFM 原式，归档修正后的几何模型和数值验证。 | [撤下记录](changes/2026-11-21-ifm-model-consolidation_v1.md#retired-ifm) · [变更日志](changes/2026-11-21-ws-ifm-model-validation_v1.md) |
| 2026-11-21 | 将本机参考文献目录明确定为只读原始资料区。 | [资料规则](AGENTS.md#read-only-references) · [变更日志](changes/2026-11-21-reference-read-only_v1.md) |
| 2026-11-21 | 要求后续所有报告提供可点击的导航和相关内容链接。 | [报告导航规则](AGENTS.md#成果分类与报告导航) · [变更日志](changes/2026-11-21-report-navigation-requirement_v1.md) |
| 2026-11-21 | 按类型归档成果，并为报告添加章节导航与互跳链接。 | [成果索引](outputs/README.md) · [变更日志](changes/2026-11-21-output-organization_v1.md) |
| 2026-11-21 | 清理 WS-IFM 旧版图件，当前仅保留 v5。 | [撤下记录](changes/2026-11-21-ifm-model-consolidation_v1.md#retired-ifm) · [变更日志](changes/2026-11-21-ws-ifm-figure-cleanup_v1.md) |
| 2026-11-20 | 在 WS-IFM 模型 v1 的光路一节嵌入通用几何光路示意图。 | [ifm_model 的读数](outputs/reports/ifm_model.md#ifm-readout) · [变更日志](changes/2026-11-20-ws-ifm-model-figure_v1.md) |
| 2026-11-20 | 将 WS-IFM 三维图改为通用光路示意，以尺寸线标注模型几何参数。 | [撤下记录](changes/2026-11-21-ifm-model-consolidation_v1.md#retired-ifm) · [变更日志](changes/2026-11-20-ws-ifm-symbolic-layout_v1.md) |
| 2026-11-20 | 基于 v2 微调三维主视角，分开 X1 与 X3 的投影（图件已清理）。 | [变更日志](changes/2026-11-20-ws-ifm-cad-3d-view-fine-adjustment_v1.md) |
| 2026-11-20 | 撤回本次三维视角调整，恢复首版三维视图（图件已清理）。 | [撤回记录](changes/2026-11-20-ws-ifm-cad-3d-view-rollback_v1.md) |
| 2026-11-20 | 基于 FreeCAD 实体和光路绘制 WS-IFM 三维轴测图，补对侧视角显示 Z2 的 45° 镜面（图件已清理）。 | [变更日志](changes/2026-11-20-ws-ifm-cad-3d_v1.md) |
| 2026-11-20 | 按当次任务的语境和实际需求判断是否阅读 Level 1–3 资料。 | [协作规则](AGENTS.md#任务开始前的资料学习) · [变更日志](changes/2026-11-20-contextual-reference-reading_v1.md) |
| 2026-11-20 | 依据 FreeCAD 名义几何绘制 M 侧 WS-IFM 俯视与剖面，整理各通道的一阶光程观测式（图件已清理）。 | [变更日志](changes/2026-11-20-ws-ifm-cad-math_v1.md) |
| 2026-11-20 | 撤回并删除 Agent 绘制的 WS-IFM 几何布局图 v1–v4。 | [撤回记录](changes/2026-11-20-ws-ifm-layout-withdrawal_v1.md) |
| 2026-11-20 | 新增任务前阅读例外，用户下达当次特殊命令时可直接执行。 | [协作规则](AGENTS.md#任务开始前的资料学习) · [变更日志](changes/2026-11-20-pre-reading-exception_v1.md) |
| 2026-11-20 | 按手绘 Z–X 切面重绘 Z1/Z2 双路沿 X 的光路，并对齐 M/E 布局与框架镜俯视（图件已撤回）。 | [变更日志](changes/2026-11-20-ws-ifm-layout_v4.md) |
| 2026-11-20 | 修正 WS-IFM 布局与俯视图的测高轴向，两路改为沿 X/Y 分别入射并配套独立剖面（图件已撤回）。 | [变更日志](changes/2026-11-20-ws-ifm-layout_v3.md) |
| 2026-11-20 | 修订 WS-IFM 几何布局图，加入坐标系、X/Y 正交 Z 长镜、可见的 45° 镜面和平底剖面（图件已撤回）。 | [变更日志](changes/2026-11-20-ws-ifm-layout_v2.md) |
| 2026-11-20 | 重绘 WS-IFM 的测量侧与曝光侧布局，以及 X/Y 三束、Z1/Z2 折返光路（图件已撤回）。 | [变更日志](changes/2026-11-20-ws-ifm-layout_v1.md) |
| 2026-11-20 | 建立 WS-IFM 模型的优先查阅入口，整理六个方程、参数、标定关系及原式差异。 | [ifm_raw 原始模型](outputs/reports/ifm_raw.md) · [变更日志](changes/2026-11-20-ws-ifm-model_v1.md) |
| 2026-11-20 | 将任务结果的本机与 GitHub 同步纳入协作规则，补同步 TWINSCAN 测校项目清单。 | [测校项目清单 v2](outputs/reports/TWINSCAN%E6%B5%8B%E6%A0%A1%E9%A1%B9%E7%9B%AE%E6%B8%85%E5%8D%95_v2.md) · [变更日志](changes/2026-11-20-result-sync_v1.md) |
| 2026-11-20 | 建立 ME2 任务前资料学习要求，完成 Level 1–3 测校项目第一版清单。 | [清单登记与本机位置](changes/2026-11-20-calibration-inventory_v1.md) · [协作规则](AGENTS.md) |
| 2026-11-20 | 建立本机 Level 1–3 参考文献的 Markdown 索引、图像归档和逐页映射。 | [转换记录](changes/2026-11-20-reference-markdown_v1.md) · [资料使用规则](AGENTS.md) |
| 2026-11-20 | 建立本机工作目录、成果归档和引用规则，启用变更日志。 | [协作规则](AGENTS.md) · [变更日志](changes/2026-11-20-repository-setup_v1.md) |
| 2026-11-20 | 创建 ME2 仓库并加入初始 README。 | [初始提交](https://github.com/OpticsPan/ME2/commit/9a27ccd6e37b749446920a9a834a556353f6b5c0) |
