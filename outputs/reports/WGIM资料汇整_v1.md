# WGIM Level 1–3 资料汇整 v1

[项目定位](#scope) · [实机流程](#method) · [机器常数](#constants) · [版本与前置](#sequence) · [原图定位](#source-figures) · [WZIM 正文](MEtrology.md#wzim) · [WS-IFM 项目清单](WS-IFM机器常数校准项目_v4.md#mc-wgim)

<a name="scope"></a>

## 项目定位和层级

WGIM 的章节名为 **Wafer Stage Tilt Rotation Interferometer Matrix（WS TRIM）**。WGIM 用 IFM 内部的两组冗余角度确定三类修正：Rz 对 Rx/Ry 的倾角依赖、Rz 对 XY 走位的依赖、Z 链测得的 Ryz 和 X 链测得的 Ryx 之间的线性位置差。范围为两卡盘、两工位，参数随卡盘和侧别分别确定。

| 层级与原文件 | 页码与图号 | 与 WGIM 的关系 |
| --- | --- | --- |
| L1-《13_AP-L1-ME_rel_3.2.pdf》 | 文件第 17、22 页 | 第 17 页列 M/E 两侧 IFM 模型和镜面残差。第 22 页说明 WS 初始化倾角与归零偏置。 |
| L1-《06_AP-L1-Imaging_Overlay.pdf》 | 文件第 44 页，第 44 张 | Rotation scaling 示例。非平行光束使 WS 沿 X 移动时出现线性 xRz。 |
| L2-《12-TT-L2-ME-module.pdf》 | 文件第 39–40 页（印刷第 31–32 页） | Coach csme072.adj。列前置、5×5 网格、17 组姿态、测量字段、各项参照和联合模型。 |
| L2-《TT-L2-ME-3v0.pdf》 | 文件第 37、57–59 页（印刷第 31、51–53 页），图 1.41、3.1 | 2006 年理论与 Coach csme072.per 验证说明。前置条件转引本机 Coach。另一个同主题 L2 转换《TT_L2_ME_.pdf》也列出验证用途和同组动作。 |
| L2-《12-TT_L2_ME_2v3new.pdf》 | 文件第 29 页，第 57–58 张 | csme072.per 是季度维护的镜架漂移检查，也列在 Metrology 实验项目。 |
| L3-《12-TT-L3-L3-ME_book.pdf》 | 文件第 14–15、23–24、30–33、54–55、57 页（印刷第 6–7、15–16、22–25、46–47、49 页） | 初设顺序、三类效应、镜面全局取向与局部曲率的分工、复查 srxa。 |
| L3-《TT-MA-ME_setupblock_1-5_1v3.ppt》 | 第 10、19–27、71 张 | 名义高度与 Ry 的前置、两卡盘两侧、三类原理、后续 CLPL 和复查。 |
| L3-《TT-MA-ME_setupblock_6-8_1v3.ppt》 | 第 35、42 张及备注 | 第 35 张将 Z 比例 sfz 归于 TRIM。第 42 张将余下 X 向相对抛物项归于 Combined FOCAL。 |
| L3-《09-TT-L3-WSbook.pdf》 | 文件第 76 页（印刷第 68 页），图 2.1，第 43–45 项 | Type-2 full setup 中 WZIM → WS trim test → Fiducial levelling。 |
| L3-《07-TT-L3-LS-2v0.pdf》及《TT-L3-LS-3v0.ppt》 | 前者文件第 33 页（印刷第 27 页），后者第 38 张 | 有、无 Confidence Sensor 的 LS 校准链都用 WS TRIM 改善 IFM 模型。 |
| L3-《TT-MA-GD_Tempe.ppt》 | 第 115 张 | 诊断交接表以 WGIM 标识项目的测试记录和日志。 |

<a name="method"></a>

## 实机流程证据

1. **测量组。** L2 两份主资料都记载 5×5 XY 网格覆盖晶圆区域。每点依次施加 17 组 Rz、Rx/Ry、Z 的组合，并测 X、Y、Z、Rx、Ryx、Ryz、Rzx、Rzy。这八个是台体坐标解算量。条件允许时 M/E 两侧的卡盘可并行测量。17 组幅值、采样时序和稳定条件需按对应 Coach 查证。见 L2-《12-TT-L2-ME-module.pdf》文件第 39 页，L2-《TT-L2-ME-3v0.pdf》文件第 58 页。
2. **比较 Rz。** Rzx 从 X 干涉仪得到，Rzy 从 Y 干涉仪得到。按 L2-《12-TT-L2-ME-module.pdf》文件第 40 页，走 X 或加 Ry 时使 Rzx 向 Rzy 对齐，走 Y 或加 Rx 时使 Rzy 向 Rzx 对齐。镜面不平会扰动这些参照，资料假定镜面平整度足够。实机用位置与倾角观测在同一个数学模型中估计三类效应。
3. **比较 Ry。** Ryx 由 X 组三束与同一侧镜测得，Ryz 来自两路 Z 测量光及参考光。沿 X 走位时，固定 Z 镜相对倾斜引入随 X 变化的 Ryz。以系统误差较小的 Ryx 为参照，校正 Ryz 相对 Ryx 的一阶 X 依赖。实机 Ry 控制用 Ryx，Ryz 进入 Z 测量与控制。见 L3-《12-TT-L3-L3-ME_book.pdf》文件第 31–32、57 页，L3-《TT-MA-ME_setupblock_1-5_1v3.ppt》第 24–25、71 张。
4. **核对结果。** 两份 L2 主资料都给出 OK/NOK。结果均在规格内时结束。超限处理写明保存 MC 后复测确认修正。具体报表的保存状态用来判定实机是否写入。Coach 的有效版本、当前与候选字段及验收阈值需按机台查询。

<a name="constants"></a>

## 机器常数与适用范围

| 证据支持的输出 | 依据与读法 |
| --- | --- |
| Rzx、Rzy 的 Rx/Ry 倾角耦合与 XY 位置耦合项 | 资料给出各效应、参照和联合建模用途。确切 MC 字段待核对应 WGIM 报表。L2-《12-TT-L2-ME-module.pdf》文件第 40 页，L3-《12-TT-L3-L3-ME_book.pdf》文件第 30–31 页。 |
| srxa | X 对 Ryz 的一阶贡献。再跑时复查此参数以判断计量框架镜支承漂移。L3-《12-TT-L3-L3-ME_book.pdf》文件第 57 页（印刷第 49 页），L3-《TT-MA-ME_setupblock_1-5_1v3.ppt》第 71 张。 |
| sfz | Z 解算的尺度系数。L3-《TT-MA-ME_setupblock_6-8_1v3.ppt》第 35 张 WGTD 备注追溯为 TRIM 已求得。分离尺度的实验步骤和拟合式待核对应版本报表。 |
| Ryz 的 Y 向范围 | L3 原书文件第 32 页的概述写 X 和 Y，课件第 25 张及原理图具体写 X。X 项有具名 srxa，Y 向字段与范围待核目标版本报表。 |

<a name="sequence"></a>

## 初始设定、维护与下游

- **初始设定。** 先 WZIM 确定名义台高和 Ry，继而 WGIM，最后 CLPL 测 TIS 等基准板的高度与倾角。CLPL 需要在多个 XY 位置测高，前两项让 Z 模型先达到足以测量的粗水平。完成 WGIM 也满足 Spot Sensor Position 的前置，之后依次做 RS rotation/position offset 和 Reticle Load Offset。见 L3-《12-TT-L3-L3-ME_book.pdf》文件第 14–15、23–24、30、33 页，L3-《TT-MA-ME_setupblock_1-5_1v3.ppt》第 10、19、27 张。
- **复查和维护。** L3 设定序列 4/8 再跑的重点是 srxa。L2 2005 年 .adj 资料在后期验证语境列 BMAA/BMWL/BMTIS Fine、WS 非正交与比例、绝对台格与 Combined FOCAL 为前置。2006 年 .per 版指向适用的 Coach 细则。见 L2-《12-TT-L2-ME-module.pdf》文件第 39 页，L2-《TT-L2-ME-3v0.pdf》文件第 58 页，L3-《12-TT-L3-L3-ME_book.pdf》文件第 57 页。
- **曲率残差。** L3 ME book 文件第 54–55 页区分镜面全局取向与局部曲率。书中无 CS 的设定由 TRIM 配合后续 Combined FOCAL。文件第 32 页图 2.13 是运行 WZIM、WGIM 后的示例高度图，此时 LS 各光斑高度偏置未校，图中还可见曲率。结合光斑偏置和后续焦面校准解读。

<a name="source-figures"></a>

## 原图定位

原图路径以本机 D:\work\ME2\参考文献\Markdown_v1 为起点。页码依次为文件页、印刷页。

| 原文件及页码 | 原图 | 图中能确认的物理信息 | 本机路径 |
| --- | --- | --- | --- |
| L3-《12-TT-L3-L3-ME_book.pdf》文件第 30 页（印刷第 22 页） | 2.9 | X/Y 两组上束落在相邻台镜面，束高差使 IFM 感知的旋转轴偏离台坐标轴。 | assets/37317c0531c59e0e/images/page_29_image_11_v1.jpg |
| 同书文件第 31 页（印刷第 23 页） | 2.10 | 对照理想及束高不同时的绕 Y 激励。 | assets/37317c0531c59e0e/images/page_30_image_5_v1.jpg |
| 同书文件第 31 页（印刷第 23 页） | 2.11 | 右半展示上束在 XY 内不平行时的 X 位移与 Rz。书中指出左半曝光图形方向画反。 | assets/37317c0531c59e0e/images/page_30_image_9_v1.jpg |
| 同书文件第 32 页（印刷第 24 页） | 2.12 | 两固定 Z 镜不平行。底部五笔粗黑线的局部角度表示 Z-IFM 随 X 走位测到的 Ry，五笔的高度还表现出弯曲。 | assets/37317c0531c59e0e/images/page_31_image_5_v1.jpg |
| 同书文件第 32 页（印刷第 24 页） | 2.13 | WZIM、WGIM 后的示例高度图，仍可见 LS 光斑偏置和曲率。 | assets/37317c0531c59e0e/images/page_31_image_11_v1.jpg |
| L2-《TT-L2-ME-3v0.pdf》文件第 59 页（印刷第 53 页） | 3.1 | 用五个位置展示顶镜相对角度对 Ryz 的线性影响。 | assets/e9dff352e800b276/images/page_58_image_11_v1.jpg |

[WS-IFM 清单的 WGIM 条目](WS-IFM机器常数校准项目_v4.md#mc-wgim) · [成果索引](../README.md)
