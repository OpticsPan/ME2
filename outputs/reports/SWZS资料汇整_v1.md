# SWZS Level 1–3 资料汇整 v1

[用途与边界](#usage) · [前置与后续项目](#dependencies) · [流程原页](#procedure-evidence) · [机器常数与报告](#constants) · [测量原理与原图](#principle-evidence) · [MEtrology.md 的 SWZS](MEtrology.md#swzs) · [成果索引](../README.md)

## 查阅范围

| 层级 | 原文件数 | 源页数 |
| --- | --- | --- |
| L1 | 18 | 1,525 |
| L2 | 50 | 2,588 |
| L3 | 35 | 3,789 |
| 合计 | 103 | 7,902 |

本机 Level 1–3 目录与 MinerU 清单逐份比对，103 份源文件和已保存转换的 SHA-256 一致。逐页检索各转换稿的正文、讲义备注、图注和已识别图中文字，使用 SWZS、Calibrate Zero Sensor、WS Initialization Tilts、Interferometer Zeroing、PSD、Zeroing Offsets、OZP、ZSO、FZP、MI:SZP 等名称及相关测量链定位。复核了 SWZS 专节第 111–115 页原页、上下游设定图及核心物理图。全库采用程序逐页筛查，相关内容和原图作细读，这一覆盖口径与逐幅目检非相关原图有别。

<a name="usage"></a>

## 用途、运行时机与测试边界

| 来源 | 与 SWZS 有关的内容 |
| --- | --- |
| L1-《01_AP-L1-Hardware_Introduction_v2.pdf》文件第 50、96、104 页 | 零传感器与计量框架关联。第 104 页明确其作用是确定 WS 干涉仪系统原点。第 96 页区分长行程与短行程的测量反馈，第 101 页讨论的是 RS。两个同教材命名副本与此内容对应。 |
| L1-《09_AP-L1-Production_Metrology_in-line.pdf》第 9、13–14、23–26、31、40、49–50 页 | M 侧装片后归零再作 Stage Align，然后作调平、对准和晶圆测高。E 侧换台后归零再作条件性 Lot Correction、掩模对准和曝光。零传感器提供六轴粗参考，编码器粗定位用于返回捕获区。第 49 页给出 XYZ ±1 µm、转角 ±2.5 µrad 的生产归零量级。 |
| L1-《13_AP-L1-ME_rel_3.2.pdf》第 17、20–24、30、35、47–48、51、90 页 | 归零偏置把卡盘位姿连到计量框架，标记载体位置及镜面残差属于另外的校准量。旧设定图在后续安排两侧初始高度和倾斜、TRIM、基准板调平。旧 E 侧使用 CS 点 A，M 侧用 LS 中央点。BM-AA 可借 TIS1 更新 M 侧 X₀/Y₀，BMTIS 通过光轴和 TIS1 进一步确定曝光侧光学参考。软件架构把 IFM、差分/零传感器读数与台坐标联系起来。 |
| L1-《10_AP-L1-On-line_calibrations.pdf》第 12、17 页及 L1-《11_AP-L1-IQC.pdf》第 27 页 | 在线 System Correction 为曝光侧更新 WS 初始 Rx 倾角。IQC 列举 `Rx0_e_chuck1/Rx0_e_chuck2`，属于运行中对像面漂移的补偿。L1-《12e_AP-L1-SL- Software Architecture.pdf》第 28 页将水平偏移与尺度列为 Stage Align 的输入输出关系。 |
| L2-《TT-L2-ME-3v0.pdf》文件第 10–14、19、26–29、48–49 页（印刷第 4–8、13、20–23、42–43 页） | 装片或换台后，编码器带台返回 IFM 范围，固定在计量框架上的零传感器建立参考。M 侧之后 LS-M4 测 TIS1/2 高度，AA 找 I0 对准标记，估计 Z/Ry 与 X/Y 归零误差。E 侧归零为 TIS/Reticle Align 或 Lot Correction 提供捕获位姿，在所述序列设定 Rx。典型复现量级约 1 µm 和 ±2.5 µrad，属于生产说明。扩展 Stage Align、System Correction 和面向光轴的细参考另列。 |
| L2-《12-TT-L2-ME-module.pdf》文件第 11–12、16–19、28、37 页 | 与前一文件的 M/E 捕获、零传感器和后续光学读数互证。第 37 页（印刷第 29 页）的 XYZ <1 µm、Rx/Ry <5 µrad 是基准板调平参数验证的前提。两卡盘 TIS/Abbe 板同向漂移是该验证考虑的零传感器漂移现象，不能据此认定 SWZS 判据。 |
| L2-《12-TT_L2_ME_2v3new.pdf》文件第 5、8、11、20 页（原幻灯片 9、16、21、39） | 有 E 侧三个零传感器的结构图，说明 IFM 的六轴粗参考与后续 TIS 标记精参考。课件所示生产环节中 E 侧无额外 Rx 精归零。L2-《TT-L2-ATS-3v0.pdf》第 8、10–11、27 页、L2-《11-TT-L2-AL-module.pdf》第 8–10、37 页及 L2-《TT-L2-LS-3v0.pdf》第 20 页可交叉验证归零后的 LS、AA、TIS 捕获。 |
| L3-《09-TT-L3-WSbook.pdf》文件第 73、111–115 页（印刷第 65、103–107 页） | 章节适用 WS Type-2、软件 rel.3.4，SWZS 专节定义两卡盘 × 两工位四组合。完整校准用于 TWINSCAN 设定及更换零传感器部件后。初始化快归零无法执行时可用 Update FZP；完整校准已重定 FZP。示例报表为 release 3.4.0。 |
| L3-《12-TT-L3-L3-ME_book.pdf》文件第 14、26–29 页（印刷第 6、18–21 页）与 L3-《TT-MA-ME_setupblock_1-5_1v3.ppt》第 7、9–10 张 | 工厂执行初始化倾角，现场机械接合后有关参考须重定。第 7 张将完整工厂校准列为现场通常无需默认重做的项目，第 9 张讨论现场重定时的姿态与回波寻峰。适用操作取决于设定阶段或现场触发事由。 |
| L3-《05-TT-L3-TIS-2v0.pdf》文件第 14 页及 L3-《TT-MA-AA-part1-FUD-3V1.ppt》第 8 张 | 粗归零由零传感器提供，随后用卡盘上的 TIS1/2 建立所需光学参考。每侧从计量框架向下观测三个角锥，归零点的 IFM 机器坐标可以是非零。 |

L1、L2 可交叉确认传感器作用、生产交接和后续光学测量。SWZS 的操作顺序、模式互锁、机器常数和报表以 L3 专节为主。L2-《TT-L2-WS-3v0.pdf》与 L2-《TT-PM-WS-3v1.pdf》第 54 页关于“校准零传感器”的排故条目针对 RS。其他掩模台零传感器、装载传感器、LS 工作点、光束指向 PSD 归属各自系统。

<a name="dependencies"></a>

## 前置条件与后续项目

- **准备条件。** BF 校准已完成，空气支承 AM 已开启且稳定，SWSW 卡盘交换校准、SWHP 干涉仪调整与诊断、SWDC 差分传感器校准已完成。L3-《09-TT-L3-WSbook.pdf》文件第 111 页（印刷第 103 页）和 L3-《TT-MA-WS-Calibrations-3v1.ppt》第 100 张。后者第 101 张列无需额外工具、估计 30 分钟，讲义说明不再使用专用对准工具。SWHP 手动增益调整是其第 186–195 张的 B-spec 附录示例。
- **整机设定中的位置。** L3-《09-TT-L3-WSbook.pdf》文件第 76 页（印刷第 68 页）图 2.1 的第 10–13 项是 BF、换台、接收器增益、差分传感器增益。第 17 项是零传感器校准，后接热性能、低性能时间响应/传递检查、IFM 测量范围、HP 镜面质量等。文件第 102 页的 SWDC 流程检查 SWZS 是否完成，属于条件检查。
- **计量设定分支。** L3-《12-TT-L3-L3-ME_book.pdf》文件第 14–15 页（印刷第 6–7 页）图 1.3 支持两条分支。左侧为 BMAA 粗校 → 精校。中侧为 [WZIM](WS-IFM机器常数校准项目_v4.md#mc-wzim) → [WGIM](WS-IFM机器常数校准项目_v4.md#mc-wgim) → CLPL 基准板调平，再进入 AA 光束倾角与焦点、M 侧 WS XY IFM、BMAA 精校。AA 光束倾角与焦点要求先完成左支路。WGIM 后还可进入 Spot Sensor Position、RS Rotation/Position Offset、Reticle Load Offset 支路。WZIM 会重定 M 侧的 `Ry0`，CLPL 通过参考高度查 Z/Ry 归零误差。见同书文件第 27–29、33–35 页。
- **明确的 WS 服务依赖。** L3-《TT-MA-WS-Calibrations-3v1.ppt》第 79 张把零传感器已校准列入 SWCR 范围检查前提，第 144、211 张把它列入 SWSM 短行程电机校准前提。L3-《09-TT-L3-WSbook.pdf》文件第 127、141 页（印刷第 119、133 页）说明 SWSM 的增益平衡与位置相关，试验在台体零位进行。
- **保存后的复校。** 完整 PSD Calibration 若更新 MC，需复做部分 Metrology setup。单独 Update FZP 若更新 MC，需复做 Baseframe 与 Wafer Handler 校准。L3-《09-TT-L3-WSbook.pdf》文件第 112 页（印刷第 104 页）、L3-《TT-MA-WS-Calibrations-3v1.ppt》第 105 张。资料没有在该处列完整复校清单。

<a name="procedure-evidence"></a>

## 操作流程原页

| 原始出处 | 核对结果 |
| --- | --- |
| L3-《09-TT-L3-WSbook.pdf》文件第 111 页（印刷第 103 页） | 列出运行时机、四个组合和五项前置条件。完整 PSD Calibration 重新确定 FZP。 |
| 同一 L3 文件第 112 页（印刷第 104 页） | 原页软件流程从 IF Align 开始，依次设置默认值、初始化至 SS 6DOF on IFM、找中心、以 IF 为参考校准增益、用粗增益重新找中心、检查、计算 OZP、复测增益、校准偏置、计算 FZP、计算传感器位置、计算 MISZP。检查项为零传感器光强和电子学、HP 与差分传感器量程、零传感器光束位置。原图 2.33 是输入界面。 |
| 同一 L3 文件第 113 页（印刷第 105 页） | IFM-align 单跑只检查。PSD Calibration 为包含 IFM-align 的完整校准，界面禁用独立 Update FZP。Update FZP 根据基座偏置改正 FZP，IFM-align 与 PSD Calibration 两项均不可选。 |
| 同一 L3 文件第 114–115 页（印刷第 106–107 页），图 2.34–2.35 | 报表示例显示四组合成功、MC 保存、实际选项和各项结果。样例包含默认设置，报表末尾还有未展示的中间结果。课件报告给出了读数及标志字段，没有给出本测试的数值验收限。 |
| L3-《TT-MA-WS-Calibrations-3v1.ppt》第 97–108 张 | 跨证目的、三种运行模式、原文软件顺序、保存后的复做要求和报表。原页对照解决了 MinerU 对第 104 张将步骤 8–13 先排出的版面顺序问题。 |

<a name="constants"></a>

## 机器常数和报告字段

| 名称 | 物理量和用途 | 来源 |
| --- | --- | --- |
| `Zero Sensor Gain Matrix` | 三只 PSD × 双方向的六路电压对六轴位姿的局部响应，6×6。报表平移增益 V/m，转角增益 V/rad，包含跨轴影响。 | L3-《09-TT-L3-WSbook.pdf》文件第 111、115 页（印刷第 103、107 页）。 |
| `ZSO` 与 `u0/v0` | ZSO 是六轴零传感器偏置，单位 m、rad，参与求 FZP。另列三只 PSD 各 u0/v0 的电压零偏，单位 V。 | 同一 L3 文件第 114–115 页（印刷第 106–107 页），图 2.34–2.35。 |
| `FZP` | Fast Zero Position，快归零捕获使用的位姿数组，单位 m、rad。完整流程用 OZP 及零偏求出，独立 Update FZP 相对 BF 偏置修正。 | 同一 L3 文件第 111–115 页（印刷第 103–107 页）。 |
| PSD sensor positions | 报表以基座坐标列每只 PSD 的位置、`found`、`intens.ok`、`electr.ok`。计算顺序为 FZP 后、MISZP 前。 | 同一 L3 文件第 112、114 页（印刷第 104、106 页）。 |
| `MI:SZP` 或 `MISZP` | IFM 接管时加载的六轴机器坐标，单位 m、rad。非零坐标示例见原图 1.5。 | 同一 L3 文件第 111–115 页（印刷第 103–107 页），L2-《TT-L2-ME-3v0.pdf》文件第 11 页（印刷第 5 页）。 |
| `Rx0/Ry0/Rz0` | WS Initialization Tilts 中按卡盘和工位求的初始化倾角。用 IFM 回波质量找合适姿态。M 侧 Ry0 后续可由 WZIM 重定。 | L3-《12-TT-L3-L3-ME_book.pdf》文件第 26–29 页（印刷第 18–21 页），L3-《TT-MA-ME_setupblock_1-5_1v3.ppt》第 9–10 张。 |
| `OZP` | 用粗增益和光斑中心计算的中间位置，用于重测增益并参与后续 FZP 计算。 | L3-《09-TT-L3-WSbook.pdf》文件第 112 页（印刷第 104 页）。 |

<a name="principle-evidence"></a>

## 测量原理与相关原图

- **IFM 对准与相位测位。** 回波强度用于选初始化倾角，IFM 位姿增量来自各通道的相位或频率变化及几何解算。L2-《TT-L2-WS-3v0.pdf》文件第 27 页（印刷第 21 页）图 1.30，L3-《09-TT-L3-WSbook.pdf》文件第 57–61 页（印刷第 49–53 页）图 1.59–1.66。L3-《TT-MA-ME_setupblock_1-5_1v3.ppt》第 9 张原图为 IFM 信号强度随 Rx 的变化，培训原图未逐一显示所有读数头，也未给出联合寻峰准则。
- **PSD 光斑测位。** 每侧三只固定零传感器与卡盘镜块上的三个角锥配对。各回波在 PSD 面提供两方向光斑位置，三只合计六路位置电压。标定时用 IFM 相对位姿变化作为已知输入，同步采集 PSD 读数。在局部线性示意中，已知某轴增量时，六路电压响应斜率组成 G 的对应列。G 表示灵敏度，参考零位还需由中心、偏置及位置标定确定。L3-《09-TT-L3-WSbook.pdf》文件第 62–63、111–115 页（印刷第 54–55、103–107 页）。
- **生产归零和 IFM 接管。** PSD 定位参考后，IFM 加载 MI:SZP，再跟踪相对位移。以参考为本次增量的起点时增量为零，存入 IFM 的机器坐标可以非零。用 G 的线性逆关系解释电压差与位姿偏差需假定在参考附近且 G 满秩，实际软件细节未披露。L2-《TT-L2-ME-3v0.pdf》文件第 10–11、19 页（印刷第 4–5、13 页），L3-《09-TT-L3-WSbook.pdf》文件第 112、115 页（印刷第 104、107 页）。
- **通用器件示意。** 现有报告的归一化光电流差公式取自外部 [Hamamatsu PSD 技术说明](https://www.hamamatsu.com/content/dam/hamamatsu-photonics/sites/documents/99_SALES_LIBRARY/ssd/psd_kpsd9001e.pdf#page=2) 第 2 页图 1-1、式 (1-3)。L3 资料能够确认 SWZS 的 u/v 读数与增益字段，实机 PSD 的内部电路和型号仍需专门硬件资料。

| 原图出处 | 核对内容或本机定位 |
| --- | --- |
| L1-《13_AP-L1-ME_rel_3.2.pdf》第 22、24 页 | 旧 WS/ME 设定块和 M/E 高度、TRIM、基准板调平顺序。本机 `assets/4542989d5f133071/slides/images/page_21_image_2_v1.jpg`、`page_23_image_3_v1.jpg`。 |
| L2-《TT-L2-ME-3v0.pdf》文件第 11 页（印刷第 5 页），图 1.4、1.5 | 同一位姿的编码器控制与 IFM 控制对照。图 1.5 红字列六轴参考坐标。`assets/e9dff352e800b276/images/page_10_image_4_v1.jpg`、`page_10_image_9_v1.jpg`。 |
| L3-《09-TT-L3-WSbook.pdf》文件第 62–63 页（印刷第 54–55 页），图 1.68、1.69 | 图 1.68 标出三只框架传感器及镜块角锥，图 1.69 从框架底面区分 M/E 两组三只传感器。见 [MEtrology 原图](MEtrology.md#swzs-figure-168)。 |
| L3-《09-TT-L3-WSbook.pdf》文件第 76 页（印刷第 68 页），图 2.1 | WS Full Setup 原页列出 SWZS 为第 17 项，核对前置与后续顺序。 |
| L3-《12-TT-L3-L3-ME_book.pdf》文件第 14 页（印刷第 6 页），图 1.3 | 原页箭头显示 Initialization Tilts 分出 BMAA 与初始高度/TRIM 两条支路，后续汇合。 |
| L3-《09-TT-L3-WSbook.pdf》文件第 112、114–115 页（印刷第 104、106–107 页），图 2.33–2.35 | 输入模式、四组成功与保存标志、PSD 位置、电压零偏及增益表。L3-《TT-MA-WS-Calibrations-3v1.ppt》第 102 张给同一类界面。 |

[返回 SWZS 正文](MEtrology.md#swzs)
