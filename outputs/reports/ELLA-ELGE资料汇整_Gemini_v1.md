# ELLA 与 ELGE 水平传感器光斑位置校准 · Level 1–3 资料汇整

> 产出方：Gemini ｜ 日期：2026-11-28 ｜ 版本：v1

[审阅草稿与四步串联](MEtrology-ELLA-ELGE与测量侧Z一致性整理草稿_Gemini_v1.md#ella-elge-chain) · [资料范围](#scope) · [ELLA 证据与实机报表](#ella-evidence) · [ELGE 证据与实机报表](#elge-evidence) · [同机串联核对（Machine 3909）](#machine-3909) · [辅助前置 ELLN 与验证 ELFP](#elln-elfp) · [关键原图核对](#figures) · [关联 WZTD 汇整](WZTD资料汇整_Gemini_v1.md#scope) · [关联 BMAA 汇整](BMAA资料汇整_v1.md#l3) · [成果索引](../README.md)

<a name="scope"></a>

## 资料范围与检索口径

本汇整围绕测量侧水平传感器（LS）的两项核心光斑位置校准——**ELLA** 与 **ELGE**——以及二者与 **BMAA**、**WZTD** 构成的测量侧 Z 一致性四步标定链展开：

- **ELLA（LS to AA spot position calibration / LS-AA offset calibration）**：测量侧（M），**卡盘无关**（单卡盘执行，测量计量框架上固定测头之间的相对矢量）。使用带正交对准标记（Orthobox，4×XPA）和 3 个梯形斜坡（trapezoid ramps）的专用工具片，在 0°/180° 与 90°/270° 四个方位将 **LS 中心光斑 M4** 的水平坐标 `(X, Y)` 锚定到高级对准传感器 **AA**，更新 `LS-AA (X)` 与 `LS-AA (Y)` 两个机器常数（M4 的 Z 坐标按 WS 零位坐标系定义为 0）。
- **ELGE（LS spot position calibration / LS XY spot positions）**：测量侧（M），**卡盘无关**（单卡盘装载 1 片超平裸片 Lensqual Wafer）。在 WZTD 已把 Z-IFM 倾转不变点对齐到 M4/AA 之后，于 IFM 闭环控台下施加 Rx、Ry 倾转（±200 µrad），测出其余 8 个测量光斑（M0–M3、M5–M8）相对中心光斑 M4 的水平坐标（X、Y）及同点测高的垂向偏置（Z），而 M4 本身保持以 ELLA 锚定为基准不变。

本次全文检索覆盖本机只读参考库 `D:\work\ME2\参考文献` 全部 103 份 Level 1–3 资料（7,902 页/张：L1 18 份／1,525 页、L2 50 份／2,588 页、L3 35 份／3,789 页），逐页检索 `ELLA`、`ELGE`、`LS-AA`、`LS to AA`、`trapezoid`、`orthobox`、`spot position`、`Lensqual`、`ELLN`、`ELFP`、`ZMF-mirror` 等关键词，并渲染原 PDF 关键页（`07-TT-L3-LS-2v0.pdf` 文件第 35–38、46–49 页及 `12-TT-L3-L3-ME_book.pdf` 第 53–61 页）做逐字与逐图核对。页码均从文件第 1 页起算，括号内为印刷页码。

| 层级与原文件 | 页码／幻灯片与核对结论 |
| --- | --- |
| L1-《13_AP-L1-ME_rel_3.2.pdf》 | 文件第 17、24 页。第 17 页指出 LS 必须先线性化并标定各光斑的 XYZ 位置；第 24 页说明在早期带 CS 架构下，先用 LS 中心零输出作基准，LS 线性化与光斑位置标定放在后段。L1 资料未展开无 CS 时代的 ELLA 专节。 |
| L2-《10-TT-L2-LS-module.pdf》、L2-《TT-L2-LS-3v0.pdf》、L2-《TT-PM-LS-3v1.pdf》 | 依次为文件第 28 页（印刷第 22 页）、第 28 页（印刷第 22 页）、第 34 页。在 Leveling Qualification（对应 L3 的 ELFP）10 项子测试中列出 **Linearity** 与 **Tilt dependency (Spot position)**（检查 LS 是否与倾转无关，不保存 MC）。 |
| L3-《07-TT-L3-LS-2v0.pdf》 | **核心主证据（最完整细节与实机报表）。** 文件第 31–33 页（印刷第 25–27 页）对比有/无 CS 设定链；**第 34–38 页（印刷第 28–32 页，图 4.2–4.5）详述 ELLA 原理、专用工具片料号、操作步骤、输入屏、结果屏与完整报表 `ELLA.21`**；第 39–45 页（印刷第 33–39 页）详述 LS 线性化（`ELLN`）；**第 46–49 页（印刷第 40–43 页，图 4.7）详述 ELGE 原理、输入参数、XY/Z 标定与验证完整报表 `ELGE.08`**；第 50–51 页（印刷第 44–45 页）给出 `ELFP` 性能验证第 8 子项（±200 µrad 倾转检验 `LS - IF = 0`）。 |
| L3-《TT-L3-LS-3v0.ppt》 | 第 35–52 张。对应《07-TT-L3-LS-2v0.pdf》第 4 章的课件版：第 36–38 张讲 Z 倾转依赖链，第 39–42 张讲 ELLA，第 43–45 张讲 LS 线性化，第 46–52 张讲 ELGE 标定与验证报表及放行阈值标注。 |
| L3-《12-TT-L3-L3-ME_book.pdf》 | **设定块串联主证据。** 文件第 15–16 页（印刷第 7–8 页，图 1.4）与第 53–56 页（印刷第 45–48 页，图 2.35、2.36、2.39）阐明 BMAA → ELLA → WZTD → ELGE 的测量侧绝对标定逻辑；**第 58–60 页（印刷第 50–52 页，图 2.41–2.43）讲 ELLA**；第 60 页（印刷第 52 页，图 2.44）讲 WZTD；**第 61 页（印刷第 53 页，图 2.45）讲 ELGE**；第 45 页（印刷第 37 页）提及无 TIS2 V3 载板机台在 AA 对焦测试中亦借用同一片 ELLA 工具片。 |
| L3-《TT-MA-ME_setupblock_1-5_1v3.ppt》 | 第 62–71 张系统图解 Sequence 4/8 与测量侧四步演进（Start → BMAA → ELLA → WZTD → ELGE）；**第 77–80 张讲 ELLA**；第 81–82 张讲 WZTD；**第 83 张讲 ELGE**。 |
| L3-《04-TT-L3-ATS-AA-2v0.pdf》 | 文件第 106 页（印刷第 100 页）。确认 ELLA 专用工具片（300 mm 料号 `4022.486.1257*`，200 mm 料号 `4022.486.1258*`）同时也是未安装 TIS2 V3 载板机台执行 AA 长短标记聚焦/阿贝臂校准的共用工具片。 |
| L3-《09-TT-L3-WSbook.pdf》 | 文件第 76 页（印刷第 68 页，图 2.1）第 46、47 项依次列出 `LS Linearity calibration`、`LS Spot position cal.`。 |

<a name="ella-evidence"></a>

## ELLA 证据与实机报表详解

### 1. 目的与定位（原文摘录与译文）

来源：L3-《07-TT-L3-LS-2v0.pdf》文件第 34 页（印刷第 28 页）；L3-《12-TT-L3-L3-ME_book.pdf》文件第 58、60 页（印刷第 50、52 页）。

- **Purpose 原文（LS 课本 p. 34）：**
  > “For the middle spot M4, the relative position (horizontal: x, y) is calibrated relative to Advanced Alignment (AA). The horizontal spot position is defined as the tilt independent focus points... In the new scenario, the level sensor will be used to calibrate the WS Z interferometer model at the measure side (the other way around). This means, that another way to make the level sensor tilt independent had to be developed. This has been done by means of the new LS to AA spot position offset (ELLA) test (the AA sensor position is the holy reference at the measure side). This test only calibrates the XY spot position (and with that, the tilt dependency) of the central level sensor spot M4.”
  - **译文：** 针对中心光斑 M4，校准其相对高级对准传感器（AA）的水平相对位置（x、y）。水平光斑位置定义为倾转不变的聚焦点。在去 CS 的新方案中，反过来要用 LS 校准测量侧的 WS Z 干涉仪模型，因此必须开发新方法先使 LS 自身倾转无关——这就是 ELLA 测试（AA 传感器位置是测量侧的绝对参考基准）。ELLA 仅校准中心光斑 M4 的 XY 位置（从而消除其倾转依赖）。
- **为何只标定 X、Y 不标定 Z（ME 课本 p. 60）：**
  > “Note that only the LS (M4) X,Y position is measured because the Z position is 0 by WS zero co-ordinate system definition.”
  - **译文：** 仅测量 LS（M4）的 X、Y 位置，因为按晶圆台零位坐标系定义，M4 的 Z 位置恒为 0（由 WZIM 确立 M4 零输出即测量侧高度零基准）。
- **更新的 2 个机器常数：** `LS-AA (X)` 与 `LS-AA (Y)`（实施为写入 XY 坐标系的水平偏置）。

### 2. 专用工具片与测量步骤（原文核对）

来源：L3-《07-TT-L3-LS-2v0.pdf》文件第 34–36 页（印刷第 28–30 页），图 4.2–4.3；L3-《12-TT-L3-L3-ME_book.pdf》文件第 59–60 页（印刷第 51–52 页），图 2.41–2.43；L3-《TT-MA-ME_setupblock_1-5_1v3.ppt》第 77–80 张。

- **专用工具片（Tool Wafer）：**
  - 300 mm 料号：`4022.486.1257*`（`LS/AA NO-CS Cal. Wafer 300mm`）；200 mm 料号：`4022.486.1258*`。200 mm 与 300 mm 片的标记、编号和梯形斜坡布局一致。
  - **片面结构（见图 4.2、图 2.41）：** 含缺口（Notch）、正交对准标记（Orthobox marks，由 4 个 XPA 标记组成），以及关于晶圆中心对称并排的两条带状区——一条为 **Profile Area / Sloped area**（内有沿主轴排布的 3 个蚀刻/沉积梯形斜坡 `Trapezium 1、2、3`），另一条平行区域为 **Reference area**（超平裸硅参考区）。梯形斜坡与 AA 正交标记之间的设计几何距离精确已知。
- **完整执行步骤（综合 LS 课本 p. 35–36 与 ME 课本 p. 59–60）：**
  1. **选定卡盘并装片至 0° 方位**（如 `ELLA.21` 选 `Chuck 1`，从 `Slot 25` 装载）。
  2. **AA 晶圆对准**：用 Athena AA 扫描片上 Orthobox 对准标记，建立精确的晶圆坐标网格，从而获知 3 个梯形斜坡在当前 AA 坐标系下的理论精确位置。
  3. **LS-M4 扫描斜坡区与参考区**：默认用中心光斑 `LS-M4` 执行 **36 次扫描、每次 600 个采样点**（实机报表 `ELLA.21` 显示首条扫描沿 X 从 `x = -87.000 mm` 到 `x = +83.000 mm`，`y = -22.000 mm`，倾转均为 `0.000 mrad`），先后测得斜坡区与参考区轮廓。
  4. **卸片旋转 180° 重装并重复测量**：晶圆转 180° 后，原本的 **超平参考区** 恰好落到 0° 时 **梯形斜坡区** 所处的同一卡盘与镜面位置（反之亦然）。
  5. **交叉相减消除台体镜面与片形系统误差**：
     - 用 `0° 斜坡区` 减去 `180° 参考区`；
     - 用 `180° 斜坡区` 减去 `0° 参考区`。
  6. **梯形斜坡线性拟合与中点提取（见图 2.42、图 4.3）**：对每个梯形的上升坡（`B1`）与下降坡（`B2`），在 **25% 至 75% 高度区间** 做直线拟合，求出 **50% 高度处** 对应的坐标（`x_B1`、`x_B2` 或 Y 向的 `y_B1`、`y_B2`）；将同一梯形的上升坡与下降坡中点取平均（消除光斑尺寸与梯形顶宽偏差），再将 0° 与 180° 结果取平均，得到该轴向的 `LS-AA` 偏置。
  7. **90° 与 270° 旋转重复上述流程**：两条平行带转为沿 Y 方向，同理测得另一轴向偏置 `LS-AA (Y)`（注：LS 课本 p. 36 步骤列表写 `y-coord.` 而 ME 课本 p. 59 写 `X-coordinates`，二者分别对应 90°/270° 测 Y 与 0°/180° 测 X，实机 `ELLA.21` 扫描起点 `x = -87 → +83 mm, y = -22 mm` 印证 0°/180° 沿 X 扫出 `LS-AA (x)`）。
  8. **统计筛选与保存 MC**：软件对 3 个梯形做统计检验并自动剔除异常梯形；满足验收指标后保存 `LS-AA (X)` 与 `LS-AA (Y)`。

### 3. 实机测试报表与验收规格（`ELLA.21`）

来源：L3-《07-TT-L3-LS-2v0.pdf》文件第 37–38 页（印刷第 31–32 页，已通过原 PDF 渲染图 `LS_2v0_p37.png`、`LS_2v0_p38.png` 逐字核对）。

- **报告头信息：** 机台 `Machine: 3909`（机型 `1250D`），软件 `Release: 3.3.8`，日期 `10/02/2004 19:43`，耗时 `00:09:41`（Precondition 1m46s / Measure 7m20s / Evaluate 14s / Postcondition 19s），报告路径 `TM/LevelSensorT/LevelSensorLS/CalibLS/ELLA.log/ELLA.21`，数据文件 `service_data/EL/ELLA/ELLA21.dat`，状态 `Machine Constants: Saved`。
- **关键实测数值与自动剔除示例：**

| 指标 | Trapezium 1 | Trapezium 2（已剔除） | Trapezium 3 | 最终保存 MC（T1 与 T3 均值） | 原有 MC（Old） | 验收规格 |
| --- | ---: | ---: | ---: | ---: | ---: | --- |
| `Mean x` [µm] | `547.528` | `580.143` | `542.795` | **`545.161`** | `552.710` | `< 1000 µm`（1 mm） |
| `Mean y` [µm] | `-76.258` | `-75.331` | `-78.621` | **`-77.440`** | `-78.709` | `< 1000 µm`（1 mm） |
| `3*SD x` [µm] | `0.017` | `0.012` | `0.013` | — | — | `< 15 µm` |
| `3*SD y` [µm] | `0.048` | `0.108` | `0.026` | — | — | `< 15 µm` |
| 梯形判定状态 | `RESULT_OK` | `RESIDU_SLOPE_UP_OUT_OF_SPEC` | `RESULT_OK` | `Excluded Trapezium: Trapezium2` | — | 异常梯形自动剔除 |

> **原 PDF 核对注记：** ① 图 4.5 截图红框标注及《TT-L3-LS-3v0.ppt》第 42 张将 `µm` 因缺字体误印为 `[mm]`、`<15mm`、`<1000mm`，同页正文与第 38 页报表均明确单位为 **`µm`**（`< 15 µm`、`< 1000 µm`）。② 原报表第 38 页底部的 `Differences Between Trapeziums` 表中 `x`/`y` 两列数值与上方 `Mean x`/`Mean y` 差值互换（如 `|580.143 - 547.528| = 32.615` 印在了 `y` 列），属原机台报表表头错位。③ 原页底部两行（MinerU OCR 遗漏）明确写明 `Excluded Trapezium: Trapezium2` 及 `Calibration Test Result: Success, values not within limits`。

<a name="elge-evidence"></a>

## ELGE 证据与实机报表详解

### 1. 目的、原理与输入设置（原文摘录与译文）

来源：L3-《07-TT-L3-LS-2v0.pdf》文件第 46–47 页（印刷第 40–41 页），图 4.7；L3-《12-TT-L3-L3-ME_book.pdf》文件第 61 页（印刷第 53 页），图 2.45；L3-《TT-MA-ME_setupblock_1-5_1v3.ppt》第 83 张。

- **Purpose 原文（LS 课本 p. 46）：**
  > “The spot position is defined as the tilt independent focus position of each of the individual spots. For the nine measurements spots, the relative positions (x,y,z) with respect to the center spot (M4) is calibrated. The calibration procedure for the Level Sensor determines where the horizontal tilt invariant axis of each measure spot of the Level Sensor lies. By introducing a tilt to the chuck, the offset of the spot with respect to the interferometer position will result in a height variation as a function of the applied tilt (see figure 4.7). The tilt can be applied in both Rx and Ry directions and measured with all spots. With this procedure it is possible to extract the horizontal position of the spots w.r.t. the horizontal position of the interferometer.”
  - **译文：** 光斑位置定义为每个独立光斑倾转不变的聚焦位置。对于 9 个测量光斑，校准它们相对中心光斑（M4）的相对位置（x、y、z）。通过给卡盘施加 Rx 和 Ry 倾转，某光斑相对干涉仪倾转轴的水平偏置会导致其高度读数随倾转角线性变化；所有光斑同步测得该高度变化，即可提取各光斑相对干涉仪（在 WZTD 后即与 M4/AA 重合）的水平坐标。
- **How 与 Why 原文（ME 课本 p. 61）：**
  > “How: Tilt the wafer stage in Rx under interferometer control while keeping the XY position constant and measure the LS spots height variation; this determines the Y coordinate for every spot separately. Similarly for Ry to find the X-coordinates (see figure 2.45).
  > Why: The LS spots are not positioned perfectly in a straight line, as shown in the above figure. This means that different wafer tilts would result in different height measurements. Therefore the exact spot positions must be known. The WS Z ifm calibration must have been done so that the Z ifm tilt point coincides with the AA axis (same as LS-axis after ELLA). This further implies that the AA set-up has been done.”
  - **译文：** 在干涉仪闭环控制下保持台体 XY 恒定，绕 Rx 倾转晶圆台并测量各 LS 光斑的高度变化，由此分别确定每个光斑的 Y 坐标；同理绕 Ry 倾转确定 X 坐标。由于 9 个 LS 光斑并非严格排在一条直线上，不同晶圆倾角会造成高度测量误差，因此必须精确知道各光斑位置。此测试要求前序已完成 WZTD，使 Z-IFM 倾转点与 AA 轴（即 ELLA 后的 LS-M4 轴）重合，这也进一步意味着 AA 前序标定必须已完成。
- **Z 向光斑偏置测量（LS 课本 p. 48–49）：**
  - 在完成 XY 标定后，通过十字扫描（User Input：`numXCrossHairPositions = 15`，`numYCrossHairPositions = 15`，`crossHairXRange = 25.000 mm`，`crossHairYRange = 25.000 mm`），让每个光斑测量 **同一片面物理位置**（*“each spot measures on the same location of the wafer and the delta w.r.t. the M4 spot (dZ) is measured”*），在扣除外部依赖项（`zeroing/waferwedge tilt` 归零与晶圆楔角倾角、`LS to ZMF-mirror tilt` LS 相对计量框架 Z 镜的整体倾角、`dRy non parallelism ZMF-mirrors`）后，确定各光斑相对 M4 的垂向偏置 Z。
- **耗材与默认输入参数（LS 课本 p. 46–47 报表 `ELGE.08`）：**
  - 前置耗材：`1 Bare Ultra-flat Lensqual Wafer`（1 片超平裸片）。
  - 关键参数：`Capture = ROBUST`，`Calibrate X/Y/Z = TRUE`，`Verify X/Y/Z = TRUE`，`tiltRangeRx = 200.000 µrad`，`tiltRangeRy = 200.000 µrad`，`numMeasRxScans = 25`，`numMeasRyScans = 25`，`numXCrossHairPositions = 15`，`numYCrossHairPositions = 15`，`crossHairXRange/YRange = 25.000 mm`。

### 2. 实机测试报表与验收规格（`ELGE.08`）

来源：L3-《07-TT-L3-LS-2v0.pdf》文件第 46–49 页（印刷第 40–43 页，已通过原 PDF 渲染图 `LS_2v0_p46.png`–`LS_2v0_p49.png` 逐项核对）。

- **报告头信息：** 机台 `Machine: 3909`，`Release: 3.3.8`，日期 `02/10/2004 21:16`，报告路径 `TM/LevelSensorT/LevelSensorLS/CalibLS/ELGE.log/ELGE.08`，数据文件 `ELGE.dat`。
- **9 光斑实测标定与验证数据汇总：**

| 光斑 | X New [µm] | X 相对 M4 [µm] | X 3σ [µm] | Y New [µm] | Y 相对 M4 [µm] | Y 3σ [µm] | Z New [nm] | Z 3σ [nm] | 验证 dZ (−Ry/+Ry) [nm] | 验证 dZ (−Rx/+Rx) [nm] | 验证 Z 相对 M4 [nm] |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | --- | --- | ---: |
| `M0` | `13846.20` | `+13301.57` | `3.78` | `-74.31` | `+1.39` | `3.04` | `-110.46` | `11.25` | `-0.99 / +2.44` | `+0.16 / +0.07` | `-1.98` |
| `M1` | `10693.03` | `+10148.41` | `4.03` | `-71.90` | `+3.80` | `3.57` | `-94.39` | `6.14` | `-0.33 / +2.43` | `+2.01 / +0.14` | `+0.81` |
| `M2` | `7308.50` | `+6763.88` | `4.01` | `-67.20` | `+8.50` | `2.38` | `-68.52` | `5.37` | `-0.84 / +0.47` | `+1.62 / -2.01` | `+0.96` |
| `M3` | `3929.30` | `+3384.68` | `3.14` | `-72.25` | `+3.45` | `3.58` | `-15.03` | `3.27` | `-2.33 / -0.49` | `-1.04 / -2.07` | `+0.44` |
| **`M4`** | **`544.62`** | **`0.00`** | `3.26` | **`-75.70`** | **`0.00`** | `2.37` | **`0.00`** | `0.00` | `----` | `----` | `----` |
| `M5` | `-2834.19` | `-3378.81` | `4.13` | `-80.96` | `-5.26` | `2.81` | `+9.23` | `3.93` | `+1.24 / +1.73` | `+3.27 / +1.51` | `-0.24` |
| `M6` | `-6234.72` | `-6779.34` | `3.68` | `-82.84` | `-7.14` | `2.79` | `+11.10` | `6.63` | `-0.24 / -1.14` | `+1.45 / -1.12` | `-1.15` |
| `M7` | `-9599.22` | `-10143.84` | `3.15` | `-91.12` | `-15.42` | `2.83` | `-69.02` | `7.51` | `-0.88 / +0.54` | `-2.74 / +0.57` | `-1.91` |
| `M8` | `-12944.42` | `-13489.04` | `3.72` | `-82.50` | `-6.80` | `3.81` | `-110.46` | `13.83` | `-1.75 / -1.02` | `+0.63 / -1.03` | `-1.98` |

- **验收规格总览（LS 课本 p. 47–49）：**
  - XY 光斑标定精度：`Spot accuracy maximum 3 sigma < 17.50 µm`；水平转角 `Horizontal rotation (Rz0) deviation < ±4000.00 µrad`（实测 `Rz0 = 305.80 µrad`，PASS）。
  - Z 光斑标定：`Vertical spot position deviation < 500.00 nm`，`Spot accuracy maximum 3 sigma < 25.00 nm`。
  - XY 倾转验证（应用新偏置后复测 ±200 µrad 倾转下的表观厚度变化 `dZ`）：`MAX abs dZ w.r.t. no tilt < 25.00 nm`（实测全部在 `-2.74 ~ +3.27 nm` 内，PASS）。
  - Z 同点验证（扣除 `LS to ZMF-mirror tilt = -0.94 µrad` 后相对 M4 高度差）：`Vertical Spot position deviation w.r.t. M4 MAX < 25.00 nm`（实测全部在 `-1.98 ~ +0.96 nm` 内，PASS）。
  - 测量与系统误差比例：`MAX <= 10.00%`（实测全部 `0.00%`，PASS）。

<a name="machine-3909"></a>

## 同机串联实证（Machine 3909，Release 3.3.8）

核对《07-TT-L3-LS-2v0.pdf》第 37–38 页 `ELLA.21` 与第 46–49 页 `ELGE.08` 两份实机报表，发现它们来自 **同一台机台（Machine 3909，Release 3.3.8）在同一天先后相隔约 1.5 小时执行的真实设定记录**，直接印证了 `ELLA → WZTD → ELGE` 的数值一致性：

1. **旧常数完全吻合：** `ELLA.21`（19:43）的 `Old Machine constant` 为 `LS-AA (x) = 552.710 µm`、`LS-AA (y) = -78.709 µm`；`ELGE.08`（21:16）中 `M4` 的 `Old` 列恰好为 `552.71 µm`、`-78.71 µm`。
2. **ELLA 与 WZTD 后倾转实测高度一致：** `ELLA.21` 用梯形工具片直接相对 AA 测出 `LS-AA (x) = 545.161 µm`、`LS-AA (y) = -77.440 µm`；经 WZTD 把 Z-IFM 倾转点对齐到 M4 后，`ELGE.08` 在倾转中测得 `M4` 的 `New` 值为 `544.62 µm`、`-75.70 µm`，与 ELLA 结果仅差 `0.54 µm`（X）和 `1.74 µm`（Y），均处于该测点 `3σ`（`3.26 / 2.37 µm`）测量不确定度范围内。
3. **M4 作为绝对锚点保持固定：** 在 `ELGE.08` 全部 XY/Z 标定与验证表中，`M4 / SPOT[4]` 的 `Relative` 恒为 `0.00`、`Z` 恒为 `0.00 nm`、判定列均为 `----`——印证 ME 课本第 56 页所言“ELGE 仅标定除 M4 外的 8 个光斑，M4 保持不变”。
4. **9 光斑几何实态：** 9 斑沿 X 间距约 `3.38 mm`，总跨度 `26.79 mm`（覆盖 26 mm 扫描狭缝）；沿 Y 呈折线错动（相对 M4 偏移 `-15.42 ~ +8.50 µm`，整排转角 `Rz0 = 305.80 µrad`）；沿 Z 呈两端略低约 `110 nm` 的温和弯曲，印证了原图 2.45“各光斑并非排在一条直线上”的物理判断。

<a name="elln-elfp"></a>

## 辅助前置 ELLN（LS 线性化）与资质验证 ELFP

- **LS 线性化（ELLN，L3-《07-TT-L3-LS-2v0.pdf》文件第 39–45 页／印刷第 33–39 页）：**
  - 在设定块 4/8 中位于 WS TRIM 之后、BMWL / ELLA / WZTD / ELGE 之前。用 2 片超平裸片（每卡盘 1 片），在固定 `(X, Y, Rx, Ry, Rz)` 下控制 WS 沿 Z 步进扫描，采集原始 LS（`AC/DC`）与 Z-IFM 读数，对 9 个测量光斑做 **5 阶多项式加权最小二乘拟合**（伺服通路为 3 阶，捕获光斑为 1 阶增益）。
  - 范围与指标：线性区 `±1.25 µm`（最大残差 `< 10 nm`）、修复区 `±2.0 µm`（`< 20 nm`）、伺服区 `±2.5 µm`（增益误差 `< 15%`）、捕获区 `±2.5 µm`（原书第 39 页印 `±2.5 µm`，第 51 页 ELFP 子项 9 及课件第 43 张另写捕获范围 `±250 µm`，待按对应软件版本核对）。
  - **对串联逻辑的作用：** 因为 ELLA 扫梯形斜坡、WZTD 测表观厚度变化以及 ELGE 倾转测 9 光斑高度变化都不再仅工作在“单点回零（LS = 0）”，而是直接读取 LS 的连续高度值，所以必须先经 `ELLN` 将 9 光斑线性化。
- **LS 性能资质验证（ELFP，L3-《07-TT-L3-LS-2v0.pdf》文件第 50–51 页／印刷第 44–45 页）：**
  - **Subtest 8（Spot position and tilt dependency performance test）**：在 M4 上完成晶圆捕获后将台体倾转 `±200 µrad`，读取全部 9 光斑输出，理想结果应满足 `LS - IF = 0`。对应 L2 教材中 Leveling Qualification 的 `Tilt dependency (Spot position)` 子项，用于生产或维护期复核整条 `ELLA → WZTD → ELGE` 校准链是否漂移（不保存 MC）。

<a name="figures"></a>

## 关键原图核对与本机定位

以下相对路径均以只读资料区 `D:\work\ME2\参考文献\Markdown_v1/` 为根。

| 来源层级、原文件、页码与图号 | 原图核心视觉证据 | 本机图像相对路径 |
| --- | --- | --- |
| L3-《07-TT-L3-LS-2v0.pdf》文件第 35 页（印刷第 29 页），图 4.2；L3-《12-TT-L3-L3-ME_book.pdf》文件第 59 页（印刷第 51 页），图 2.41 | ELLA 专用工具片布局：0° 时含缺口、Orthobox（4×XPA）对准标记，以及关于晶圆中心对称平行的 Reference area（超平裸硅）与 Profile/Sloped area（3 个梯形斜坡）；旋转 90°/270° 后两带转为竖直测 Y 偏置。 | `assets/f4bceaf9c8a8c568/images/page_34_image_4_v1.jpg`、`assets/37317c0531c59e0e/images/page_58_image_5_v1.jpg` |
| L3-《07-TT-L3-LS-2v0.pdf》文件第 35 页，图 4.3；L3-《12-TT-L3-L3-ME_book.pdf》文件第 59 页，图 2.42 | 梯形斜坡轮廓处理原理：对上升坡 `B1` 与下降坡 `B2` 在 **25%–75%** 高度窗口做直线拟合，提取 **50%** 高度坐标 `y_B1`、`y_B2` 并取中点 `Δy_B`。 | `assets/f4bceaf9c8a8c568/images/page_34_image_9_v1.jpg`、`assets/37317c0531c59e0e/images/page_58_image_15_v1.jpg` |
| L3-《12-TT-L3-L3-ME_book.pdf》文件第 60 页（印刷第 52 页），图 2.43 | 90° 与 270° 两次装片测 Trapezium 3 的对称示意：旋转 180° 后斜坡区与参考区互换空间位置，对平均距离与 AA 对准位置求差即得 Y 向 LS-AA 偏置。 | `assets/37317c0531c59e0e/images/page_59_image_6_v1.jpg` |
| L3-《07-TT-L3-LS-2v0.pdf》文件第 36–37 页（印刷第 30–31 页），图 4.4、4.5 | ELLA 软件 Basic Settings 输入屏（单选 Chuck 1/2，非双卡盘）与 Result 屏（注：图中红框把 `µm` 误印为 `mm`，正文与报表确证为 `µm`）。 | `assets/f4bceaf9c8a8c568/images/page_35_image_14_v1.jpg`、`page_36_image_5_v1.jpg` |
| L3-《07-TT-L3-LS-2v0.pdf》文件第 46 页（印刷第 40 页），图 4.7；L3-《12-TT-L3-L3-ME_book.pdf》文件第 61 页（印刷第 53 页），图 2.45 | ELGE 倾转测光斑位置原理：9 个蓝色光斑呈轻微折线分布，中心位于 `Zero Z_IF`（与 M4 重合）；施加 `Rx` 或 `Ry` 倾转时，各光斑相对中心轴的 `offset` 引起 `Height variation`，由此反算各自坐标。 | `assets/f4bceaf9c8a8c568/images/page_45_chart_6_v1.jpg`、`assets/37317c0531c59e0e/images/page_60_image_8_v1.jpg` |
| L3-《12-TT-L3-L3-ME_book.pdf》文件第 54、56 页（印刷第 46、48 页），图 2.36、2.39 | 完整展示测量侧 Z 一致性死锁与 `Start → ELLA → WZTD → ELGE` 四格演进（配套 `TT-MA-ME_setupblock_1-5_1v3.ppt` 第 66–70 张含 Step 1 BMAA）。 | `assets/37317c0531c59e0e/images/page_53_image_4_v1.jpg`、`page_55_image_16_v1.jpg` |

[返回顶部](#scope) · [进入审阅草稿与四步逻辑串联](MEtrology-ELLA-ELGE与测量侧Z一致性整理草稿_Gemini_v1.md#ella-elge-chain) · [WZTD 资料汇整](WZTD资料汇整_Gemini_v1.md#scope) · [BMAA 资料汇整](BMAA资料汇整_v1.md#l3)
