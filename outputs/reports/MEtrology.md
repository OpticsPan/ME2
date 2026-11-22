# MEtrology 校准项目报告

[项目目录](#calibration-index) · [整理范式](#report-format) · [先画总流程再讲细节](#overview-first) · [步骤说明](#step-description) · [WS-IFM 校准清单](WS-IFM机器常数校准项目_v4.md#initial-zero) · [成果索引](../README.md)

<a name="report-format"></a>

## 本报告的整理范式

以下范式仅适用于 `MEtrology.md` 收录的校准项目。

<a name="overview-first"></a>

**先画总流程，再解释技术细节。**

先画带编号的总流程图，串起准备条件、操作、观测和结果。正文开篇放总图，按图中的先后顺序解释各阶段。每个概念第一次出现时说明它是什么、怎么得到、下一步怎么用。上一环的结果进入下一环前，写清中间的测量、转换或判断。例如从 PSD 光斑讲到 WS 位姿，中间要说明光斑如何变成电压，电压又如何经增益矩阵换算成位姿偏差。需要展开的技术细节另配图，并标明对应总图的步骤。

1. **Purpose（目的）**。说明项目要解决什么问题、为什么要做、执行前需满足哪些条件，以及完成后可以开展哪些校准项目。列出本项目涉及校准的机器常数及其用途。
2. **How（操作流程）**。沿总图说明各阶段如何衔接。按源文完整翻译具体操作流程，保留步骤顺序、条件、注意事项和判据，并注明来源及页码。
3. **Principle（校准原理）**。具体说明测量基准和物理原理，解释校准如何由观测量得到机器常数。资料中有相关物理原图时，将原图附在本节正文并注明来源层级、原文件名、页码和图号。

<a name="step-description"></a>

### 步骤说明

- 在原文译文之后，用短句说明每一步从什么状态或输入开始、操作什么、读取或检查什么，以及得到什么结果。资料给出判据时，写清怎样判断完成。结果有明确的后续用途时，指出交给哪一步。
- 优先写清动作和信号怎样衔接。公式仅在有助于理解量之间的关系时补充，详细推导可链接到原理或资料汇整。
- 资料只给输入和输出时，按已确认的信息写。为解释原理而补充的操作或算法标为工程示意，并注明实机细节待查。

### 章节、图表与公式编号

- **章节**。每个校准项目独立成节，按目录顺序编号。
- **图、表与公式**。在每节内分别按「章节号.序号」编号，各自从 1 开始。例如第 1 节的第一张图、第一张表和第一条公式分别记为图 1.1、表 1.1 和式（1.1）。正文与图中重复出现的同一公式共用编号。引用资料中的图、表或公式时保留来源编号。
- **图内编号**。原理图和示意图中的关键模块、模组和子图应标注编号，如 `（1）`、`（2）`。正文或图注可按「图 1.2（1）」直接指向具体对象。
- **公式排版**。正文和图内公式应正常显示分式、上下标和矩阵。阅读器对数学语法的支持不一致时，正文可嵌入已排版的公式图并附替代文字。

<a name="compact-figures"></a>

### 图件布局

- **总流程图**。紧凑布局要求仅适用于[图 1.1](#swzs-procedure-diagram)这类展示项目完整流程的总览图。按各阶段的内容分配版面，收紧边距和模块间距，减少无用途的留白，同时保持步骤编号和文字清晰。
- **原理图与分析图**。沿用[图 1.2–1.5](#swzs-figure-168)的风格，按光路、公式、坐标轴及标注的阅读需要安排空间。

### 来源标注

引用 Level 1–3 的文档或原图时，在文件名前标注所属层级，例如 `L1-《文件名.pdf》`、`L2-《文件名.pdf》`、`L3-《文件名.ppt》`。非 Level 1–3 的来源标为「外部资料」。

<a name="calibration-index"></a>

## 项目目录

| 项目 | 定位 | 快速跳转 |
| --- | --- | --- |
| [1. SWZS — WS 初步归零](#swzs) | 建立晶圆台干涉仪启用时的六自由度参考 | [Purpose](#swzs-constants) · [How](#swzs-procedure) · [Principle](#swzs-principle) · [初始零位测量原理](#swzs-voltage-to-zero) · [资料汇整](SWZS资料汇整_v1.md) |
| [2. WZIM — 测量侧初始高度与倾角](#wzim) | 用 LS 定初始高度和倾角，校正 Z-IFM 的线性行走倾斜 | [总流程图](#wzim-procedure-diagram) · [Purpose](#wzim-purpose) · [How](#wzim-procedure) · [Principle](#wzim-principle) · [资料汇整](WZIM资料汇整_v1.md) |

<a name="szws"></a>
<a name="swzs"></a>

## 1. SWZS — WS 初步归零

[总流程图](#swzs-procedure-diagram) · [Purpose](#swzs-constants) · [How](#swzs-procedure) · [Principle](#swzs-principle) · [初找中心](#swzs-how-find-psd-center) · [步骤 12](#swzs-step12) · [原图出处](#swzs-source-figures) · [Level 1–3 资料汇整](SWZS资料汇整_v1.md)

晶圆台（WS）从干涉仪（IFM）获得精密位姿。装片或换台后，安装在计量框架上的零传感器用位置敏感器件（PSD）检测返回光斑，帮助台体重新找回 IFM 的起读位置。

<a name="swzs-procedure-diagram"></a>

![图 1.1，SWZS 的 13 个校准步骤及生产归零。](../images/SWZS归零校准流程_v7.png)

**图 1.1　SWZS 总流程。** （1）[先让 IFM 测到实际运动](#swzs-how-establish-ifm)。（2）[用实测运动与 PSD 电压求粗增益，定位光斑中心](#swzs-how-find-psd-center)。（3）[由中心和粗增益算复测工作位姿，再标定增益与偏置](#swzs-how-ozp-and-gain)。（4）[算快归零位姿、PSD 基座位姿及 IFM 起读坐标](#swzs-how-fzp-and-szp)。用这些结果完成（5）[生产归零](#swzs-psd-reference-recovery)。见 L3-《09-TT-L3-WSbook.pdf》文件第 112 页（印刷第 104 页）。[原文译文](#swzs-how-translation)

<a name="szws-constants"></a>
<a name="swzs-constants"></a>

### Purpose（目的）

SWZS 校准零传感器，使晶圆台装片或换台后能重复找回同一个六轴参考位姿。编码器先将台体带回零传感器能测到光斑的捕获区，PSD 再定位参考，IFM 加载对应的机器坐标后接管。见 L1-《09_AP-L1-Production_Metrology_in-line.pdf》第 13、24 页及 L2-《TT-L2-ME-3v0.pdf》文件第 10–11 页（印刷第 4–5 页）。[图 1.3](#swzs-voltage-to-zero)

**何时做。** TWINSCAN 初始设定或更换零传感器部件后做完整校准，覆盖两卡盘 × 测量侧和曝光侧四种组合。初始化无法快归零时，可独立运行 Update FZP。下列流程适用 WS Type-2、rel.3.4。见 L3-《09-TT-L3-WSbook.pdf》文件第 73、111–115 页（印刷第 65、103–107 页）。

<a name="swzs-prerequisites"></a>

#### 前置条件

完成基座校准（BF）、卡盘交换校准（SWSW）、干涉仪调整与诊断（SWHP）及差分传感器校准（SWDC），空气支承（AM）开启并稳定。见 L3-《09-TT-L3-WSbook.pdf》文件第 111 页（印刷第 103 页）、L3-《TT-MA-WS-Calibrations-3v1.ppt》第 100–101 张。

#### 完成后可以开展的项目

计量设定进入 BMAA 支路及 [WZIM](#wzim) → [WGIM／WS TRIM](WS-IFM机器常数校准项目_v4.md#mc-wgim) → CLPL 支路。SWZS 也是 SWCR 范围检查和 SWSM 短行程电机校准的前提之一。见 L3-《12-TT-L3-L3-ME_book.pdf》文件第 14–15 页（印刷第 6–7 页），图 1.3；L3-《TT-MA-WS-Calibrations-3v1.ppt》第 79、144、211 张。[完整的上下游项目](SWZS资料汇整_v1.md#dependencies)

#### 机器常数及用途

**表 1.1　SWZS 机器常数与中间量**

| 量 | 作用 |
| --- | --- |
| 零传感器增益矩阵 `G` | 将 WS 六轴位姿变化关联到六路 PSD 电压变化。每组合为 6×6，平移列用 V/m，转角列用 V/rad。 |
| `ZSO` | 六轴零传感器偏置，单位 m、rad，用于计算 `FZP`。 |
| `FZP` | 快归零捕获使用的六轴位姿。 |
| `MI:SZP`（`MISZP`） | IFM 接管时加载的六轴机器坐标，可以是非零值。 |
| PSD 基座位姿及 `u0/v0` | 报表逐只列出基座坐标下的六轴位姿和两路电压零偏。 |
| `OZP` | 用粗增益和中心结果算出的中间工作位姿，用于复测增益和求 `FZP`。 |

L3-《09-TT-L3-WSbook.pdf》文件第 111 页明确列出前四项校准常数，文件第 114–115 页（印刷第 106–107 页）图 2.34–2.35 展示示例报表。`Rx0/Ry0/Rz0` 属于相关的初始化倾角设定，见[资料汇整](SWZS资料汇整_v1.md#constants)。

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

#### 按总图读流程

<a name="swzs-how-establish-ifm"></a>

##### 图 1.1（1）步骤 01–03，建立 IFM 六轴反馈

做 IF Align 检查回波，载入默认值，初始化短行程至 IFM 六轴反馈。回波可用时，IFM 从相位变化测出台体的实际运动，作为下一阶段标定 PSD 的参照。[图 1.5 回波与姿态](#swzs-if-align)

<a name="swzs-how-find-psd-center"></a>

##### 图 1.1（2）步骤 04–07，找中心并标定粗增益

步骤 04 初找 PSD 中心。步骤 05 把 IFM 测到的运动和同时测到的 PSD 电压变化配对，标出粗增益 `G_c`，即台体运动引起电压变化的比例关系。步骤 06 用 `G_c` 重新确定中心，得到计算 `OZP` 的输入。步骤 07 检查光强、电子学、光束位置及 HP 干涉仪和差分传感器量程。L3 未给出落点轨迹或中心判据。[图 1.2 光斑如何变成电压](#swzs-psd-readout) · [图 1.4 怎样测增益](#swzs-gain-calibration-figure) · [步骤 04–08 证据](SWZS步骤04至08-PSD中心定位核查_v1.md#step-evidence)

<a name="swzs-how-ozp-and-gain"></a>

##### 图 1.1（3）步骤 08–10，算 OZP、复测增益、标偏置

用粗增益和中心结果算中间工作位姿 `OZP`，在该工作点复测增益，再标定六轴零传感器偏置 `ZSO`，供下一阶段计算快归零位姿。课件未说明步骤 08 是否驱动台体。[图 1.4 增益怎么测](#swzs-gain-calibration-figure)

<a name="swzs-how-fzp-and-szp"></a>

##### 图 1.1（4）步骤 11–13，算快归零与 IFM 接管所需的量

用 `OZP` 和 `ZSO` 算快归零位姿 `FZP`，再算三只 PSD 的基座位姿，最后算 IFM 接管用的 `MI:SZP`。

<a name="swzs-step12"></a>

**步骤 12。** 输入是 `FZP`，报表逐只给出 PSD 的基座六轴位姿和检测状态。L3 未公开这一步的采样与解算方法。[步骤 12 证据](SWZS步骤12-PSD基座位姿核查_v1.md#source-evidence)

**核对报表。** 按卡盘和工位核对成功标志、机器常数是否保存及 `old/new` 字段。见 L3-《09-TT-L3-WSbook.pdf》文件第 112、114–115 页（印刷第 104、106–107 页），图 2.34–2.35。

<a name="szws-principle"></a>
<a name="swzs-principle"></a>

### Principle（校准原理）

[图 1.2](#swzs-psd-readout)先说明光斑怎样变成六路位置电压。[图 1.3](#swzs-voltage-to-zero)把这六路电压接入归零流程，[图 1.4](#swzs-gain-calibration-figure)展开电压与位姿的标定关系。最后可回看[图 1.5](#swzs-if-align)，了解流程开始时怎样检查 IFM 回波。

<a name="swzs-figure-168"></a>
<a name="swzs-psd-readout"></a>

#### PSD 光路与位置电压

每工位有三只固定在计量框架（MF）上的零传感器，与镜块上的三个角锥配对。台体运动会改变返回光斑的位置。每只零传感器的 PSD（位置敏感器件）给出两个方向的电压 `u/v`，三只合计六路。

![图 1.2，计量框架原图、角锥往返光路、PSD 读出与位置电压。](../images/SWZS零传感器原理_v6.png)

**图 1.2　零传感器光路与位置电压。** 对应[步骤 04、06、07](#swzs-how-find-psd-center)。（1）采用 L3-《09-TT-L3-WSbook.pdf》文件第 62 页（印刷第 54 页）原图 1.68。（2）追踪一组角锥回波，（3）和（4）示意通用 PSD 的电流读出和电压响应。

在通用 PSD 的线性区，光斑位置 `x_p` 由两端电流的归一化差值求出，`L` 是感光有效长度。读出电路用比例系数 `K_u` 将位置变成电压。光斑到电学中心时，电压差趋近零，中心电压 `u_c` 可以非零。[Hamamatsu PSD 技术说明，第 2 页](https://www.hamamatsu.com/content/dam/hamamatsu-photonics/sites/documents/99_SALES_LIBRARY/ssd/psd_kpsd9001e.pdf#page=2) · [PSD 读出电路说明，图 1-1](https://www.hamamatsu.com/content/dam/hamamatsu-photonics/sites/documents/99_SALES_LIBRARY/ssd/psd_singal_kacc9014e.pdf)

<a name="swzs-eq-psd-position"></a>
<a name="swzs-eq-psd-voltage"></a>

![式（1.1a）光斑位置等于 L 除以 2，乘以两端光电流之差与总电流的比。式（1.1b）电压 u 减中心电压 u_c 约等于 K_u 乘以 2x_p/L。](../images/SWZS-equations-psd-readout_v1.png)

<a name="swzs-psd-output-characteristic"></a>

图 1.2（4）的电压响应参考外部资料《Hamamatsu C4674-01》文件第 3 页，图 KACCC0648EA。L3 未给出实机 PSD 的电路。[供应商位置—电压原图](https://www.hamamatsu.com/content/dam/hamamatsu-photonics/sites/documents/99_SALES_LIBRARY/ssd/c4674-01_kpsd1005e.pdf#page=3)

<a name="swzs-voltage-to-zero"></a>
<a name="swzs-ifm-signal"></a>

#### 用 IFM 标定 PSD，再用 PSD 找回参考

![图 1.3，首次校准由 IFM 测位供 PSD 标定，生产归零由 PSD 定位后交给 IFM。](../images/SWZS-PSD至IFM初始零位_v4.png)

**图 1.3　SWZS 初始零位的测量原理。** （1）和（2）对应[步骤 01、03](#swzs-how-establish-ifm)，回波强度用来确认信号，IFM 相位变化用来测位。（3）对应[步骤 05、09](#swzs-gain-calibration-figure)，（4）对应[步骤 08–13](#swzs-how-ozp-and-gain)，（5）和（6）对应[生产归零](#swzs-psd-reference-recovery)。

（1）的回波曲线取自 L3-《TT-MA-ME_setupblock_1-5_1v3.ppt》第 9 张。（6）的机器坐标示例取自 L2-《TT-L2-ME-3v0.pdf》文件第 11 页（印刷第 5 页），图 1.5。

<a name="swzs-gain-calibration-figure"></a>

##### 标定增益矩阵

让 WS 做小幅运动，同时记录 IFM 实测位姿增量和 PSD 六路电压变化。若只动 X，用第 j 路电压变化除以实测 X 位移，估计该路对 X 的灵敏度。用六个独立运动方向确定完整的 `G`。这是对 L3 校准原理的局部线性解释。见 L3-《09-TT-L3-WSbook.pdf》文件第 111–112、115 页（印刷第 103–104、107 页）。

<a name="swzs-eq-gain-element"></a>
<a name="swzs-eq-gain-matrix"></a>

![式（1.2）G 的第 j 行、X 列约等于该路电压变化除以 X 位移。式（1.3）六路电压变化向量约等于 G 乘以六轴位姿变化向量。](../images/SWZS-equations-gain_v1.png)

![图 1.4，比较 WS 移动前后六路电压与 IFM 实测运动，示意如何得到 G 的 X 列。](../images/SWZS灵敏度矩阵标定_v2.png)

**图 1.4　PSD 灵敏度矩阵的标定示意。** 对应[步骤 05](#swzs-how-find-psd-center)和[步骤 09](#swzs-how-ozp-and-gain)。前者标粗增益，后者用 `OZP` 复测。同样的局部关系也可解释如何用粗增益估计向 PSD 中心调节的增量。

<a name="swzs-psd-reference-recovery"></a>

##### 生产归零

生产时编码器先把台体带回 PSD 能测到光斑的捕获区，再读取当前六路电压 `s`，减去同一卡盘、同一工位的参考电压 `s_ref`。在参考点附近且 `G` 满秩时，可以用下式估计**当前位姿相对参考的偏差**，再沿相反方向调节。找回参考后，IFM 加载 `MI:SZP` 接管。见 L2-《TT-L2-ME-3v0.pdf》文件第 10–11 页（印刷第 4–5 页）。

<a name="swzs-eq-voltage-difference"></a>
<a name="swzs-eq-pose-difference"></a>

![式（1.4）电压差等于当前六路电压减参考六路电压。式（1.5）位姿偏差约等于 G 的逆矩阵乘以电压差向量。](../images/SWZS-equations-reference-pose_v1.png)

<a name="swzs-if-align"></a>

#### IF Align 三轴姿态采样与八路回波选点

![图 1.5，镜面角度影响回光，同一姿态记录八路回波并比较可用姿态。](../images/IF-Align三轴姿态选点_v3.png)

**图 1.5　IF Align 三轴姿态采样与八路回波选点。** 对应[步骤 01](#swzs-how-establish-ifm)。（1）转动镜面改变回波，（2）每组 `Rx/Ry/Rz` 记录八路强度。（3a）X1 曲线上 1.00 是本路最低可用回波，C 点 1.42 表示高出 42%。（3b）八路分别用各自下限归一化。

<a name="swzs-if-align-selection"></a>

**（3c）工程示意。** 取八路归一化强度的最小值 `m(θ)`。最小值达到 1.00 时，八路均达到各自下限。合格点中，可以选回波余量最大的 C，也可按角度距离 `d(θ)` 选最接近参考姿态的 B。L3 证实初始化倾角试验会转动 WS 并观测 IFM 信号，图中的候选点、门限和联合选点规则为示意。见 L3-《12-TT-L3-L3-ME_book.pdf》文件第 26 页（印刷第 18 页）及 L3-《TT-MA-ME_setupblock_1-5_1v3.ppt》第 9 张。

![式（1.6）m(θ) 是八路回波强度除以各自下限后得到的最小值。式（1.7）d(θ) 是候选姿态和参考姿态三个角度差的平方和开根。](../images/SWZS-equations-if-align_v1.png)

<a name="swzs-if-align-diagnostics"></a>

**多路回波不足时。** 在允许的姿态范围内找不到各路共同可用的点，回查前置项目 [SWHP](#swzs-prerequisites)。见 L3-《09-TT-L3-WSbook.pdf》文件第 111–113 页（印刷第 103–105 页）。

<a name="szws-source-figures"></a>
<a name="swzs-source-figures"></a>

#### 原图与出处

本机原图路径相对 `D:\work\ME2\参考文献\Markdown_v1\`。计量框架原图见[图 1.2（1）](#swzs-figure-168)。[资料引用规则](../../AGENTS.md#read-only-references)

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

<a name="wzim"></a>

## 2. WZIM — 测量侧初始高度与倾角

[总流程图](#wzim-procedure-diagram) · [Purpose](#wzim-purpose) · [How](#wzim-procedure) · [Principle](#wzim-principle) · [三光斑倾角](#wzim-three-spot-tilt) · [三点回零与九光斑](#wzim-ls-nulls) · [Level 1–3 资料汇整](WZIM资料汇整_v1.md)

晶圆台完成[初步归零](#swzs)后，干涉仪（IFM）已有起读坐标。WZIM 接着用水平传感器（LS）建立测量侧（M）的高度和倾角基准。LS 测晶圆表面，Z-IFM 记录台体的 Z 读数。两者在同一测量点配合，才能知道沿 XY 行走时 Z 读数怎样变化。

<a name="wzim-procedure-diagram"></a>

![图 2.1，准备 IFM 与 LS，每卡盘装裸片，在测量侧逐个网格点用 M4 定高并读取 Z-IFM，原卡盘转片复测，更新零点和行走倾斜常数。](../images/WZIM-总流程_v1.png)

**图 2.1　WZIM 总流程。** （01）[准备基准](#wzim-purpose)，（02）[网格定高和取样](#wzim-grid)，（03）[同卡盘转片消楔](#wzim-wedge)，（04）[确定常数与查看结果](#wzim-zero-refs)。图中四段按 L3-《12-TT-L3-L3-ME_book.pdf》文件第 23–29 页（印刷第 15–21 页）归纳。

<a name="wzim-purpose"></a>

### Purpose（目的）

**为什么做。** 光学几何误差会使 WS 沿 X、Y 水平移动时出现随位置变化的 Z 读数，课件分别称为 XTZ、YTZ。WZIM 校正其中的线性项，并给两卡盘各自建立 LS 参考下的名义高度和绕 Y 倾角。它为后续 [WGIM／WS TRIM](WS-IFM机器常数校准项目_v4.md#mc-wgim) 提供合适的测量高度与倾角。完成 TRIM 后再做 CLPL 基准板高度与倾角标定。见 L3-《12-TT-L3-L3-ME_book.pdf》文件第 14、23–28 页（印刷第 6、15–20 页）。

**前置条件。** 已建立 WS 初步归零及 IFM 初始化倾角。确认设备洁净度和温度状态，初始化 LS 并检查测高重复性，确认两卡盘都能正常装载裸片。LS 完整线性化在后续进行，WZIM 用中心光斑 M4 的零输出作高度参考。见 L3-《12-TT-L3-L3-ME_book.pdf》文件第 14、23、26–27 页，L1-《13_AP-L1-ME_rel_3.2.pdf》第 23–24 页。

**表 2.1　WZIM 校准的机器常数**

| 每卡盘的常数 | 从什么测量得到 | 用途 |
| --- | --- | --- |
| `Z0` | 用裸片建立高度零点，以名义厚度晶圆表面位于 M4 零高度定义参考。 | M 侧初始高度零偏，课件列名为 `z0_chuck1_measure_side`、`z0_chuck2_measure_side`。 |
| [`Ry0`](#wzim-ry0) | 以 LS 光斑 M0、M4、M8 在测试晶圆上的观测为参照。 | 更新每卡盘的 M 侧 IFM 归零角，使两卡盘采用同一 LS 倾角基准。 |
| `szxa` | 两轮测得的 X 向 Z 斜率中，分离出对转片不变的部分。 | 修正 M 侧 Z 模型的线性 XTZ。 |
| `szya` | 两轮测得的 Y 向 Z 斜率中，分离出对转片不变的部分。 | 修正线性 YTZ。同一卡盘的曝光侧（E）沿用 M 侧结果。 |

曝光侧的 BMWZ 用两只透射像传感器（TIS）的高度建立参考，仅由这两点无法同时分离 X/Y 行走倾斜。WZIM 的 `szya` 按卡盘共用。见 L3-《12-TT-L3-L3-ME_book.pdf》文件第 27–29、63 页（印刷第 19–21、55 页），L3-《TT-MA-ME_setupblock_1-5_1v3.ppt》第 8、10、15–17 张。[机器常数证据](WZIM资料汇整_v1.md#constants)

<a name="wzim-procedure"></a>

### How（操作流程）

<a name="wzim-translation"></a>

#### 原文操作译文

译自 L3-《12-TT-L3-L3-ME_book.pdf》文件第 27–29 页（印刷第 19–21 页）的 Method、Z0 设置和测试界面。原文按段落说明，图 2.1 按动作归纳。

> 台体沿 X 和 Y 移动时也会在 Z 方向移动，分别简称 XTZ 和 YTZ。校准通过调整干涉仪模型的参数去除这种不需要的 Z 运动。干涉仪归零时使用 Ry0 归零角，使镜块相对于计量框架处在名义姿态。此角度最初由晶圆台初始化倾角试验确定，其值在本测试中被覆盖。
>
> 每个卡盘用一片裸片。在每片晶圆的 XY 网格上，用 Z 干涉仪测量高度。每一点都先使晶圆处于 `LS_M4 = 0`，再记录 Z 干涉仪读数。两个卡盘都只在测量侧测量。
>
> 裸片只测一次时，可能存在的晶圆楔角会叠加到测得的 XTZ 和 YTZ。为避免楔角影响机器常数，两片晶圆绕 Z 旋转 180°，仍装回各自原来的卡盘，在测量侧重复测量。晶圆楔角转向后，测得的 XTZ 和 YTZ 会变化，因此可以从结果中去除楔角。更新测量侧每个卡盘的 Z 干涉仪模型。X 和 Y 干涉仪值分别乘以 `szx0` 和 `szy0`，得到线性 XTZ 和 YTZ 修正项。`szya` 与卡盘有关，与工位无关，测量侧确定的值也用于曝光侧。
>
> 对每个卡盘，测试用的晶圆也设定该卡盘的 Z 等于零的平面。结果暂存为 Z0 归零偏置。后续晶圆台基准板标定通过确定参考高度和光栅高度，精确定义这一平面。以卡盘 1 的测量侧为例，设定偏置，使 Z 干涉仪建立参考并读零时，名义厚度晶圆的表面恰在 `LS_M4 = 0` 高度。除 IFM 参数外，标定 `z0_chuck1_measure_side` 和 `z0_chuck2_measure_side`。本测试还重定 Ry0，使 LS 各光斑的高度偏置与卡盘无关。
>
> 原图 2.7 是测试输入界面的示例。界面显示卡盘、晶圆来源、测量网格的 X/Y 范围及点数等输入。

**按总图操作。** 测每个卡盘时，先完成准备，再在 M 侧逐点把 M4 调到零并保存 Z-IFM 读数。将裸片转 180° 后装回原卡盘，用同一规则再采一轮。用两轮数据分离楔角，求 X/Y 线性修正，再按 LS 基准确定高度和倾角零点。资料给出测量方法，未列各参数的内部执行先后或通用验收阈值。

**侧别核对。** L3 专节和 L3-《TT-MA-ME_setupblock_1-5_1v3.ppt》第 15 张正文都写两卡盘在 M 侧测量。该张讲义备注有“两侧”的不同表述，本章按专节流程和 BMWZ 的曝光侧分工整理。[版本差异](WZIM资料汇整_v1.md#source-differences)

<a name="wzim-principle"></a>

### Principle（校准原理）

<a name="wzim-grid"></a>

#### 步骤 02　用 M4 定高，用 Z-IFM 读数

台体移到一个 XY 点后，调 Z，使晶圆表面到达 M4 的零高度，再记录 Z-IFM。换下一个 XY 点时，M4 的目标仍是同一零输出。若晶圆有楔角，换点会改变实际所需的 Z 调节。若镜块或框架 Z 镜有倾斜，Z-IFM 光程也会随 XY 变化。两种影响都进入网格读数，所以还需要转片复测。见 L3-《12-TT-L3-L3-ME_book.pdf》文件第 24–27 页（印刷第 16–19 页），L2-《TT-L2-ME-3v0.pdf》文件第 36 页（印刷第 30 页），图 1.39。

![图 2.2，L3 原图 2.5 显示校准前后与 LS 平面的关系，右侧示意选取 XY 网格点后先令 M4 零输出再记录 Z-IFM。](../images/WZIM-网格定高取样_v1.png)

**图 2.2　从一个 XY 点取得 Z 观测。** 对应[总图步骤 02](#wzim-procedure-diagram)。（1）为 L3-《12-TT-L3-L3-ME_book.pdf》文件第 27 页（印刷第 19 页）原图 2.5，虚线是 LS 平面。（2）和（3）示意定点、定高、读数。

<a name="wzim-wedge"></a>

#### 步骤 03　转片后分离晶圆楔角

楔角是晶圆厚度沿面内方向的整体变化。把裸片绕 Z 转 180°，它在固定 XY 坐标中的坡度反向，原卡盘及计量系统的贡献保持。两轮分别从网格读数取 X/Y 方向的一阶斜率。平均保留固定斜率，半差给出晶圆楔角对读数的贡献。见 L3-《12-TT-L3-L3-ME_book.pdf》文件第 27 页（印刷第 19 页）。

![图 2.3，同一卡盘转片 180° 前后的晶圆楔角方向与两轮 Z-IFM 读数斜率示意。](../images/WZIM-转片消楔_v1.png)

**图 2.3　两轮测量怎样分离楔角。** 对应[总图步骤 03](#wzim-procedure-diagram)。曲线取 X 方向作示例，Y 方向同理。

两轮的斜率向量分别记为 `s₀°` 和 `s₁₈₀°`，各含 X、Y 两个分量。式（2.1）给出固定斜率 `b` 和楔角贡献 `w`。式（2.2）是更新后的 Z 模型写法，`Z_other` 代表其余项。前者用于理解消楔，后者采用 L3 第 8 张的 `szxa/szya` 命名。实机拟合细节及斜率到写入常数的符号约定未在课件中给出。[公式与证据边界](WZIM资料汇整_v1.md#source-differences)

<a name="wzim-equations"></a>

![式（2.1）固定斜率是两轮斜率的平均，晶圆楔角贡献是半差。式（2.2）Z 等于其他项，加 szxa 乘 X 干涉仪读数，再加 szya 乘 Y 干涉仪读数。](../images/WZIM-equations_v1.png)

<a name="wzim-zero-refs"></a>

#### 步骤 04　建立高度与倾角零点，并核对线性修正

**高度零点 `Z0`。** 用 M4 零高度定义名义晶圆表面的位置，据此设定每卡盘的 Z-IFM 起读偏置。

<a name="wzim-ry0"></a>

**倾角零点 `Ry0`。** `Ry0` 定义每个卡盘的镜块在 IFM 归零时相对于计量框架的名义绕 Y 姿态。WZIM 用 LS 的三只光斑建立这个倾角基准。光斑直接观测测试晶圆上表面，一次观测的 X 向坡度同时包含台体倾斜和晶圆楔角在该方向的贡献。课件明确把转片消楔用于 XTZ/YTZ 的网格斜率，未给出 `Ry0` 的三点计算是否也联合使用两个方位。见 L3-《12-TT-L3-L3-ME_book.pdf》文件第 27–29 页（印刷第 19–21 页），L3-《TT-MA-ME_setupblock_1-5_1v3.ppt》第 17 张。[图 2.6 三点观测的推导](#wzim-three-spot-tilt)

![图 2.4，左侧示意 M4 零高度与名义厚度晶圆表面的关系，右侧示意用三光斑设定共同的 LS 倾角基准。](../images/WZIM-高度与倾角零点_v1.png)

**图 2.4　Z0 和 Ry0 的参考量。** 对应[总图步骤 04](#wzim-procedure-diagram)。（1）用 M4 定初始高度，（2）用 M0、M4、M8 建立倾角基准。三点算法及取样细节在课件中未列出。

<a name="wzim-results"></a>

![图 2.5，L3 原图对照校准前后的高度图。左侧线性倾斜明显，右侧残存曲率，两侧 Z 标度不同。](../images/WZIM-校准前后原图对比_v1.png)

**图 2.5　线性校正前后的高度图。** 对应[总图步骤 04](#wzim-procedure-diagram)。原图为 L3-《12-TT-L3-L3-ME_book.pdf》文件第 28 页（印刷第 20 页）图 2.6。两图 Z 标度不同，校正后线性斜率减小，图中仍有弯曲，后续结合 TRIM 和 Z 残差标定处理。生产中的单次归零还会有小的 Z/Ry 复现误差，由 Stage Align 用基准板参考高度测出。见同书文件第 29、33–35 页（印刷第 21、25–27 页）。

<a name="wzim-three-spot-tilt"></a>

#### 三只 LS 光斑测到的倾斜

图 2.6 假设晶圆有楔角、WS 本身绕 Y 倾斜，沿 XY 行走时 Z-IFM 读数也有线性变化。取 X–Z 剖面，用向右升高为正的坡度说明三者怎样进入观测。

![图 2.6，四个子图分别展示 WS 支承面和晶圆楔形，固定姿态读取 M8、M4、M0 的高度并由高度差和间距得到片面坡度，移动 WS 后以 M4 定高并读 Z-IFM，以及在同一台体倾角下转片 180° 后两次片面坡度平均可消去楔角。式（2.3a）、（2.3b）和（2.4）见图。](../images/WZIM-三光斑倾角与转片消楔_v1.png)

**图 2.6　WS 倾斜、晶圆楔角和行走倾斜怎样进入测量。** （1）、（2）解释[总图步骤 04 的三光斑观测](#wzim-ry0)。（3）对应[步骤 02 定高取样](#wzim-grid)和[步骤 03 转片消楔](#wzim-wedge)。（4）为同姿态消楔的工程推导。

1. **先看两条面。** 蓝线是卡盘支承面，X 向坡度为 `a_WS`。晶圆厚度沿 X 也在变化，坡度记为 `w_x`。两者叠加形成橙色晶圆上表面的坡度。
2. **在同一位姿读三个高度。** 将三路高度放到同一 LS 基准，以 M4 的位置和高度作基准。式（2.3a）把每个高度写成共同高度加片面坡度乘以 X 向距离。以 M0 和 M8 的高度差除以 X 间距，就得到式（2.3b）的**晶圆上表面坡度**。这个剖面示例中，WS 整体升降会同时改变三个高度，做差后抵消。若 WS 的实际绕 Y 姿态随行走改变，三点坡度也会随之改变。
3. **再看 WS 移动时的读数。** 在每个 XY 点调 Z 使 M4 回零，再记 Z-IFM。这里比较的是不同位置的 Z-IFM 读数。由两轮网格数据分离晶圆楔角后，剩下的固定线性斜率用于修正 XTZ、YTZ。
4. **同一卡盘若保持同一倾角再测三点。** 转片后楔角贡献反向，台体坡度保留。对两次三点坡度求平均，式（2.4）给出相对于 LS 基准的台体坡度。`Ry0` 用于给 WS 设定归零参考姿态。L3 确认用三光斑确定这个角，并明确网格测量做转片复测，未说明实机是否也按式（2.4）处理三点数据。见 L3-《12-TT-L3-L3-ME_book.pdf》文件第 25、27–29 页（印刷第 17、19–21 页），L3-《TT-MA-ME_setupblock_1-5_1v3.ppt》第 17 张。

<a name="wzim-ls-nulls"></a>

##### 三点回零与九光斑等高的判读

- **WZIM 网格的实机说明。** 每个 XY 点调台体 `Z` 使 M4 回零，再记 Z-IFM。`Z0` 是校准得到的高度参考偏置。L3 另说明用 M0、M4、M8 定 `Ry0`，未列出逐网格点三光斑同时回零及记录 IFM Ry 的动作。见 L3-《12-TT-L3-L3-ME_book.pdf》文件第 25、27–29 页（印刷第 17、19–21 页），L3-《TT-MA-ME_setupblock_1-5_1v3.ppt》第 17 张。
- **九光斑怎样比较。** M0–M8 沿 X 排列。片面沿该排平直、与 LS 公共高度基准平行，且各通道在有效范围并已校准到共同基准时，九个高度应接近一致。共同高度可以非零。LS 校准报表逐只测量相对 M4 的 Z 零偏。见 L3-《07-TT-L3-LS-2v0.pdf》文件第 12、39、46、48–49 页（印刷第 6、33、40、42–43 页）。
- **刚性装片的工程解释。** 假如用 Z 使 M4 回零、用 Ry 使 M0 与 M8 等高，理想平面上的三点可以同时为零。片面等高时也可能是 WS 坡度与晶圆楔角正好抵消。此时的 IFM Ry 表示把这一片晶圆找平时的台体角度，单次结果无法分离两项贡献。详见[原页和读数核查](WZIM%E4%B8%89%E7%82%B9%E5%BD%92%E9%9B%B6%E4%B8%8ELS%E8%AF%BB%E6%95%B0%E6%A0%B8%E6%9F%A5_v1.md#finding)。

[回到总图](#wzim-procedure-diagram) · [Level 1–3 原图定位](WZIM资料汇整_v1.md#source-figures) · [返回项目目录](#calibration-index)
