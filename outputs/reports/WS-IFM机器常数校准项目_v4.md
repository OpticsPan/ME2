# WS-IFM 机器常数校准项目 v4

[初步归零](#initial-zero) · [直接校准](#core-calibrations) · [WGTD 参数表](#wgtd-fields) · [镜面图与残差补偿](#mirror-maps) · [归零与外部基准](#reference-setup) · [旧版流程](#legacy-configurations) · [实机参数核对](#parameter-evidence) · [原图索引](#source-figures) · [成果索引](../README.md)

WS 先通过 [SWZS](#initial-zero) 建立 IFM 的初步归零参考。直接校准 WS-IFM 解算参数的项目是 **WZIM、WGIM、WTAF、WZTD、BMWZ 和 WGTD**。**GRMO** 校准坐标网格的非正交与相对尺度，**GIWS、WTAM** 建立及细调位置相关的镜面修正表。定位某个参数时，先区分它修正的是光路解算、读数零点、坐标网格，还是曝光焦面的残差。

本报告仅依据本机 Level 1–3。主线以 Level 3 的 TWINSCAN IFM 配置、AT3.4 无 CS 流程为准，Level 2 用于核对 TRIM 的测量与拟合，Level 1 用于辨认 rel.3.2 带 CS 流程及在线更新。M 为测量侧，E 为曝光侧，MC 为机器常数。WS 为晶圆台，RS 为掩模台，LS 为水平传感器，AA 为高级对准传感器，TIS 为透射像传感器，CS 为置信传感器。AT3.4 中 M/E 的校准基准分别来自 LS/AA 和 TIS/像面。涉及两卡盘和双工位的数据应分别核对，尤其注意 WZIM 的同卡盘跨侧共用项。来源见《12-TT-L3-L3-ME_book.pdf》文件第 19–20、27–29 页（印刷第 11–12、19–21 页）。

<a name="initial-zero"></a>
<a name="mc-szws"></a>
<a name="mc-swzs"></a>

## WS 初步归零

| 项目 | 目的与工位 | 校准量 | 流程与出处 |
| --- | --- | --- | --- |
| **SWZS — WS 初步归零** | 为 IFM 建立相对计量框架的六自由度参考。两卡盘 × M/E 四组。 | 校准 PSD 增益矩阵、零偏、传感器位置、FZP、MI:SZP。相关的初始化倾角为 `Rx0/Ry0/Rz0`。 | 先建立 IFM 反馈，再用已知运动测 PSD 中心、增益与偏置，最后生成各零位。见 [原理、流程和原图](MEtrology.md#swzs)。出处为《09-TT-L3-WSbook.pdf》第 62–63、111–115 页（印刷第 54–55、103–107 页）、《TT-MA-WS-Calibrations-3v1.ppt》第 97–108 张。 |

<a name="core-calibrations"></a>

## 直接校准与 XY 坐标基准

| 项目 | 工位与目的 | 校准的机器常数 | 流程 | Level 1–3 出处 |
| --- | --- | --- | --- | --- |
| <a name="mc-wzim"></a>**WZIM — 初始高度和倾斜** | M，两卡盘。以 LS 平面为高度基准，消除 WS 沿 X/Y 行走产生的一阶 Z 串扰。 | 各卡盘的 `Z0`、`Ry0`、`szxa`、`szya`。`Z0/Ry0` 为高度和倾角零点，`szxa/szya` 为沿 X/Y 的 Z 行走倾斜。同一卡盘 E 侧沿用 `szya`。 | 在裸片上以 LS M0/M4/M8 建立高度和倾角基准。在 XY 网格由 LS M4 定高并采 Z-IFM 读数，在原卡盘上将裸片转 180° 重测以抵消晶圆楔角，求零点和 XTZ、YTZ 的线性分量。 | 《12-TT-L3-L3-ME_book.pdf》第 27–29 页（印刷第 19–21 页），图 2.5–2.8。《TT-MA-ME_setupblock_1-5_1v3.ppt》第 10–18 张。 |
| <a name="mc-wgim"></a>**WGIM — WS TRIM** | M/E，两卡盘。修正 Rz 的倾角和位置依赖，校正 Z-IFM 测得的 Ry 随 X 变化的一阶误差。 | Rz 对 Rx/Ry 与 X/Y 的耦合参数，`srxa` 为 Ryz 的 X 向贡献。课件整理 Z 模型时还把 Z 尺度 `sfz` 归于 TRIM。完整报表字段待核。 | 改变 Rx/Ry、X/Y，比对冗余的 Rzx/Rzy。沿 X 移动时另比对 Ryz/Ryx。三类效应联合拟合，见 [TRIM 设定与验证](#trim-verification)。 | 《12-TT-L3-L3-ME_book.pdf》第 30–33、57 页（印刷第 22–25、49 页），图 2.9–2.13。《TT-MA-ME_setupblock_6-8_1v3.ppt》第 35 张备注。 |
| <a name="mc-wtaf"></a>**WTAF — XY IFM 倾斜依赖** | M，两卡盘。让 AA 看到的 XY 在 WS 绕 Rx/Ry/Rz 转动时保持一致。 | 每卡盘 10 项 XY IFM 参数，含 XY Abbe 臂 `ax`、`ay`。重做时会更新先前的 Ry Abbe 臂。其余字段待核对 WTAF 原报表。 | 在 AA 已粗定焦的条件下，分别读取 TIS1-I0、TIS2-I0，施加正负 Rx/Ry/Rz，以表观 XY 位移对倾角的变化拟合。精设定在 BMAA fine 后复做。 | 《12-TT-L3-L3-ME_book.pdf》第 43–45、89 页（印刷第 35–37、81 页）。《TT-MA-ME_setupblock_1-5_1v3.ppt》第 44–46 张。《TT-MA-ME_setupblock_6-8_1v3.ppt》第 31–32 张。 |
| <a name="mc-wztd"></a>**WZTD — Z IFM 倾斜依赖** | M，两卡盘。让 Z-IFM 的有效倾转点与 LS M4 对应，保持同一高度时两者读数一致。 | Z-IFM 有效倾转点及 Z 的姿态补偿参数。字段名、单位及项数待核对 WZTD 原报表。 | LS–AA 确定 M4 的 XY 位置。裸片摆到多个 XY 位置，由 LS 定高，施加 Rx/Ry/Rz，读取 Z-IFM，从表观厚度随姿态的变化拟合补偿。 | 《12-TT-L3-L3-ME_book.pdf》第 58–60 页（印刷第 50–52 页），图 2.44。《TT-MA-ME_setupblock_1-5_1v3.ppt》第 77–82 张。《07-TT-L3-LS-2v0.pdf》第 32–33 页（印刷第 26–27 页）。 |
| <a name="mc-bmwz"></a>**BMWZ — E 侧初始高度和倾斜** | E，两卡盘。以 TIS 测量的掩模标记像面定曝光侧 Z 零点及 X 向行走倾斜。 | E 侧 `Z0`、`szxa`，`szya` 沿用 M 侧 WZIM。观测可辨识的是 `Z0+Lz` 和 `szxa+Lry`，此步骤将 `Lz/Lry` 设为零。联合报表还列出 WS IFM 尺度 `Mx/My`（ppm）。 | 以设置掩模和 RS TIS 基准作粗扫，再让两只 WS TIS 测正常标记，求像面高度及两点高度差，定 `Z0/szxa`。`Capture` 恢复模式只更新 WS 零点和扫描倾斜。 | 《12-TT-L3-L3-ME_book.pdf》第 63–66 页（印刷第 55–58 页），图 2.48、2.50。《TT-MA-ME_setupblock_1-5_1v3.ppt》第 89–94 张。 |
| <a name="mc-wgtd"></a>**WGTD — XYZ IFM 倾斜依赖** | E，两卡盘。以投影镜头下的 TIS 像点为参考，修正 XYZ 对 Rx/Ry/Rz 的依赖。 | 曝光侧报表覆盖 XY 光束几何、入射角、Z 一阶及二阶耦合。见 [23 个拟合字段及单位](#wgtd-fields)。 | BMTIS 后，让 WS 的 TIS1/TIS2 各测 RS 的 T1/T2，形成 2×2 组合。各组合在多种姿态下读取 XYZ，联合拟合分离 IFM 姿态响应与标记、镜头、TIS 位置、镜面图误差。 | 《12-TT-L3-L3-ME_book.pdf》第 89–92 页（印刷第 81–84 页），图 2.83–2.86、表 2.2。《TT-MA-ME_setupblock_6-8_1v3.ppt》第 33–38 张。 |
| <a name="mc-grmo"></a>**GRMO — XY 非正交及 Y/X 比例** | M/E，两卡盘。补 GIWS 镜面图无法确定的网格线性分量。 | XY 非正交量、Y/X 相对尺度。资料说明通过调整 TIS1/TIS2 基准位置落实尺度，掩模对准后重新调整至名义间距。底层 MC 键名待核。 | 两卡盘各曝光一层四向 XPA 十字图案。两卡盘在 M 侧分别以 0° 和 90° 装片读两层。用转向前后的坐标和距离分离 M/E 的非正交和相对尺度。 | 《12-TT-L3-L3-ME_book.pdf》第 96–98 页（印刷第 88–90 页），图 2.95–2.99。《TT-MA-ME_setupblock_6-8_1v3.ppt》第 50–58 张。 |

<a name="trim-verification"></a>

### TRIM 设定与验证

Level 2 描述的覆盖全片网格为 **5×5 个 XY 位置，每点 17 组 Rz/Rx/Ry/Z 激励**。记录的八路是 WS 的解算量 `X/Y/Z/Rx/Ryx/Ryz/Rzx/Rzy`。其中 Rzx 和 Rzy 分别来自 X/Y IFM，Ryx 和 Ryz 分别来自 X/Z IFM。两上束不同高会在转动时产生假 Rz，镜面或光束不平行会产生随 XY 位置变化的旋转读数差。设定利用两组冗余，联合拟合 Rz 倾角依赖、Rz 位置依赖及 Z 镜不平行造成的 Ryz 误差。来源为《TT-L2-ME-3v0.pdf》第 58–59 页（印刷第 52–53 页）、《12-TT-L2-ME-module.pdf》第 39–40 页（印刷第 31–32 页）。

Level 2 维护流程的正常结果是 OK/NOK，合格时无需更新。课件的超限处理则明确列出保存 MC 后再跑确认。两份 Level 2 资料分别列 `csme072.per` 和 `csme072.adj`，应按机台版本核对 Coach 流程，并以实机报告的保存状态判定写入。Level 3 精设定前复查特别看 `srxa`，用于观察计量框架镜支承的漂移。来源为《TT-L2-ME-3v0.pdf》第 57–58 页、《12-TT-L2-ME-module.pdf》第 39–40 页（印刷第 31–32 页）、《12-TT-L3-L3-ME_book.pdf》第 57 页（印刷第 49 页）。

<a name="wgtd-fields"></a>

## WGTD 报表的 23 个拟合字段

E 侧 Chuck 1 的字段组为 `wse_chuck1_if_model_parameters`。报表含 `Current / New / Delta`，该次样例标为 **`Machine Constants: Not Saved`**。下表单位按该版本报表，字段物理定义按同页表 2.2。来源为《12-TT-L3-L3-ME_book.pdf》第 91–92 页（印刷第 83–84 页），图 2.85–2.86、表 2.2。

| 组别 | 参数 | 报表单位 | 物理含义 |
| --- | --- | --- | --- |
| XY 几何（8） | `K/L`、`ax/ay`、`cx/cy`、`dd/ee` | mm | `K/L` 为 TIS 至 X/Y IFM 的距离。 `ax/ay` 为 X/Y 上束到 TIS 焦面的竖直距离。 `cx/cy` 为对应两上束水平间距的 1/4。 `dd` 是 Y-IFM 的 X 向偏移，`ee` 是 X-IFM 的 Y 向偏移。 |
| XY 入射角（4） | `Ryix0/Rzix0`、`Rxiy0/Rziy0` | µrad | 分别是 X-IFM 的 Ry/Rz 误差角和 Y-IFM 的 Rx/Rz 误差角。 |
| Z 一阶姿态（3） | `ezxa`、`ezya`、`ezza` | µm | 分别对应 Rx、Ry、Rz 对 Z 的贡献。 |
| Z 位置×姿态（4） | `czxxa`、`czxya`、`czxza`、`czyya` | mrad | 分别对应 X·Rx、X·Ry、X·Rz、Y·Ry。 |
| Z 二阶姿态（4） | `dzxxa`、`dzyya`、`dzzza`、`dzxza` | mm | 分别对应 Rx²、Ry²、Rz²、Rx·Rz。 |

<a name="related-calibrations"></a>
<a name="mirror-maps"></a>

## 镜面图、时延与残差补偿

| 项目 | 目的 | 输出或更新项 | 流程与来源 |
| --- | --- | --- | --- |
| <a name="mc-giws"></a>**GIWS — 绝对 XY/Rz 镜面图** | 校正台体扫描时镜面不平引起的 XY 与 Rz 误差。 | 按侧和卡盘存 `XRZ`、`YRZ`、`XTY`、`YTX`，1 mm 查表网格，中间值插值。 | 对每对上束，在正反扫中交换固定束和测量束，由差分构造 Rz 图。再按束间距把 Rz 数据分组，求平滑线和组间偏置，得到横向位移图。来源为《12-TT-L3-L3-ME_book.pdf》第 93–95 页（印刷第 85–87 页），图 2.87–2.92。 |
| **镜面图段 — XRY/YRY** | 修正随 X/Y 扫描变化的 Ry 读数。 | `XRY`、`YRY`，用于 Ryz 的位置补偿。 | 以 Ryz−Ryx 构图。沿 X 扫时 X 光束仍在同一 X 镜位置，Ryx 可作参考。沿 Y 扫时课件假设 X 镜误差相对较小，将主要差值归到 Ryz。来源为《TT-MA-ME_setupblock_6-8_1v3.ppt》第 43–44 张。 |
| <a name="mc-wtam"></a>**WTAM — WS 绝对台体网格 ASG** | 降低 GIWS 后仍存在的下束镜面误差与卡盘间相对套刻差。 | 两卡盘 × 双侧的 `XTY`、`YTX`，共八张 MI 表。 | 两卡盘各曝光 BA-ASG 标记的交错行/列，显影后两边读回。用零层对准及共同掩模分离晶圆和掩模项，将卡盘间残差分摊到两卡盘原图。来源为《12-TT-L3-L3-ME_book.pdf》第 100–102 页（印刷第 92–94 页），图 2.101–2.105。《TT-MA-ME_setupblock_6-8_1v3.ppt》第 64–73 张。 |
| **XYVO — 扫描方向依赖** | 修正扫描方向与速度改变时的 RS–WS 数据相对时延。 | 各卡盘 `Data Delay Ty`。报表单位 nm/(m/s)，等价于 ns。该量属于动态时序。 | 同晶圆场内分别正、反向扫描曝光，显影读回两组标记的 Y 差，按扫描速度拟合时延。来源为《12-TT-L3-L3-ME_book.pdf》第 99 页（印刷第 91 页）、《TT-MA-ME_setupblock_6-8_1v3.ppt》第 59–63 张。 |
| <a name="mc-fpcm"></a>**FPCM — Combined FOCAL** | 校正 WGIM 后残留的 M/E 相对 X 向 Z 镜曲率对焦面的影响。 | KU 常数 `Blue Focus Offset Z mirror X-curvature`，用于曝光焦面补偿。 | 按不同焦点曝光，显影后用 AA 读标记位移并拟合最佳焦点，从场间焦点的 X 向残差分离曲率。来源为《12-TT-L3-L3-ME_book.pdf》第 104–106 页（印刷第 96–98 页）、《TT-MA-ME_setupblock_6-8_1v3.ppt》第 77–95 张，尤其第 92 张。 |
| **XYDO — Final XY** | 精调曝光套刻中的场间网格尺度，并分离场内误差。 | 课件列出 WS scaling 更新与 TIS1/TIS2 间距调整，具体底层字段待核。 | 用双卡盘参考层和错位套刻层拟合场内、场间误差，将 WS 尺度用于场间倍率修正。来源为《12-TT-L3-L3-ME_book.pdf》第 114 页起（印刷第 106 页起）、《TT-MA-ME_setupblock_6-8_1v3.ppt》第 96–110 张。 |

<a name="reference-setup"></a>

## 归零与外部基准

| 项目 | 目的及输出 | 流程与来源 |
| --- | --- | --- |
| **CLPL — WS 基准板调平** | 更新 TIS1/TIS2 的参考高度、光栅高度及板的高度/倾角。ILIAS 存在时也测。用于跨侧高度基准及生产内 Z/Ry 归零误差的测定。 | 在 M 侧用 LS M4 按基准点、光栅点与平面拟合点测高，再用 Z-IFM 定各点高度和板面倾角。来源为《12-TT-L3-L3-ME_book.pdf》第 33–35 页（印刷第 25–27 页）、《TT-MA-ME_setupblock_1-5_1v3.ppt》第 27–31 张。 |
| **BMAA、BMTIS、LS–AA** | 分别提供 WTAF 的 AA 标记参考、WGTD 的 TIS 像点/高度基准、WZTD 的 LS M4 位置。 | 分别校准对准标记、像传感器与 LS 光斑相对 AA 的坐标。出入参数及操作分解见 [TWINSCAN 的晶圆台测校总表](TWINSCAN测校项目清单_v2.md#晶圆台-ws)。主要来源为《12-TT-L3-L3-ME_book.pdf》第 43–45、58–60、89–90 页（印刷第 35–37、50–52、81–82 页）。 |
| **SYCO — 在线 Rx 漂移补偿** | 更新两卡盘 E 侧 WS 相对像面的 Rx 初始化偏置。 | 批次间用 TIS1 正常模式测 RS 基准标记的空间像，拟合像面姿态并更新 Rx 偏置。Level 1 同时列出在线观测可计算 WS 的 XY IFM 尺度，具体软件写入项以对应版本流程为准。来源为《10_AP-L1-On-line_calibrations.pdf》第 5–12 页、《TT-L2-ME-3v0.pdf》第 26 页，图 1.26。 |

SWHP 是旧接收器增益和 IFM 信号诊断。SWDC 用 IFM 作为基准校准差分传感器的增益矩阵。两者的参数边界及流程见 [TWINSCAN 的晶圆台测校总表](TWINSCAN测校项目清单_v2.md#晶圆台-ws)。来源为《TT-MA-WS-Calibrations-3v1.ppt》第 70–77、186–195 张。

<a name="legacy-configurations"></a>

## rel.3.2 带 CS 的对应项目

| 项目 | 目的及更新项 | 流程与来源 |
| --- | --- | --- |
| **ATM / WS XY IFM 校准** | 建立 XY Abbe 臂并精调其他 XY IFM 参数。 | 用 ACM 的 ATM 标记提供 XY 观测，按 Abbe 粗校 → AA 粗定焦 → Abbe 及 XY 参数精校 → AA 精定焦的次序进行。来源为《13_AP-L1-ME_rel_3.2.pdf》第 29 页。 |
| **CS 版 WS Z Tilt Dependency** | 用 CS 中心光斑建立 Z 姿态补偿。 | 在 M/E 各由 CS 定高，改变 XY 与姿态，从 CS 与 Z-IFM 的读数差拟合补偿。AT3.4 无 CS 时，M 侧 WZTD 使用 LS，E 侧 WGTD 使用 TIS。来源为《07-TT-L3-LS-2v0.pdf》第 32–33 页（印刷第 26–27 页），图 4.1。 |
| **相对 Z-IFM 镜面图** | 校正 M 侧高度图到 E 侧回放时的镜面高度差。派生 `XTZ/YTZ/YXTZ` 相对图，并入 E 侧绝对图。 | 用 CS 在超平裸片和 TIS 板上按同一 XY 网格读高，换台后从 M/E 两张图相减消去晶圆共同面形。rel.3.2 的例子将 M 侧绝对图置零。来源为《13_AP-L1-ME_rel_3.2.pdf》第 62–68 页。 |
| **Chuck-to-Chuck Mapping** | 降低双卡盘在 M/E 的相对横向定位差，细调 `XTY/YTX`。 | 双卡盘交错曝光行/列，显影后由两卡盘读取同组标记，从相对位置残差生成镜面图增量。来源为《13_AP-L1-ME_rel_3.2.pdf》第 72–80 页。 |

<a name="parameter-evidence"></a>

## 实机参数核对

| 观察到的误差或待核常数 | 先查项目 | 核对内容 |
| --- | --- | --- |
| 保持倾角，沿 XY 行走时 Z 线性变化 | [WZIM](#mc-wzim)、[BMWZ](#mc-bmwz) | 查卡盘及侧别、`Z0`、`szxa/szya`。M 侧和 E 侧的参考面分别核对。 |
| XY 固定或缓慢移动，改变台体倾角时 XYZ 漂移 | [WTAF](#mc-wtaf)、[WZTD](#mc-wztd)、[WGTD](#mc-wgtd) | 分别查 AA、LS M4、TIS 的参考位置，核对 Abbe 臂的两个端点、单位、字段符号与保存状态。 |
| Rzx/Rzy 或 Ryx/Ryz 存在随姿态及位置变化的差 | [WGIM](#mc-wgim)、[GIWS 与 XRY/YRY](#mirror-maps) | 对照同一侧、同一卡盘的 TRIM 参数和镜面表，区分一阶耦合、随位置变化的残差与验证结果。 |
| 网格夹角、Y/X 比例、绝对尺度或卡盘间套刻差 | [GRMO](#mc-grmo)、[GIWS](#mc-giws)、[WTAM](#mc-wtam)、[XYDO](#mirror-maps) | 核对非正交、相对尺度、查表数据与曝光倍率是哪个步骤的输出。报告中的 `Mx/My` 和软件底层尺度键名需凭实机报表对应。 |
| E 侧剩余 X 向焦面弯曲 | [FPCM](#mc-fpcm)、[旧版相对 Z 图](#legacy-configurations) | 先确认有无 CS 和流程版本，再查 KU 焦面补偿或旧版相对镜面图。 |

现有资料可确认 WGTD 的 23 个候选字段、WZIM/BMWZ 的关键零偏和行走参数、TRIM 的部分字段及镜面图名称。WTAF、WZTD、WGIM 的完整 MC 字段，以及各项在目标机台实际保存的值，仍需对应软件版本的测试报表。

<a name="source-figures"></a>

## 原图索引

页码从原文件第 1 页起算。原图及页映射保存在本机 `参考文献/Markdown_v1/`，定位方法见 [Level 1–3 资料引用](../../AGENTS.md#read-only-references)。下表最后一列相对该目录。

| 原始资料及原图 | 图中可核实的信息 | 本机图像定位 |
| --- | --- | --- |
| Level 1《13_AP-L1-ME_rel_3.2.pdf》第 29 页，Sequence 9/14 流程图 | 双卡盘 WS XY IFM 校准在 AA 粗定焦与精定焦之间，印证旧版分步处理 Abbe 参数与焦面。 | `assets/4542989d5f133071/slides/images/page_28_image_7_v1.jpg` |
| 同文件第 64 页，WS Relative Z-IFM Mirror Map — Method (2) 示意 | 上下两行分别画 CS-M/CS-E 和 Z-IFM，同一片参考晶圆在两侧呈现不同的 Z 镜面误差。 | `assets/4542989d5f133071/slides/images/page_63_image_2_v1.jpg` |
| Level 2《TT-L2-ME-3v0.pdf》第 59 页（印刷第 53 页），图 3.1；Level 3《12-TT-L3-L3-ME_book.pdf》第 32 页（印刷第 24 页），图 2.12 | ±X 扫描时，五个短线的斜率随 X 改变，显示固定框架的 Z 镜不平行可使 Ryz 随 X 漂移。 | `assets/e9dff352e800b276/images/page_58_image_11_v1.jpg`、`assets/37317c0531c59e0e/images/page_31_image_5_v1.jpg` |
| 《12-TT-L3-L3-ME_book.pdf》第 27 页（印刷第 19 页），图 2.5 | WZIM 校准前，台体沿 XY 的不同位置偏离虚线 LS 平面。校准后各位置回到共同高度基准。 | `assets/37317c0531c59e0e/images/page_26_image_7_v1.jpg` |
| 同文件第 60 页（印刷第 52 页），图 2.44 | LS 测量方向与台体 Rx/Ry/Rz 同图，说明 WZTD 以恒定测高基准约束三种倾转。 | `assets/37317c0531c59e0e/images/page_59_image_14_v1.jpg` |
| 同文件第 91–92 页（印刷第 83–84 页），图 2.85–2.86、表 2.2 | 示例页区分拟合值与保存状态。表 2.2 逐项列出 WGTD 的坐标方向和物理定义。 | 原 PDF 第 91–92 页。表 2.2 为 `assets/37317c0531c59e0e/images/page_91_table_20_v1.jpg` |
| 同文件第 93、97 页（印刷第 85、89 页），图 2.87、2.95 | M/E 读不同的 Y 镜面。非正交是网格角度变化，尺度是网格间距变化，两者对应不同观测。 | `assets/37317c0531c59e0e/images/page_92_image_7_v1.jpg`、`assets/37317c0531c59e0e/images/page_96_image_11_v1.jpg` |
| 同文件第 102 页（印刷第 94 页），图 2.105 | WTAM 的行列绕行路径使成对取样的时间相对 T/2 对称，抑制慢漂移进入卡盘差。 | `assets/37317c0531c59e0e/images/page_101_image_4_v1.jpg` |

[返回直接校准](#core-calibrations) · [TWINSCAN 测校总表](TWINSCAN测校项目清单_v2.md#晶圆台-ws) · [仓库首页](../../README.md)
