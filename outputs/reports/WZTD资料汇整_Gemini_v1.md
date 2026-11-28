# WZTD 测量侧 Z 干涉仪倾转依赖校准 · Level 1–3 资料汇整

> 产出方：Gemini ｜ 日期：2026-11-28 ｜ 版本：v1

[WZTD 第 7 章审阅稿](MEtrology-WZTD整理草稿_Gemini_v1.md#wztd) · [资料范围](#scope) · [死锁与有/无 CS 路线](#deadlock) · [测量方法与原文](#method) · [机器常数与证据边界](#constants) · [前后项目与排序差异](#sequence) · [原图核对与定位](#figures) · [关联章节 WZIM / WGIM](MEtrology.md#wzim) · [成果索引](../README.md)

<a name="scope"></a>

## 资料范围与检索口径

**WZTD** 在 Level 3 资料中的全称主要有以下写法：

- `WS Z tilt dependency, measure side [WZTD]`（L3-《12-TT-L3-L3-ME_book.pdf》文件第 60 页／印刷第 52 页）
- `WS Z Interferometer Tilt Dependency, measure [WZTD]`（L3-《TT-MA-ME_setupblock_1-5_1v3.ppt》第 81–82 张）
- `WS Z tilt dependency at measure (WZTD)`（L3-《07-TT-L3-LS-2v0.pdf》文件第 33 页／印刷第 27 页；L3-《TT-L3-LS-3v0.ppt》第 38 张）
- `WS Z-ifm tilt dependency (M)`（L3-《12-TT-L3-L3-ME_book.pdf》图 1.4、图 2.35；L3-《TT-MA-ME_setupblock_1-5_1v3.ppt》第 62、88 张）

本项目针对 **测量侧（M）**，对 **两个卡盘（Chuck 1、Chuck 2）** 分别校准 Z 干涉仪（Z-IFM）的倾转不变点（tilt point / tilt invariant position）及 Z 干涉仪模型中的姿态耦合参数，使水平传感器（LS）中心光斑 **M4** 与 **Z-IFM** 在晶圆台（WS）施加 Rx、Ry、Rz 倾转时对同一高度保持一致。曝光侧（E）的对应校准由第 8 设定块的 **WGTD**（WS XYZ Tilt Dependency at Expose）合并承担。

本次检索覆盖本机只读资料区 `D:\work\ME2\参考文献` 全部 Level 1–3 文档（共 103 份、7,902 页或幻灯片：L1 18 份／1,525 页、L2 50 份／2,588 页、L3 35 份／3,789 页）。逐页检索了 `WZTD`、`Z tilt dependency`、`Z-ifm`、`Z-IF`、`ELLA`、`ELGE`、`WGTD`、`ezxa`–`dzxza`、`wafer thickness`、`Confidence Sensor` 等关键词，并对全部关键原图与原 PDF 页面进行了逐页视觉核对。下表页码均从文件第 1 页起算，存在印刷页码差异时括号注明。

| 层级与原文件 | 页码／幻灯片与核对结论 |
| --- | --- |
| L1-《13_AP-L1-ME_rel_3.2.pdf》 | 文件第 17、24、61–68 页。旧版 rel.3.2 带置信传感器（CS）背景：第 17 页指出 CS 需先线性化并标定 XY 位置，再用于特定 Z-IFM 校准；第 24 页（Sequence 4/14）以 LS 中心光斑（M 侧）和 CS 点 A（E 侧）作高度参考；第 61–68 页讲 CS 版相对 Z-IFM 镜面图。L1 资料未单列无 CS 的 WZTD 专节。 |
| L2-《10-TT-L2-LS-module.pdf》、L2-《TT-L2-LS-3v0.pdf》、L2-《TT-PM-LS-3v1.pdf》 | 依次为文件第 28 页（印刷第 22 页）、第 28 页（印刷第 22 页）、第 34 页。在 Leveling Qualification 资质测试的 10 个子项中列出 **Tilt dependency (Spot position)**（检查 LS 是否与倾转无关），不保存 MC。L2 未给出 WZTD 的操作流程或维护程序号。 |
| L2-《TT-L2-ME-3v0.pdf》、L2-《TT_L2_ME_.pdf》 | 文件第 53–54 页（印刷第 47–48 页），图 2.7–2.8。阐明 Z 一致性（Z Consistency）的测量侧基本关系：`Wafer height with respect to the WS chuck = LS - Z-ifm`（晶圆相对卡盘高度等于 LS 读数减 Z-IFM 读数），以及曝光侧回放时仅靠 IFM 控台。 |
| L3-《12-TT-L3-L3-ME_book.pdf》 | **核心主证据。** 文件第 15–16 页（印刷第 7–8 页，图 1.4）给出中段右支路顺序；第 53–56 页（印刷第 45–48 页，图 2.35、2.36、2.39）详述 Z 倾转依赖死锁、有/无 CS 从相对标定转向绝对标定的原因及测量侧四步链；第 58–61 页（印刷第 50–53 页，图 2.41–2.45）依次覆盖前置 ELLA、**WZTD 专节（文件第 60 页／印刷第 52 页，图 2.44）** 与后置 ELGE；第 89–92 页（印刷第 81–84 页，图 2.83–2.86、表 2.2）给出曝光侧 WGTD 及 Z 模型 11 项姿态参数表。 |
| L3-《TT-MA-ME_setupblock_1-5_1v3.ppt》 | **核心配套课件。** 第 62–70 张系统图解 Sequence 4/8 与测量侧 Z 校准一致性四步递进（Start → BMAA → ELLA → WZTD → ELGE）；第 77–80 张讲 ELLA；**第 81–82 张为 WZTD 专节**（含讲义备注说明裸片多点测表观厚度、两卡盘分别执行、LS 保持高度恒定）；第 83 张讲 ELGE。 |
| L3-《07-TT-L3-LS-2v0.pdf》 | 文件第 31–37 页（印刷第 25–31 页，图 4.1–4.5）对比带 CS 与去 CS 后的 Z 倾转依赖设定链，给出旧版 CS 校准流程与图 4.1，并详述 ELLA 标定 `LS-AA (X)`、`LS-AA (Y)`；文件第 46–49 页（印刷第 40–43 页，图 4.7 及报表示例）详述 ELGE 如何以 WZTD 后的 M4 / Z-IFM 为倾转零点标定其余 8 光斑，并在验证表给出 `MAX abs dZ w.r.t. no tilt < 25 nm`。 |
| L3-《TT-L3-LS-3v0.ppt》 | 第 35–51 张。对应《07-TT-L3-LS-2v0.pdf》第 4 章的课件版，覆盖 Z 倾转依赖概览（第 36–38 张）、ELLA（第 39–42 张）、LS 线性化（第 43–45 张）及 ELGE 标定与验证报表（第 46–51 张）。 |
| L3-《TT-MA-ME_setupblock_6-8_1v3.ppt》 | 第 33–38 张（WGTD 专节）。第 33 张明确指出测量侧 Z 倾转依赖此前已由 WZTD 标定；**第 35 张讲义备注**给出晶圆厚度观测方程 `w = Ry Xs - Rx Ys + (Zs + h) - Z`（沿用 CS 时代符号说明）以及完整的 **Z-IFM 参数化模型方程**，并指出 `szxa`、`szya` 已由 WZIM 标定、`sfz` 由 TRIM 确定；**第 37 张讲义备注**给出 11 项 Z 姿态参数的复测 delta 规格参考。 |
| L3-《09-TT-L3-WSbook.pdf》、L3-《TT-MA-GD_Tempe.ppt》 | 前者文件第 76 页（印刷第 68 页，图 2.1）为早期全套设定表，列出第 43–47 项（WZIM、TRIM、CLPL、LS 线性化、LS 光斑位置），未单列 WZTD；后者第 115 张仅列出 WZIM/WGIM/CLPL/BMAA/BMWL 报告路径示例，未给出 WZTD 报告路径。 |

<a name="deadlock"></a>

## 死锁与有/无 CS 路线对比

### 1. 为什么存在 Z 倾转依赖“死锁”

L3-《12-TT-L3-L3-ME_book.pdf》文件第 53–54 页（印刷第 45–46 页）原文指出：

> “The basic problem is a dead lock in the tilt dependency calibration, but now dealing with the Z (Rx, Ry) dependence. The LS has to be made tilt dependent in order to be able to do accurate wafer height measurements. The Z IF has to be made tilt dependent in order to eliminate the WS height dependence on the WS tilt. It may be clear that an uncalibrated LS to determine the WS-Z tilt dependence cannot be used, nor can an uncalibrated Z interferometer model be used to calibrate the LS.”

**译文与解读：** 核心难题是 Z 对 Rx、Ry 倾转依赖校准中的“死锁”（注：原文此处 `made tilt dependent` 在上下文及图 2.36、第 60 页中均指“完成倾转依赖校准／消除未校准的倾转相关性”，即 `tilt independent`）。若 LS 测量光斑的水平位置未标定，WS 倾转时 LS 会测到假的高度变化；若 Z-IFM 模型的有效倾转点与姿态耦合未标定，WS 倾转时 Z-IFM 也会报出假的高度变化。因此，既不能用未标定的 LS 去标定 Z-IFM，也不能用未标定的 Z-IFM 去标定 LS。

从图 2.36（文件第 54 页／印刷第 46 页）可见：以测量侧 XY 坐标原点 `AA-X ≡ 0` 为参考轴，当台体绕 Y 倾转 `Ry` 时，位于参考轴左侧的 `LS-Mi` 与位于参考轴右侧的 `Z-IF` 各自观测到不同方向的高度变化（放大圆内 `LS` 与 `Z-IF` 箭头落点均偏离 `AA` 虚线），导致两者合成的表观高度随台体倾转而漂移。

### 2. 有 CS（相对标定）vs. 无 CS（绝对标定）

L3-《12-TT-L3-L3-ME_book.pdf》文件第 56 页（印刷第 48 页）与 L3-《07-TT-L3-LS-2v0.pdf》文件第 32–34 页（印刷第 26–28 页）对比了两种架构的根本区别：

| 对比维度 | 旧方案（带 CS，如 rel.3.2） | 新方案（去 CS，如 AT3.4） |
| --- | --- | --- |
| **标定性质** | **相对标定（relative）**：CSCM 误差与 CS 位置误差不可区分，M 侧与 E 侧虽都存在系统偏差，但在测高→曝光回放中相互抵消。 | **绝对标定（absolute）**：M 侧与 E 侧不再共用同类高度传感器，系统误差无法跨侧可靠抵消，两侧必须分别锚定到各自的绝对 XY 参考轴（M 侧为 AA，E 侧为投影镜头像面）。 |
| **M 侧依赖方向** | 先用 CSCM 标定 CS 位置 → 用 CS 中心点标定 M/E 两侧的 Z-IFM（`WS Z tilt dependency calibration`）→ 再用已标定的 Z-IFM 标定全部 9 个 LS 光斑。 | **方向反转**：先由 **ELLA** 用专用梯形斜坡工具片将 **LS 中心光斑 M4** 的 `(X, Y)` 直接锚定到“基准轴” AA → 再由 **WZTD** 以已锚定的 **LS-M4** 为高度参考，标定测量侧 **Z-IFM** → 最后由 **ELGE** 以已对齐的 Z-IFM / M4 标定其余 8 个 LS 光斑（M0–M3、M5–M8）。 |
| **E 侧对应项目** | 同一 CS 版 `WS Z tilt dependency calibration` 在曝光侧也用 CS 中心点定高并标定 E 侧 Z-IFM。 | 由第 8 设定块的 **WGTD**（WS XYZ Tilt Dependency at Expose）使用 TIS1/TIS2 扫描 RS 的 T1/T2 空间像，在曝光侧同时消除 X、Y、Z 对 Rx、Ry、Rz 的倾转依赖。 |

<a name="method"></a>

## WZTD 测量方法、原文摘录与译文

### 1. L3 ME 课本专节原文与译文

来源：L3-《12-TT-L3-L3-ME_book.pdf》文件第 60 页（印刷第 52 页），图 2.44。

- **Purpose 原文：**
  > “Calibrate Z interferometer tilt point and other interferometer parameters. Remove tilt dependency from Z so that LS and Z interferometer agree on constant height during tilts. The result will be that the LS and Z ifm measure the same position independent of applied tilts.”
  - **译文：** 校准 Z 干涉仪倾转点及其他干涉仪参数。消除 Z 读数的倾转依赖，使 LS 与 Z 干涉仪在台体倾转时对恒定高度保持一致。结果是无论施加何种倾转，LS 与 Z-IFM 测得的都是同一高度位置。
- **How 原文：**
  > “Use the center LS spot to measure Z and map LS tilt point to Z ifm tilt point. Because the LS is the Z reference for the measure side, its tilt invariant position must be defined. This position is found/determined by the stage in X and Y, applying various tilts (Rx, Ry, Rz in a range of 800□rad). At the XY position where the induced tilts don’t change the Z ifm position, the tilt invariant point has been found.”
  - **原文符号核查（已逐页查原 PDF 渲染图）：** 原 PDF 第 60 页印刷为 `800□rad`，其中 `□` 为原 PDF 缺失 Symbol 字体 `µ` 造成的缺字方框（MinerU OCR 漏识别为 `800rad`）。结合物理量级与同书第 91 页 WGTD 报告 `Rz Tilt Range: 0.800 [mrad]`（即 800 µrad），该处明确为 **800 µrad**。
  - **译文：** 使用中心 LS 光斑（M4）测量 Z，并将 LS 倾转点映射到 Z-IFM 倾转点。由于 LS 是测量侧的 Z 基准，必须确定其倾转不变位置。具体做法是在不同 X、Y 位置移动晶圆台并施加多种倾转（Rx、Ry、Rz，范围约 800 µrad）；在所施加倾转不引起 Z-IFM 高度读数变化的等效 XY 位置，即对应倾转不变点。
- **Why 原文：**
  > “• The height of the stage measured with the Z interferometer depends on the rotation and tilt of the stage. The Z ifm measurements must be made independent of this effect. This is important for AA measurements where the Z ifm is used to control the height of the marker. It is also important for LS measurements (wafer map) and for exposing the wafer at the expose position.
  > • Needed to be able to perform LS XY spot positions (ELGE), because this test tilts WS to find spot positions with respect to LS-M4 spot.”
  - **译文：** ① Z 干涉仪测得的晶圆台高度受台体旋转与倾转影响，必须消除该效应；这对 AA 测量（Z-IFM 用于控制标记高度）、LS 晶圆高度图（wafer map）测量以及曝光侧正确对焦曝光都至关重要。② 它是执行后续 LS XY 光斑位置校准（ELGE）的必要前提，因为 ELGE 正是通过倾转晶圆台来测定各光斑相对 LS-M4 的位置。

### 2. L3 Setup Block 1–5 课件原文与讲义备注

来源：L3-《TT-MA-ME_setupblock_1-5_1v3.ppt》第 69、81、82 张。

- **第 69 张：** `Step 3: WZTD: WS Z tilt dependency at measure — Calibrate Z interferometer model using LS M4 spot measuring height of bare wafer for various X, Y, Rx, Ry, Rz.`（译：第 3 步 WZTD：用 LS M4 光斑在裸片上测量不同 X、Y、Rx、Ry、Rz 下的高度，校准 Z 干涉仪模型。）
- **第 81 张正文与备注：**
  - 正文：`Desired situation is where Z ifm tilt point is on axis (AA). The LS position is already known, so now the Z ifm tilt point to LS tilt point needs to be mapped. Adjust Z-ifm model until LS heights are tilt invariant. Result: Z-ifm position (tilt invariant point) coincides with LS (effective) position.`
  - 讲义备注：`Method: the Level Sensor keeps the height of the wafer fixed, while at several points across the wafer the Z IFM height is measured at different settings of Rx, Ry, Rz. After this calibration the Z interferometer measurements (height and tilt of the WS) are independent on the rotation and tilt of the stage.`
- **第 82 张正文与备注：**
  > “• The test loads a wafer and at a number of points distributed over the whole wafer, the wafer thickness (Z ifm height) is measured under several combinations of stage tilts (Rx, Ry, Rz)
  > • The wafer thickness should be independent of the applied tilts.
  > • From the differences in the measured thicknesses, the required changes to the current Z interferometer model parameters can be calculated.
  > • This is done for both chucks.”
  - **译文：** 测试装载一片裸片，在分布于整片晶圆的多个 XY 点位上，于若干组台体倾转组合（Rx、Ry、Rz）下测量晶圆表观厚度（由 LS 维持片面高度不变时的 Z-IFM 高度读数）。物理上晶圆厚度不应随施加的倾转改变；由不同倾转下测得的厚度差值即可算出当前 Z 干涉仪模型参数所需的修正量。该过程对两个卡盘分别执行。
  - **备注补充：** 曝光侧须通过 WS XYZ 倾转依赖测试（WGTD）单独完成。

### 3. 旧版 CS 时代同类测试对照

来源：L3-《07-TT-L3-LS-2v0.pdf》文件第 32 页（印刷第 26 页），图 4.1。

- 在各个 XY 位置施加 `Rz` 旋转和 `Rx`、`Ry` 倾转；
- 在每个 XY 位置用 **CS 中心点** 保持晶圆高度恒定；
- Z-IFM 记录维持恒定 CS 高度所需的倾转与 Z 读数；
- CS 与 Z-IFM 读数之差反映 Z 干涉仪的倾转依赖，用于计算修正量并保存为 MC，使软件中 Z-IFM 的倾转不变点与 CS 位置重合（旧版在 M、E 两侧执行，新版 WZTD 仅在 M 侧以 LS-M4 替代 CS 中心点）。

<a name="constants"></a>

## 机器常数、Z 模型与证据边界

### 1. 直接证据与交叉引用的 Z-IFM 模型结构

L3 资料对 WZTD 本身明确给出了**更新对象性质**（测量侧双卡盘的 Z-IFM 倾转点与 Z-IFM 模型参数），但**未刊出测量侧 WZTD 的实机测试报告样张**。不过，同套 L3 课件《TT-MA-ME_setupblock_6-8_1v3.ppt》第 35、37、38 张讲义备注及《12-TT-L3-L3-ME_book.pdf》文件第 92 页（印刷第 84 页）图 2.86、表 2.2 完整给出了 **Z-IFM 参数化模型方程**、晶圆厚度观测关系和 11 项 Z 姿态耦合字段定义，并与本仓库存档的 [ifm_raw 原始模型](ifm_raw.md#z-ifm-原式) 及 [ifm_corr 修正模型](ifm_corr.md#corr-z) 完全同构：

- **表观厚度观测关系（L3-《TT-MA-ME_setupblock_6-8_1v3.ppt》第 35 张备注，沿用 CS 符号，M 侧对应 LS-M4）：**
  `w = Ry·Xs - Rx·Ys + (Zs + h) - Z`
  其中 `(Xs, Ys, Zs)` 为测高参考光斑位置（M 侧由 ELLA 标定的 LS-M4 相对 AA 的水平位置；Z 坐标由 WS 零位定义取 0），`h` 为测高传感器原始高度读数，`Rx, Ry, Z` 为 IFM 报告的台体位姿。L2-《TT-L2-ME-3v0.pdf》文件第 53 页简化写作 `Wafer height with respect to the WS chuck = LS - Z-ifm`。
- **Z-IFM 参数化模型（L3-《TT-MA-ME_setupblock_6-8_1v3.ppt》第 35 张备注；与《ifm模型.docx》第 4 页一致）：**
  `Z = sfz * (mz1 + szxa*X + szya*Y + X*Rx*Rz + ezxa*Rx + ezya*Ry + ezza*Rz + czxxa*X*Rx + czxya*X*Ry + czxza*X*Rz + czyya*Y*Ry + dzxxa*Rx^2 + dzyya*Ry^2 + dzzza*Rz^2 + dzxza*Rx*Rz)`
  同一备注明确指出：
  - `szxa`、`szya`（X/Y 行走倾斜）已由前序 **WZIM**（Initial Height and Tilt）标定；
  - `sfz`（Z 比例因子）由 **WS TRIM（WGIM）** 确定；
  - 其余 **11 项 Z 姿态耦合参数** 构成 Z-IFM 倾转依赖参数组（每卡盘一套），下表对照表 2.2 与第 37 张备注列出：

| 参数组别 | 字段名 | 耦合项 | 曝光侧 WGTD 报表单位（图 2.86） | 第 37 张备注复测 delta 规格参考 | 物理作用说明（结合表 2.2 与 `ifm_model.md`） |
| --- | --- | --- | --- | --- | --- |
| **一阶纯姿态项（3 项）** | `ezxa`, `ezya`, `ezza` | `Rx`, `Ry`, `Rz` | `µm`（备注写作 `mm`） | `0 – 0.01 mm`（10 µm） | 直接吸收 Z-IFM 有效倾转不变点相对参考轴（M 侧为 LS-M4/AA）的水平偏心及 Rz 串扰。 |
| **位置 × 姿态交叉项（4 项）** | `czxxa`, `czxya`, `czxza`, `czyya` | `X·Rx`, `X·Ry`, `X·Rz`, `Y·Ry` | `mrad` | `0 – 0.05 mrad` | 吸收随卡盘 XY 行程变化的倾转耦合（含 Z 折返光路随 X 移动的几何杠杆项 `czxya ≈ -1000 mrad`、固定顶镜扭曲与光束偏斜）。 |
| **二阶纯姿态项（4 项）** | `dzxxa`, `dzyya`, `dzzza`, `dzxza` | `Rx²`, `Ry²`, `Rz²`, `Rx·Rz` | `mm` | `0 – 10 mm` | 吸收 45° 折返光路余弦误差与刚体欧拉角二阶耦合非线性项。 |

### 2. 必须标明的证据边界与待核对项

1. **测量侧字段归属待实机报表确认：** 上述 11 个字段名及数值样张出自曝光侧 `WGTD` 报表（`wse_chuck1_if_model_parameters`，L3-《12-TT-L3-L3-ME_book.pdf》文件第 92 页）以及第 35/37 张备注（其中保留了 CS 时代 Z 倾转依赖的公式与复测容差）。测量侧 WZTD 实际写入的数据库参数组名（如是否对应 `wsm_chuck1_if_model_parameters`）、是否全部更新这 11 项、各字段单位与符号约定，**Level 1–3 未提供实机 WZTD 报表，标为待核对**。
2. **取点与倾转方案细节待核对：** L3 仅给出“分布于整片裸片的多个 XY 点”、“多种 Rx、Ry、Rz 组合”、“倾转范围 800 µrad（原 PDF 缺字印作 `800□rad`）”，未公开具体 XY 网格点数、单次角度档位、重复扫描次数、最小二乘拟合权重及软件输入界面截图。
3. **测试日志路径与 Coach 验收限值待核对：** L3-《TT-MA-GD_Tempe.ppt》第 115 张未收录 WZTD 路径；L2 教材未收录 WZTD 的 Coach 编号（`csme*.adj` / `.per`）。第 37 张备注中的 11 项 delta 规格附于 WGTD 报表页，用于复测一致性参考，不能未经核对直接当作各机型 WZTD 的正式 Coach 放行限值。
4. **原书印刷笔误记录：** L3-《12-TT-L3-L3-ME_book.pdf》文件第 16 页（印刷第 8 页）正文列表将中段右支路该项误印作 `WS Z interferometer tilt dependency, measure side (E)`，同书第 15 页图 1.4、第 53 页图 2.35 及课件《TT-MA-ME_setupblock_1-5_1v3.ppt》第 62、88 张均正确标注为 `WS Z-ifm tilt dependency (M)`，确认为原书文字笔误。

<a name="sequence"></a>

## 前后项目与跨文档排序差异

### 1. 设定块 4/8 中的实际执行顺序

依据 L3-《12-TT-L3-L3-ME_book.pdf》文件第 15、53 页（图 1.4、图 2.35）及 L3-《TT-MA-ME_setupblock_1-5_1v3.ppt》第 62、71 张，中段右支路（Sequence 4/8）严格按以下次序执行：

1. **前置基础（Block 1–3）：** 已完成 [SWZS](MEtrology.md#swzs) 初步归零、[WZIM](MEtrology.md#wzim)（标定 M 侧 `Z0, Ry0, szxa, szya`）、[WGIM / WS TRIM](MEtrology.md#wgim)、[CLPL](MEtrology-CLPL整理草稿_v1.md#clpl)、[BMAA](MEtrology-BMAA整理草稿_v6.md#bmaa)（建立 AA 为 M 侧 XY 原点）及粗版 [WTAF](MEtrology-WTAF整理草稿_v4.md#wtaf)。
2. **Block 4/8 内部前置：**
   - `WS TRIM`（复查 `srxa`，确认计量框架 Z 镜支承无漂移）；
   - `LS linearization`（线性化全部 9 个测量光斑及捕获光斑，保证 LS 高度读数线性）；
   - `BMWL coarse` & `BMWL fine`（标定晶圆装载偏置，使后续 ELLA 能够自动对准专用工具片）；
   - **`LS - AA offset [ELLA]`**（最直接前置：用带正交对准标记与 3 个蚀刻梯形斜坡的专用工具片，在 0°/180° 和 90°/270° 四个方位测量并保存 `LS-AA (X)`、`LS-AA (Y)` 两个 MC，将中心光斑 **LS-M4** 锚定至 AA 轴）。
3. **本项目：`WS Z-ifm tilt dependency (M) [WZTD]`**（在两个卡盘上分别将 Z-IFM 倾转不变点映射到已锚定的 LS-M4，并更新 Z-IFM 姿态模型参数）。
4. **直接后置：**
   - **`LS XY spot positions [ELGE]`**（用超平裸片在 IFM 闭环控制下施加 Rx、Ry 倾转，以 M4 / Z-IFM 为倾转不变原点测出其余 8 个 LS 光斑 M0–M3、M5–M8 相对 M4 的 X、Y、Z 偏置；原 L3 LS 报表示例中验证指标为 ±200 µrad 下 `MAX abs dZ w.r.t. no tilt < 25 nm`，`SPOT[4]` 保持不动）；
   - `Reference for TIS drift`（XVSA 九光斑扫描参考）。
5. **曝光侧对应（Block 5/8 与 Block 8/8）：** 左支路 Block 5/8 由 `BMWZ` / `BMTIS` 建立曝光侧 Z0/`szxa` 与镜头参考，Block 8/8 由 `WGTD` 完成曝光侧 XYZ-IFM 倾转依赖标定。

### 2. 跨文档排序表述差异核对

- **概念链 vs. 实机执行块顺序：** L3-《12-TT-L3-L3-ME_book.pdf》文件第 56 页（印刷第 48 页）在阐述全局 Z 一致性概念链时列为 `1. BMAA → 2. BMWZ → 3. ELLA → 4. WZTD → 5. ELGE → 6. WGTD`；其图 2.39 的四格编号跳过了第 2 步（标为 `Start / Step 1 ELLA / Step 3 WZTD / Step 4 ELGE`，而《TT-MA-ME_setupblock_1-5_1v3.ppt》第 66–70 张则补全为 `Start / Step 1 BMAA / Step 2 ELLA / Step 3 WZTD / Step 4 ELGE`）。此外，L3-《07-TT-L3-LS-2v0.pdf》文件第 33 页（印刷第 27 页）与 L3-《TT-L3-LS-3v0.ppt》第 38 张的概览框图将 `WZTD` 排在 `WS TRIM` 和 `LS spots linearization` 之前（且正文第 5、7 条重复写了 LS 线性化目的）。实际机台设定顺序以《12-TT-L3-L3-ME_book.pdf》图 1.4、图 2.35 及《TT-MA-ME_setupblock_1-5_1v3.ppt》第 62、71 张的 Block 4/8 完整流程为准（先 TRIM、LS 线性化、BMWL、ELLA，再 WZTD、ELGE）。

<a name="figures"></a>

## 关键原图核对与本机定位

以下本机定位路径均相对只读目录 `D:\work\ME2\参考文献\Markdown_v1/`；涉及原 PDF 渲染核查的页面另在当前工作区临时目录 `work/source_pages/` 逐页人工审阅确认。

| 来源层级、原文件、页码与图号 | 原图核心视觉证据 | 本机图像相对路径 |
| --- | --- | --- |
| L3-《12-TT-L3-L3-ME_book.pdf》文件第 15、53 页（印刷第 7、45 页），图 1.4、图 2.35 | 标明中段设定块左右两支路；右支路（Sequence 4/8）自上而下严格为 `WS TRIM → LS linearization → BMWL coarse → BMWL fine → LS-AA offset → WS Z-ifm tilt dependency (M) → LS XY spot pos → Reference for TIS drift`。 | `assets/37317c0531c59e0e/images/page_52_image_6_v1.jpg` |
| L3-《12-TT-L3-L3-ME_book.pdf》文件第 54 页（印刷第 46 页），图 2.36 | 剖面对比水平（蓝）与绕 `AA-X ≡ 0` 倾转 `Ry`（红）的卡盘与晶圆。左侧 `LS-Mi X` 与右侧 `Z-IF X` 均偏离 `AA` 虚线；右圆放大清晰展示两者在倾转下呈现相反方向的高度变化。 | `assets/37317c0531c59e0e/images/page_53_image_4_v1.jpg` |
| L3-《12-TT-L3-L3-ME_book.pdf》文件第 56 页（印刷第 48 页），图 2.39 | 四步演进图：Start 时 `Z-IF`（左）与 `LS-M4`、`LS-Mi`（右）都偏离 `AA` 虚线；Step 1 ELLA 把 `LS-M4` 移到 `AA` 线上；Step 3 WZTD 把 `Z-IF` 箭头移至与 `LS-M4` 同轴重合在 `AA` 线上；Step 4 ELGE 标定 `M0–M8` 全部光斑。 | `assets/37317c0531c59e0e/images/page_55_image_16_v1.jpg`（及全局 6 步链 `page_55_image_7_v1.jpg`） |
| L3-《12-TT-L3-L3-ME_book.pdf》文件第 60 页（印刷第 52 页），图 2.44；L3-《TT-MA-ME_setupblock_1-5_1v3.ppt》第 82 张 | 3D 晶圆台镜块（可见 45° 倒角）承载裸片（虚线十字）；上方红箭头表示 LS 中心光斑 M4 测高，两侧折线表示 Z-IFM 经 45° 斜面的折返光路；标出施加 `Rx`、`Ry`、`Rz` 三轴倾转。原 PDF 文本确证 `800□rad` 缺字对应 `800 µrad`。 | `assets/37317c0531c59e0e/images/page_59_image_14_v1.jpg`、`assets/c9af45c9eb25c12e/images/page_81_image_2_v1.jpg` |
| L3-《12-TT-L3-L3-ME_book.pdf》文件第 61 页（印刷第 53 页），图 2.45；L3-《07-TT-L3-LS-2v0.pdf》文件第 46 页（印刷第 40 页），图 4.7 | 展示 WZTD 后的直接下游 ELGE：以中心 `Zero Z_IF`（与 M4 重合）为不动轴，施加 `Rx` 或 `Ry` 倾转时，偏离轴心的各蓝色光斑因 `offset` 产生 `Height variation`，由此反算各光斑坐标。 | `assets/37317c0531c59e0e/images/page_60_image_8_v1.jpg`、`assets/f4bceaf9c8a8c568/images/page_45_chart_6_v1.jpg` |
| L3-《07-TT-L3-LS-2v0.pdf》文件第 32–33 页（印刷第 26–27 页），图 4.1 及有/无 CS 对比图 | 图 4.1 展示旧版带 CS 时的 3D 测高（蓝箭头为 CS 中心光斑，橙线为含 45° 折返的 IFM 光束，绕 Rx/Ry/Rz 倾转）；第 33 页两幅流程图直观对照旧版（含 CS）与新版（标出 `NEW` 的 BMWZ/ELLA/WGTD 与 `Changed` 的 WZTD）。 | `assets/f4bceaf9c8a8c568/images/page_31_image_13_v1.jpg`、`page_32_image_3_v1.jpg`、`page_32_image_20_v1.jpg` |
| L3-《12-TT-L3-L3-ME_book.pdf》文件第 92 页（印刷第 84 页），图 2.86、表 2.2 | 给出曝光侧 WGTD 的 23 项参数报表与释义，其中后 11 项（`ezxa`–`dzxza`）完整对应 Z-IFM 姿态耦合项及量级参考（如 `czxya ≈ -1001.56 mrad`）。 | `assets/37317c0531c59e0e/images/page_91_table_20_v1.jpg` |

[返回顶部](#scope) · [进入 WZTD 第 7 章审阅稿](MEtrology-WZTD整理草稿_Gemini_v1.md#wztd) · [WS-IFM 机器常数总表](WS-IFM机器常数校准项目_v4.md#mc-wztd)
