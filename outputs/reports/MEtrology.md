# MEtrology 校准项目报告

[项目目录](#calibration-index) · [本报告的整理范式](#report-format) · [WS-IFM 校准清单](WS-IFM机器常数校准项目_v4.md#initial-zero) · [成果索引](../README.md)

<a name="report-format"></a>

## 本报告的整理范式

以下范式仅适用于 `MEtrology.md` 收录的校准项目。

1. **Purpose（目的）**。说明项目要解决什么问题、为什么要做、执行前需满足哪些条件，以及完成后可以开展哪些校准项目。列出本项目涉及校准的机器常数及其用途。
2. **How（操作流程）**。先按源文完整翻译具体操作流程，保留原有步骤顺序、操作条件和原文列出的注意事项及判据，并注明来源及页码。译文之后，根据对流程的理解绘制带编号的示意图，解释各步骤如何衔接。
3. **Principle（校准原理）**。具体说明测量基准和物理原理，解释校准如何由观测量得到机器常数。资料中有相关物理原图时，将原图附在本节正文并注明来源层级、原文件名、页码和图号。

### 章节、图表与公式编号

- **章节**。每个校准项目独立成节，按目录顺序编号。
- **图、表与公式**。在每节内分别按「章节号.序号」编号，各自从 1 开始。例如第 1 节的第一张图、第一张表和第一条公式分别记为图 1.1、表 1.1 和式（1.1）。正文与图中重复出现的同一公式共用编号。引用资料中的图、表或公式时保留来源编号。
- **图内编号**。原理图和示意图中的关键模块、模组和子图应标注编号，如 `（1）`、`（2）`。正文或图注可按「图 1.2（1）」直接指向具体对象。
- **公式排版**。图内公式使用 LaTeX 或等效数学排版渲染，分式、上下标、矩阵等按数学格式呈现。

### 来源标注

引用 Level 1–3 的文档或原图时，在文件名前标注所属层级，例如 `L1-《文件名.pdf》`、`L2-《文件名.pdf》`、`L3-《文件名.ppt》`。非 Level 1–3 的来源标为「外部资料」。

<a name="calibration-index"></a>

## 项目目录

| 项目 | 定位 | 快速跳转 |
| --- | --- | --- |
| [1. SWZS — WS 初步归零](#swzs) | 建立晶圆台干涉仪启用时的六自由度参考 | [Purpose](#swzs-constants) · [How](#swzs-procedure) · [Principle](#swzs-principle) · [初始零位测量原理](#swzs-voltage-to-zero) · [资料汇整](SWZS资料汇整_v1.md) |

<a name="szws"></a>
<a name="swzs"></a>

## 1. SWZS — WS 初步归零

[Purpose](#swzs-constants) · [How](#swzs-procedure) · [Principle](#swzs-principle) · [灵敏度矩阵标定图](#swzs-gain-calibration-figure) · [怎样用 PSD 找回参考位姿](#swzs-psd-reference-recovery) · [回波峰定位图](#swzs-ifm-peak-location) · [多路 IFM 工作区间](#swzs-ifm-common-working-window) · [Level 1–3 资料汇整](SWZS资料汇整_v1.md)

<a name="szws-constants"></a>
<a name="swzs-constants"></a>

### Purpose（目的）

**要解决的问题。** SWZS（Calibrate Zero Sensor）校准晶圆台（WS）的零传感器，让干涉仪（IFM）在启用时有一个可重复找回的六自由度参考。装片或换台时，卡盘会离开 IFM 控制范围。回到量程时，编码器先把台带到捕获区，固定在计量框架（MF）上的零传感器找回参考位姿。IFM 加载这组坐标后，从该位置继续跟踪位移。原理见[图 1.3](#swzs-voltage-to-zero)。出处为 L1-《09_AP-L1-Production_Metrology_in-line.pdf》第 13、24 页及 L2-《TT-L2-ME-3v0.pdf》文件第 10–11、19 页（印刷第 4–5、13 页）。

**何时做。** TWINSCAN 初始设定或更换零传感器系统部件后进行完整校准。测量侧（M）和曝光侧（E）各有一套零传感器，分别对两个卡盘的镜块校准，共四种组合。设备初始化时出现快归零问题，可按适用流程独立运行 Update FZP。下述软件流程来自 WS Type-2、rel.3.4 培训教材。出处为 L3-《09-TT-L3-WSbook.pdf》文件第 73、111–115 页（印刷第 65、103–107 页）。

<a name="swzs-prerequisites"></a>

#### 前置条件

L3-《09-TT-L3-WSbook.pdf》文件第 111 页（印刷第 103 页）列五项条件。

1. 已完成基座（BF）校准。
2. 空气支承（AM）已开启并处于稳定状态。
3. 已完成卡盘交换校准 SWSW。
4. 已完成干涉仪调整与诊断试验 SWHP。多路信号不满足条件时的诊断关系见[图 1.6](#swzs-ifm-common-working-window)。
5. 已完成差分传感器校准 SWDC。

L3-《TT-MA-WS-Calibrations-3v1.ppt》第 100–101 张给出相同条件。课件列无需额外工具，预计 30 分钟。

#### 完成后可以开展的项目

- **计量设定。** 获得初始化参考后，计量设定图列出两条支路。对准支路做 BMAA 粗校、精校。晶圆台支路按 [WZIM 测量侧初始高度与倾角](WS-IFM机器常数校准项目_v4.md#mc-wzim) → [WGIM／WS TRIM](WS-IFM机器常数校准项目_v4.md#mc-wgim) → CLPL 基准板调平依次进行。两支路满足条件后再做 AA 光束倾角与焦点，继而做 M 侧 WS XY 干涉仪校准和 BMAA 精校。见 L3-《12-TT-L3-L3-ME_book.pdf》文件第 14–15 页（印刷第 6–7 页），图 1.3。
- **晶圆台服务测试。** 课件把已完成零传感器校准列为 SWCR 范围检查和 SWSM 短行程电机校准的前提之一。见 L3-《TT-MA-WS-Calibrations-3v1.ppt》第 79、144、211 张。
- **生产中的使用。** M 侧装片归零后可进入 Stage Align，由 LS 和 AA 读取 TIS 基准。E 侧换台归零后进入掩模对准或条件性的批次校正。这里常见的平移约 1 µm、转角约 ±2.5 µrad 是生产归零的参考量级。见 L1-《09_AP-L1-Production_Metrology_in-line.pdf》第 13–14、23–26、49 页及 L2-《TT-L2-ME-3v0.pdf》文件第 10–14、19 页（印刷第 4–8、13 页）。

#### 机器常数及用途

**表 1.1　SWZS 机器常数与中间量**

| 机器常数或中间量 | 物理含义 | 归属和报表核对 |
| --- | --- | --- |
| **Zero Sensor Gain Matrix** | 三只位置敏感器件（PSD）各有 `u`、`v` 电压。记下每路对六自由度的局部灵敏度和串扰。 | 每组合 6×6。示例报表按 PSD 列 `du/dX`、`dv/dRy` 等，单位为 V/m 或 V/rad。 |
| **零传感器电压零偏** | 三只 PSD 各自的 `u0/v0`。单位 V。 | 示例报表分列 `MI:zero sensor offset voltages` 与六轴 `Zero Sensor Offset`。 |
| **ZSO** | 零传感器偏置（Zero Sensor Offset），用六自由度位姿量表示。 | 直线轴用 m，角度轴用 rad。作为计算快归零位置的一组输入。 |
| **FZP** | 快归零位置（Fast Zero Position），用于初始化时的快归零捕获。 | 完整 PSD 校准会重新确定。独立 `Update FZP` 模式按基座（BF）偏置修正。 |
| **MI:SZP** | 台体零位（MI:Stage Zero Position，步骤中写作 `MISZP`）。对应切换到 IFM 控制时赋给台体的六自由度参考值。 | 报表字段为 `X/Y/Z/Rx/Ry/Rz`。L2-《TT-L2-ME-3v0.pdf》图 1.5 给出的参考值可以是非零。 |
| **PSD positions in baseframe coordinates** | 三只 PSD 对应的基座坐标位姿。 | 示例逐只 PSD 列出六轴、`found`、`intens.ok`、`electr.ok`。 |
| **Rx0、Ry0、Rz0** | 相关的初始化倾角，用 IFM 回波强度选取合适的镜块姿态。 | WS Initialization Tilts 资料按两卡盘 × 两工位分组。M 侧 `Ry0` 可由后续 WZIM 重定。 |
| **OZP** | 用粗增益和实测中心算出的中间位置。 | 用于第二轮增益标定，再参与 FZP 计算。 |

机器常数名称与单位见L3-《09-TT-L3-WSbook.pdf》第 111–115 页（印刷第 103–107 页），图 2.34–2.35。初始化倾角与 WZIM 更新关系见L3-《12-TT-L3-L3-ME_book.pdf》第 26–29 页（印刷第 18–21 页）及L3-《TT-MA-ME_setupblock_1-5_1v3.ppt》第 9–10 张。

<a name="szws-procedure"></a>
<a name="swzs-procedure"></a>

### How（操作流程）

<a name="swzs-how-translation"></a>

#### 原文流程译文

下列为 L3-《09-TT-L3-WSbook.pdf》文件第 112–115 页（印刷第 104–107 页）中测试软件顺序、注意事项、输入界面和结果说明的译文。前一页列出的五项[前置条件](#swzs-prerequisites)已在 Purpose 完整列出。软件顺序与 L3-《TT-MA-WS-Calibrations-3v1.ppt》第 104 张互证。

**测试软件顺序**

<a name="swzs-how-first-step"></a>

1. 执行干涉仪对准（IF Align）。
2. 设置默认值。
3. 初始化设备，直至短行程（SS）进入由 IFM 反馈控制的六自由度状态。
4. 寻找零传感器的中心位置。
5. 以干涉仪为参照，校准零传感器增益。
6. 用已标定的粗增益重新寻找零传感器中心。
7. 检查以下项目。
   - 零传感器光强及电子学。
   - HP 干涉仪和差分传感器的量程。
   - 零传感器的光束位置。
8. 用零传感器增益和零传感器中心计算 `OZP`。
9. 利用 `OZP` 再次校准零传感器增益。
10. 校准零传感器偏置。
11. 用 `OZP` 和零传感器偏置计算 `FZP`。
12. 用 `FZP` 计算零传感器位置。
13. 计算 `MISZP`。

**注意事项**

- 运行 PSD Calibration 时，更新机器常数后需复做部分计量设定。
- 运行 Update FZP 时，更新机器常数后需复做基座和晶圆搬运系统校准。

**输入界面**

原图 2.33 展示输入界面。从图中可见，测试由用户可选的三个部分组成。

**表 1.2　SWZS 输入模式（译文）**

| 模式 | 原文说明译文 |
| --- | --- |
| **IFM-align** | 单独执行时，只做检查。 |
| **PSD Calibration** | 执行完整校准。它包含 IFM-align，因此选中 PSD Calibration 时无法取消选中 IFM-align。完整校准会重新确定 FZP，因此此时不能选中 Update FZP。 |
| **Update FZP（Fast Zero Position）** | 按基座偏置修正 FZP。此模式下 IFM-align 和 PSD Calibration 都不能选中。 |

**结果说明**

原图 2.34 和印刷第 107 页的图 2.35 给出一份示例报告。报告中可看到上述机器常数。报告末尾还列出许多中间结果，示例中未展示。

<a name="swzs-procedure-diagram"></a>

#### 流程图与报告核对

![图 1.1，按原文 13 步分段的 SWZS 校准流程](../images/SWZS归零校准流程_v4.png)

**图 1.1　SWZS 操作流程与生产使用。** 图 1.1（1）对应原文步骤 1–3，建立 IFM 测量。图 1.1（2）对应步骤 4–7，找中心、标定粗增益并检查信号和量程。[图 1.1（3）](#swzs-how-ozp-and-gain)对应原文步骤 8–10，求 `OZP`、复测增益与标定偏置。[图 1.1（4）](#swzs-how-fzp-and-szp)对应步骤 11–13，计算 `FZP`、传感器位置及 `MI:SZP`。图 1.1（5）说明标定结果在生产时的用途。按 L3-《09-TT-L3-WSbook.pdf》文件第 112 页（印刷第 104 页）绘制。

**软件原文第 3、4 步。** 第 3 步让短行程进入 IFM 六轴反馈，建立后续标定所用的实际运动基准。第 4 步寻找零传感器中心，给随后的粗增益标定定位工作区域。可理解为在 IFM 能跟踪 WS 运动时，移动台体并观察三只 PSD 的 `u/v` 电压，找到光斑中心附近的响应。软件实际采用的找中心方法未在该页详述。见 L3-《09-TT-L3-WSbook.pdf》文件第 112 页（印刷第 104 页）。

<a name="swzs-how-ozp-and-gain"></a>

##### 图 1.1（3）用 OZP 复测增益并标定偏置

这一步接收第 5 步得到的粗增益和第 6 步重新定位的零传感器中心。目标是确定第二轮增益标定所用的位置，并得到下一段计算快归零位置所需的偏置。

- **原文第 8 步，求 `OZP`。** 用粗增益和零传感器中心确定中间工作位姿。可用[式（1.5）的局部逆关系](#swzs-eq-pose-difference)理解这一操作：比较当前六路电压和中心参考电压，再用粗增益估计 WS 距离中心还差多少平移和转角。图中曲线只画出一路电压随位姿变化，实际标定用三只 PSD 的六路电压。
- **原文第 9 步，用 `OZP` 复测增益。** 以这个工作位姿为基准，比较 IFM 测得的小幅位姿变化和同步采集的 PSD 电压变化，更新该工作点附近的六轴灵敏度。两次采样如何得到 `G` 的一列，见[图 1.4](#swzs-gain-calibration-figure)。
- **原文第 10 步，标定偏置。** 辨识零传感器对参考位置的零偏。示例报表分列六轴 `Zero Sensor Offset`（`ZSO`，平移用 m、转角用 rad）和三只 PSD 的 `u0/v0`（单位 V）。第 11 步将零传感器偏置和 `OZP` 一起用于计算 `FZP`。

原文顺序和报表字段见 L3-《09-TT-L3-WSbook.pdf》文件第 112、114–115 页（印刷第 104、106–107 页）及 L3-《TT-MA-WS-Calibrations-3v1.ppt》第 104 张。[机器常数与报告字段](SWZS资料汇整_v1.md#constants)

<a name="swzs-how-fzp-and-szp"></a>

##### 图 1.1（4）把标定结果用于快归零和 IFM 接管

- **原文第 11 步，求 `FZP`。** 用中间工作位姿 `OZP` 和零传感器偏置求出快归零位置，供初始化时的快归零捕获使用。
- **原文第 12 步，计算零传感器位置。** 以 `FZP` 为输入，求出各只 PSD 在基座坐标系中的标定位置。报告按卡盘、工位及 PSD 编号记录这些结果。
- **原文第 13 步，求 `MI:SZP`。** 为实际找回的归零参考位姿确定 IFM 使用的 `X/Y/Z/Rx/Ry/Rz` 机器坐标。生产归零时，PSD 帮助台体找回参考，IFM 接管时载入 `MI:SZP`，再从这组坐标继续测量位姿变化。示例里的坐标可为非零，见[图 1.3（6）](#swzs-voltage-to-zero)。

`FZP` 回答“快归零先到哪里”，`MI:SZP` 回答“到达参考后，IFM 从哪组坐标开始读数”。两者在示例报告中各有独立的六轴字段。Level 3 只给出这些量的计算依赖，具体的偏置符号和坐标变换未在课件中给出。见 L3-《09-TT-L3-WSbook.pdf》文件第 111–115 页（印刷第 103–107 页，图 2.34–2.35）及 L2-《TT-L2-ME-3v0.pdf》文件第 10–11 页（印刷第 4–5 页，图 1.4–1.5）。

**报表核对。** 对照选择的卡盘和工位，分别查看 IFM-align、PSD 或 FZP 的结果、所选组合的成功标志，以及 `New Machine Constants Saved for successful calibrations`。增益、偏置和坐标用对应的 `old/new` 字段核对。课件列出了检查项目与示例结果，实际放行数值按机型对应的 Coach 流程核对。见 L3-《09-TT-L3-WSbook.pdf》文件第 114–115 页（印刷第 106–107 页），图 2.34–2.35。

<a name="szws-principle"></a>
<a name="swzs-principle"></a>

### Principle（校准原理）

[图 1.2](#swzs-figure-168) 从零传感器的安装位置解释六路 PSD 电压如何形成。[图 1.3](#swzs-voltage-to-zero) 接着说明校准时如何用 IFM 测位标定这些电压，以及生产时如何用电压找回零位。

<a name="swzs-figure-168"></a>
<a name="swzs-psd-readout"></a>

#### PSD 工作原理与信号含义

计量框架每侧有三只零传感器，分别照射镜块上的三个角锥反射器。WS 改变位姿时，三个回波光斑在各自 PSD（Position Sensitive Device，位置敏感器件）的感光面上移动。每只 PSD 给出两个方向的位置电压，共六路。布置和测量方向见 L3-《09-TT-L3-WSbook.pdf》文件第 62–63 页（印刷第 54–55 页），图 1.68–1.69。[原图位置与解读](#swzs-source-figures)

![图 1.2，按零传感器安装位置、单组往返光路、光电流与读出电路、光斑位置和电压响应的顺序展示六路位置电压如何形成。](../images/SWZS零传感器原理_v5.png)

**图 1.2　SWZS 零传感器的光路与位置电压读出。** （1）为 L3-《09-TT-L3-WSbook.pdf》文件第 62 页（印刷第 54 页）的原图 1.68，标出三只零传感器与三个对应的角锥。（2）沿其中一组光路，从发射端 2a 到角锥 2b，再返回 PSD 感光面 2c。（3）用通用横向效应 PSD 解释电流分配与位置电压读出。（4）用一个方向的[局部线性示意](#swzs-eq-psd-voltage)说明光斑位移如何改变输出电压。Level 3 未给出实机 PSD 型号及电子电路。

以通用一维横向效应 PSD 为例，光斑在连续感光电阻层上产生光电流，由左右电极分别收集为 `I−`、`I+`。光斑位于电学中心时两路电流相等，向右移动时 `I+` 占总光电流的比例增大。理想线性区内，光斑位置由[式（1.1a）](#swzs-eq-psd-position)给出。

<a name="swzs-eq-psd-position"></a>

$$
x_{\mathrm{p}} = \frac{L}{2}\,\frac{I_{+}-I_{-}}{I_{+}+I_{-}} \qquad (1.1a)
$$

其中 `x_p` 是光斑质心相对电学中心的位置，`L` 是电阻层有效长度。用总电流归一化，可以减小整体光强变化对位置读数的影响。外部资料见 [Hamamatsu PSD 技术说明](https://www.hamamatsu.com/content/dam/hamamatsu-photonics/sites/documents/99_SALES_LIBRARY/ssd/psd_kpsd9001e.pdf#page=2) 第 2 页图 1-1、式 (1-3)。

**读出电路如何给出电压。** 以一个方向的输出 `u` 为例，跨阻放大器先把两端光电流转换成电压。后级取两路等比例电压的差值除以总和，再按输出比例与零点偏置生成位置电压。归一化比值按式（1.1a）等于光斑位置 `x_p` 除以半有效长度 `L/2`。因此，在该方向的线性工作区，可以用[式（1.1b）](#swzs-eq-psd-voltage)描述位置到电压的关系。外部资料见 [Hamamatsu《PSD signal processing circuits, PSD modules》§1.2 图 1-1](https://www.hamamatsu.com/content/dam/hamamatsu-photonics/sites/documents/99_SALES_LIBRARY/ssd/psd_singal_kacc9014e.pdf)。

<a name="swzs-eq-psd-voltage"></a>

$$
u-u_{\mathrm{c}} \simeq K_u\,\frac{2x_{\mathrm{p}}}{L} \qquad (1.1b)
$$

`u_c` 是示意通道在光斑位于电学中心时的输出电压，`K_u` 是把无量纲比值变成电压的比例系数，单位为 V。该通道的光斑位置灵敏度是 `2K_u/L`，单位可用 V/mm 表示。二维读出的另一方向也有各自的比例和偏置。

<a name="swzs-psd-output-characteristic"></a>

**供应商的输出特性图。** Hamamatsu 二维 PSD 读出电路手册《c4674-01_kpsd1005e.pdf》文件第 3 页右上图 KACCC0648EA，横轴是光斑在感光面上的局部位置（mm），纵轴是位置输出电压（V）。中心附近近似线性，名义区间两端之外可看到弯折。图 1.2（4）按式（1.1b）绘出中心附近的关系，供应商曲线及标尺见原页。[外部资料《Hamamatsu C4674-01 位置—输出电压原图》](https://www.hamamatsu.com/content/dam/hamamatsu-photonics/sites/documents/99_SALES_LIBRARY/ssd/c4674-01_kpsd1005e.pdf#page=3)

在 SWZS 报表中，每只传感器的 `u`、`v` 是代表两个局部方向光斑位置的电压信号，单位为 V。`u0/v0` 是对应通道的电压零偏。`du/dX`、`dv/dRy` 等增益记录 WS 平移或转动引起的电压响应，单位分别为 V/m、V/rad。SWZS 直接用六路 `u/v` 电压与 IFM 实测位姿变化标定 `G`，其中同时包含光斑相对 WS 位姿的几何响应及读出电路的比例。标定后用六路电压一起[换算为位姿偏差](#swzs-voltage-to-zero)。出处为L3-《09-TT-L3-WSbook.pdf》文件第 115 页（印刷第 107 页），图 2.35。

<a name="swzs-voltage-to-zero"></a>
<a name="swzs-ifm-signal"></a>

#### 从 PSD 电压到 WS 初始零位

**校准时**，先建立有效的 IFM 回波，再用 IFM 测得的位姿变化标定 PSD。**生产归零时**，用已标定的 PSD 信号恢复 WS 的参考位姿，随后由 IFM 接管。

![图 1.3，校准时用 IFM 回波与相位确定工作姿态并标定 PSD；生产归零时比较六路当前与参考电压，用增益矩阵求六轴偏差。](../images/SWZS-PSD至IFM初始零位_v3.png)

**图 1.3　SWZS 初始零位的测量原理。** 图 1.3（1）和（2）解释 IFM 对准及如何给出实际运动，图 1.3（3）和（4）对应 PSD 增益与参考零位标定，[图 1.3（5）](#swzs-psd-reference-recovery)用参考和当前的六路电压求偏差，并以 Rx 为例示意修正方向。[图 1.5](#swzs-ifm-peak-location) 展开单路回波的定位与恢复过程。图 1.3（6）给出 IFM 接管的坐标示例。图 1.3（1）的寻峰曲线截自L3-《TT-MA-ME_setupblock_1-5_1v3.ppt》第 9 张。图 1.3（6）的机器坐标示例取自L2-《TT-L2-ME-3v0.pdf》文件第 11 页（印刷第 5 页），图 1.5。

**（1）IFM 回波强度和相位各有用途，见图 1.3（1）与（2）。** 扫描 `Rx/Ry/Rz` 并记录 IFM 的回波强度，从峰附近选取初始化倾角 `Rx0/Ry0/Rz0`。以图 1.3（1）的 Rx 曲线为例，峰的横坐标给出对应的 Rx 姿态。参与测量的通道需要有效的回波，各通道峰位可能不同。课件未给出多通道联合寻峰和通过门限。建立有效回波后，IFM 跟踪测量信号相对参考的相位变化，从各路光程增量解算台体实际六轴位姿增量 `Δq = [ΔX, ΔY, ΔZ, ΔRx, ΔRy, ΔRz]`。出处为L3-《12-TT-L3-L3-ME_book.pdf》文件第 26–29 页（印刷第 18–21 页）、L3-《09-TT-L3-WSbook.pdf》文件第 60–61 页（印刷第 52–53 页），图 1.66。

**（2）用同一次运动的 IFM 位姿和 PSD 电压求增益矩阵，见图 1.3（3）与（4）。** 以 IFM 测得的运动为基准，同步记录三只 PSD 的六路电压。参考位置附近，单独改变 X 时，第 `j` 路电压变化对实测 X 位移的斜率是 `G` 的 X 列中的一项，见[式（1.2）](#swzs-eq-gain-element)。

<a name="swzs-eq-gain-element"></a>

$$
G_{jX} \simeq \frac{\Delta s_j}{\Delta X} \qquad (1.2)
$$

六个独立激励方向可以确定 6×6 的 `G`。六路电压变化与六轴位姿变化满足[式（1.3）](#swzs-eq-gain-matrix)的局部关系。

<a name="swzs-eq-gain-matrix"></a>

$$
\Delta\mathbf{s} \simeq \mathbf{G}\,\Delta\mathbf{q} \qquad (1.3)
$$

<a name="swzs-gain-calibration-figure"></a>

![图 1.4，左上和右上为 WS 移动前后的三只 PSD 光斑与六路电压，以及 IFM 各路相位和回波强度。下方用六路电压变化和实测 X 位移确定灵敏度矩阵的 X 列。](../images/SWZS灵敏度矩阵标定_v1.png)

**图 1.4　PSD 灵敏度矩阵的标定示意。** （1）和（2）比较两次采样的光斑和电压，下标依次表示 PSD 编号与采样编号。（3）用 IFM 相位变化得到的实测位移和六路电压差计算 X 列，适用于参考点附近且其余自由度变化可忽略的情形。（4）对其余方向做同类采样，得到矩阵的其他列。回波强度可用于对准和检查信号质量。图按 L3-《09-TT-L3-WSbook.pdf》文件第 112 页（印刷第 104 页）的以 IFM 为参照标定增益步骤绘制。光斑变化和单轴差分用来说明测量原理，该页未给出实机的采样与拟合算法。

每行对应一条 PSD 电压通道，每列对应一个台体自由度。平移列单位为 V/m，角度列单位为 V/rad，非主通道的斜率也保留在矩阵中。完整流程还用 PSD 中心与粗增益求 `OZP`，在该工作点复测增益和校准偏置，然后求 `FZP`、传感器位置及 `MI:SZP`。`G` 描述局部灵敏度，参考零位及其坐标由中心、偏置与位置标定确定。出处为L3-《09-TT-L3-WSbook.pdf》文件第 111–115 页（印刷第 103–107 页）、L3-《TT-MA-WS-Calibrations-3v1.ppt》第 97–98、104 张。

<a name="swzs-psd-reference-recovery"></a>

**（3）生产归零用 PSD 找回参考，见图 1.3（5）与（6）。** 台体进入捕获区以后，读取三只 PSD 的六路电压 `s`。`s_ref` 表示同一卡盘、同一工位的归零参考位姿对应的六路电压。用[式（1.4）](#swzs-eq-voltage-difference)逐通道作差。

<a name="swzs-eq-voltage-difference"></a>

$$
\Delta\mathbf{s} = \mathbf{s} - \mathbf{s}_{\mathrm{ref}} \qquad (1.4)
$$

在参考点附近，若 `G` 满秩，可用[式（1.5）](#swzs-eq-pose-difference)解释如何由电压差得到六轴位姿偏差。

<a name="swzs-eq-pose-difference"></a>

$$
\Delta\mathbf{q} \simeq \mathbf{G}^{-1}\Delta\mathbf{s} \qquad (1.5)
$$

这里的偏差是**当前位姿减去参考位姿**。若算出的 `ΔRx` 大于零，就应向负 Rx 方向修正。图 1.3（5）只画 Rx 这一分量，实际含义是将六路电压差一起代入，得到六轴偏差。靠近参考位姿时，电压差与位姿偏差一起趋近于零。找回参考后，IFM 加载 `MI:SZP` 继续测位，所加载的机器坐标可以为非零值。出处为 L1-《09_AP-L1-Production_Metrology_in-line.pdf》第 13、24 页及 L2-《TT-L2-ME-3v0.pdf》文件第 10–11 页（印刷第 4–5 页）。

<a name="swzs-ifm-peak-location"></a>

##### 单路 IFM 回波最强采样点的定位与恢复

![图 1.5，自上而下为 WS 的 Rx 转角、六路 PSD 电压差和同一路 IFM 回波强度。三层按 A 到 E 的采样点对齐，D 点对应最高回波。](../images/SWZS-PSD辅助IFM回波峰定位_v2.png)

**图 1.5　同一次 Rx 扫描中的 WS 转角、PSD 电压和 IFM 回波。** 自上而下依次展示 WS 的角位移、相对于 C 点的六路 PSD 电压差、同步观测的单路 IFM 回波强度。三层共用样点 A–E。C 是基准，D 在本组样点中回波最高，对应示意角位移 +1 µrad。这是[图 1.3（5）](#swzs-psd-reference-recovery)的计算示例，使用[图 1.4](#swzs-gain-calibration-figure)说明的已标定矩阵 `G`。

**采样与定位见图 1.5（1）和（2）。** 同一卡盘、同一工位和参考位姿附近，以 C 点的已知位姿 `q0` 及六路 PSD 电压 `s0` 为基准。其余自由度保持不变时扫描 `Rx`，每个采样点同时记录当前六路电压 `s_k` 和同一路 IFM 的回波强度 `I_k`。若局部的 `G` 满秩，用六路电压差联立得到该点相对 C 的六轴位姿增量。强度图的横轴取这个增量的 `Rx` 分量。

$$
\Delta\mathbf{q}_k \simeq \mathbf{G}^{-1}(\mathbf{s}_k-\mathbf{s}_0) \qquad (1.6a)
$$

**选点与恢复见图 1.5（3）和（4）。** 对比同一路 IFM 的实测强度，选出这组采样中的最高点。用该点的位姿增量加上基准位姿，得到它的六轴位姿估计。

$$
k_\star = \operatorname*{arg\,max}_{k} I_k \qquad (1.6b)
$$

$$
\mathbf{q}_\star \simeq \mathbf{q}_0+\Delta\mathbf{q}_{k_\star} \qquad (1.6c)
$$

需要再次找回 D 点时，把 D 对应的六路电压设为此示例的目标 `s_ref`。当前六路电压与这个目标作差，再按[式（1.4）](#swzs-eq-voltage-difference)和[式（1.5）](#swzs-eq-pose-difference)求偏差并反向修正。C 点电压用于定位扫描样点，D 点电压用于恢复目标姿态。

<a name="swzs-ifm-peak-least-squares"></a>

**这里是不是最小二乘？** 式（1.6a）是六路电压解六轴偏差的线性方程。当六乘六的 `G` 满秩时，直接联立可得到唯一解。把同一问题写成最小二乘时，解与方阵解相同，模型内的残差为零。

像图 1.5 这样固定其余五轴时，六路电压只需估计一个未知的 `ΔRx`。取 `G` 的 `Rx` 列为 `g_Rx`，并对六路电压采用相同权重。最小化 $\lVert\Delta\mathbf{s}_k-\mathbf{g}_{R_x}\Delta R_{x,k}\rVert_2^2$，得到[式（1.7）](#swzs-eq-rx-least-squares)。带噪声时，它求的是对六路电压最吻合的单轴转角。

<a name="swzs-eq-rx-least-squares"></a>

$$
\widehat{\Delta R}_{x,k}
=\frac{\mathbf{g}_{R_x}^{\mathsf{T}}\Delta\mathbf{s}_k}
       {\mathbf{g}_{R_x}^{\mathsf{T}}\mathbf{g}_{R_x}}
\qquad (1.7)
$$

回波峰的选取仍按式（1.6b）比较实际观测强度。图 1.5 的 IFM 曲线连接示意采样点，选出的 D 是这些样点中的最大值。多路峰位分开时，可对照[图 1.6](#swzs-ifm-common-working-window)理解共同工作区间。

Level 3 给出的正式流程先做 IFM 对准，再标定 PSD 增益、中心、偏置和参考位置。课件未公布多路 IFM 的联合寻峰规则，也未给出生产归零的控制细节。见 L3-《TT-MA-ME_setupblock_1-5_1v3.ppt》第 9 张和 L3-《09-TT-L3-WSbook.pdf》文件第 112 页（印刷第 104 页）。

<a name="swzs-ifm-common-working-window"></a>

##### 多路 IFM 峰位不重合时的工作姿态与诊断

**工程示意。** 图 1.6 按同一卡盘、同一工位的一维 `Rx` 截面画出八条设定曲线，其他自由度固定。通道标记参考晶圆台 IFM 布置。所需反馈通道、有效量程和信号门限按实际机型及工位确定。L3-《09-TT-L3-WSbook.pdf》文件第 57–58 页（印刷第 49–50 页，图 1.60–1.61）给出 IFM 布置。

![图 1.6，左侧八路峰位不同但有效区间有交集，示意在区间内部选候选姿态；右侧两条限制通道的区间分离，示意核对允许姿态范围后回查 SWHP；下方列课件明确的实机流程。](../images/SWZS-IFM多通道共同有效区间_v1.png)

**图 1.6　八路 IFM 峰位不重合时的共同有效区间。** 上方曲线纵轴是回波强度除以各路的示意下限，圆点标出各路峰顶。下方色条与上方使用同一转角尺度，色条两端对应各路曲线穿过下限的位置。（1）青色带是八条有效区间的交集，虚线是取该区间中点的示意工作姿态。（2）X1 的有效区间已经结束，Z2 的有效区间仍未开始，橙色带标出两者之间的间隔。（3）蓝色栏列出 Level 3 明确的步骤。图中的曲线、下限和中点选法均为工程示意。

令 `r` 为图中的扫描转角，$\mathcal R$ 为所核对的转角范围，$\mathcal A$ 为所需通道集合。图 1.6 只示意各路有强度下限时的判定。把每路达到本路下限的区间求交，得到[式（1.8）](#swzs-eq-common-ifm-window)的共同区间。实际验收还应核对机型规定的全部信号、量程和反馈条件。

<a name="swzs-eq-common-ifm-window"></a>

$$
\mathcal W =
\bigcap_{i\in\mathcal A}
\left\{r\in\mathcal R:\ I_i(r)\ge I_{i,\min}\right\}
\qquad (1.8)
$$

- **有共同区间时。** 可以在交集内部选候选姿态，尽量给限制通道留出余量，并验证所需通道能同时提供有效信号以及 IFM 六轴反馈可用。这个候选是光学工作姿态。生产用六轴归零参考仍按 [SWZS 的 PSD 标定流程](#swzs-how-translation)建立。
- **本截面无共同区间时。** 先确认测试是否覆盖允许的 `Rx/Ry/Rz` 和有效量程。若按机型要求检查后，所需通道仍没有共同可用姿态，则回查 [SWHP 前置诊断](#swzs-prerequisites)及相应维护程序，按故障定位决定调整项目，复查 IFM 条件后再继续归零标定。
- **与最小二乘的关系。** [图 1.5 的最小二乘](#swzs-ifm-peak-least-squares)用 PSD 电压估计位姿。也可以用最小二乘拟合单路回波曲线来估计峰顶。对多路回波选择一个共同工作姿态还需定义通过条件或综合目标。Level 1–3 未给出实机这一环的通道优先级、权重、门限或联合选点公式。

**Level 1–3 明确的实机流程。**

- **L1 生产中使用六轴粗参考。** 两个工位均由零传感器为 IFM 提供 `X/Y/Z/Rx/Ry/Rz` 粗参考。见 L1-《09_AP-L1-Production_Metrology_in-line.pdf》文件第 13、24 页。
- **L2 进入参考后交接给 IFM。** 装片或换台后，晶圆台返回 IFM 量程，零传感器提供起始参考。接管前后可处在同一物理位姿，IFM 接管后使用 `MI:SZP` 的六轴机器坐标。见 L2-《TT-L2-ME-3v0.pdf》文件第 10–11 页（印刷第 4–5 页，图 1.4–1.5）。
- **L3 先做 IFM 对准，再标定归零参考。** 初始化倾角试验转动和倾斜 WS，记录回波质量，保存两只卡盘在测量侧和曝光侧的 `Rx0/Ry0/Rz0`。测量侧 `Ry0` 后续还由 WZIM 按调平传感器参考重定。完整 SWZS 在 IFM 对准及六轴反馈就绪后标定 PSD 中心、增益和偏置，经 `OZP`、`FZP` 和传感器位置计算 `MI:SZP`。见 L3-《12-TT-L3-L3-ME_book.pdf》文件第 26–28 页（印刷第 18–20 页）、L3-《TT-MA-ME_setupblock_1-5_1v3.ppt》第 9–10 张及 L3-《09-TT-L3-WSbook.pdf》文件第 111–115 页（印刷第 103–107 页）。
- **L3 以诊断结果区分电子增益与光学调整。** SWHP 列为 SWZS 前置项目，单独运行 `IFM-align` 只做检查。旧 B-spec 的 SWHP 示例用接收器增益把监视电压调入规定区间，若调整仍不足则升级排查。AOM 光纤耦合属于独立的供光光路维护。见 L3-《TT-MA-WS-Calibrations-3v1.ppt》第 100–104、186–195 张及 L3-《09-TT-L3-WSbook.pdf》文件第 131–134 页（印刷第 123–126 页）。[SWZS 资料汇整与前置关系](SWZS资料汇整_v1.md#dependencies)

<a name="szws-source-figures"></a>
<a name="swzs-source-figures"></a>

#### 原图与出处

原图 1.68 见 [正文图 1.2（1）](#swzs-figure-168)。以下列出相应的本机原图位置，最后一列相对 `D:\work\ME2\参考文献\Markdown_v1\`。图像与页码的查询方式见 [Level 1–3 资料规则](../../AGENTS.md#read-only-references)。

**表 1.3　SWZS 原图与出处**

| 原始资料 | 图中可核实的信息 | 本机原图位置 |
| --- | --- | --- |
| L3-《09-TT-L3-WSbook.pdf》第 62 页（印刷第 54 页），**图 1.68 Zero Sensors** | 三只传感器固定在 MF，三个对应角锥位于镜块。 | `assets/b4514b4ae5eb86cb/images/page_61_image_8_v1.jpg` |
| L3-《09-TT-L3-WSbook.pdf》文件第 63 页（印刷第 55 页），**图 1.69** | 从计量框架底面看，M/E 各圈出三个零传感器。 | `assets/b4514b4ae5eb86cb/images/page_62_image_5_v1.jpg` |
| L3-《TT-MA-ME_setupblock_1-5_1v3.ppt》第 9 张，**Interferometer strength–Rx 曲线** | 扫描初始化倾角时，回波强度在中间出现峰。 | 见原 PPT 第 9 张及 [正文图 1.3（1）](#swzs-ifm-signal)。 |
| L2-《TT-L2-ME-3v0.pdf》第 11 页（印刷第 5 页），**图 1.4、1.5** | 两图中的台体处于同一归零位置。图 1.5 在 IFM 控制下列出六轴 MI:SZP 参考值。 | `assets/e9dff352e800b276/images/page_10_image_4_v1.jpg`、`assets/e9dff352e800b276/images/page_10_image_9_v1.jpg` |
| L3-《TT-MA-WS-Calibrations-3v1.ppt》第 102 张 | 全 PSD 模式包含 IFM-align。两卡盘 M/E 共四组合可选择，图示进度为 0%。 | `assets/56ea2737208dfc3a/images/page_101_image_4_v1.jpg` |
| L3-《09-TT-L3-WSbook.pdf》第 115 页（印刷第 107 页），**图 2.35** | FZP、MI:SZP、`u0/v0` 和 PSD 增益分别列项，可核对单位和报表字段。 | `assets/b4514b4ae5eb86cb/images/page_114_image_4_v1.jpg` |

[返回项目目录](#calibration-index) · [WS-IFM 清单的初步归零条目](WS-IFM机器常数校准项目_v4.md#initial-zero)
