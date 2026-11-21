# WS-IFM 机器常数校准项目 v1

[核心项目](#core-calibrations) · [WGTD 的 23 个报表字段](#wgtd-fields) · [归零、镜面图和精调](#related-calibrations) · [实机参数核对入口](#parameter-evidence) · [成果索引](../README.md)

本清单以 TWINSCAN IFM 配置、AT3.4 无 CS 的 Level 3 流程为主，并用 Level 1 旧流程和 Level 2 的 TRIM 验证交叉核对。M 为测量侧，E 为曝光侧。项目按 Chuck 1/2 与工位记录，`szya` 是资料明确指出的同一卡盘跨侧共用项。模型公式及机台字段分别见 [ifm_model 参数与标定](ifm_model.md#ifm-constants) 和 [ifm_corr 的读数和接口](ifm_corr.md#corr-input)。

<a name="core-calibrations"></a>

## 核心校准项目

| 项目 | 工位与目的 | 更新的模型参数及关联常数 | 校准流程 | 原始资料 |
| --- | --- | --- | --- | --- |
| <a name="mc-wzim"></a>[WZIM — 初始高度和倾斜](TWINSCAN%E6%B5%8B%E6%A0%A1%E9%A1%B9%E7%9B%AE%E6%B8%85%E5%8D%95_v2.md#wzim) | M，两卡盘。用 LS 建立高度基准，消除沿 X/Y 行走的一阶 Z 串扰。 | Z 模型的 `szxa`、`szya`，推导式也写作 `szx0`、`szy0`。同时更新 M 侧的 `Z0`、`Ry0` 归零量。同一卡盘的 `szya` 在 E 侧沿用。 | 各卡盘用裸片，在 XY 网格逐点使 LS M4 读数回到零，再记录 Z-IFM。用 LS M0/M4/M8 的高度与倾角参考定零点。用同一卡盘将晶圆转 180° 后重测，分离晶圆楔角，拟合 XTZ、YTZ 的线性分量。 | 《12-TT-L3-L3-ME_book.pdf》文件第 27–29 页（印刷第 19–21 页），图 2.5–2.7。《TT-MA-ME_setupblock_1-5_1v3.ppt》第 10–18 张。 |
| <a name="mc-wgim"></a>[WGIM — WS TRIM](TWINSCAN%E6%B5%8B%E6%A0%A1%E9%A1%B9%E7%9B%AE%E6%B8%85%E5%8D%95_v2.md#wgim) | M/E，两卡盘。校正 Rz 对 Rx/Ry 及 XY 的依赖，并用 Ryx 约束 Ryz 的一阶位置依赖。 | 明确关联 `srxa`（X 对 Ryz 的贡献）。课件还明确将 `sfz` 的确定归于 TRIM。其余为 Rz 倾角/位置串扰和冗余 Ry 的补偿系数，完整写入键名未列。 | 改变 Rx、Ry，对比两路 Rz；沿 X/Y 移动拟合两路 Rz 的位置依赖；沿 X 比较 Ryz 和 Ryx。Level 2 的验证例用覆盖晶圆的 5×5 网格，每点 17 种 Rz/Rx/Ry/Z 组合，记录 X/Y/Z、Rx、Ryx/Ryz、Rzx/Rzy 八个解算通道。 | 《12-TT-L3-L3-ME_book.pdf》文件第 30–33、57 页（印刷第 22–25、49 页），图 2.9–2.13。《TT-L2-ME-3v0.pdf》文件第 58–60 页（印刷第 52–54 页）。`sfz` 见《TT-MA-ME_setupblock_6-8_1v3.ppt》第 35 张备注。 |
| <a name="mc-wtaf"></a>[WTAF — XY 倾斜依赖](TWINSCAN%E6%B5%8B%E6%A0%A1%E9%A1%B9%E7%9B%AE%E6%B8%85%E5%8D%95_v2.md#wtaf) | M，两卡盘。让 AA 测得的 XY 对台体 Rx/Ry/Rz 不敏感，以 AA 有效位置为参考。 | 每卡盘拟合 10 个 XY-IFM 参数，含 XY Abbe 臂，对应模型中的 `ax`、`ay`。资料明确说明会覆盖之前求得的 Ry Abbe 臂。其余报表键名待核。 | 已知 AA 粗焦后，借 AA 读取 TIS1-I0 与 TIS2-I0。在两标记位置分别施加正负 Rx/Ry/Rz，拟合表观 XY 位移相对倾角的变化。精设定阶段复做，覆盖 WS 工作范围。 | 《12-TT-L3-L3-ME_book.pdf》文件第 44、89 页（印刷第 36、81 页）。《TT-MA-ME_setupblock_1-5_1v3.ppt》第 44–45 张。《TT-MA-ME_setupblock_6-8_1v3.ppt》第 31–32 张。 |
| <a name="mc-wztd"></a>[WZTD — Z 倾斜依赖](TWINSCAN%E6%B5%8B%E6%A0%A1%E9%A1%B9%E7%9B%AE%E6%B8%85%E5%8D%95_v2.md#wztd) | M，两卡盘。使 Z-IFM 有效倾转点对应 LS M4，恒高倾转时两者读数一致。 | 更新 Z-IFM 倾转点及相关 Z 姿态补偿参数。当前资料确认参数族，未列独立 MC 键名和项数。 | 按 LS–AA 校准确定 M4 位置。将裸片带到多个 XY 点，由 LS 保持高度，在不同 Rx/Ry/Rz 组合下读 Z-IFM；用表观厚度差拟合补偿。 | 《12-TT-L3-L3-ME_book.pdf》文件第 60 页（印刷第 52 页），图 2.44。《TT-MA-ME_setupblock_1-5_1v3.ppt》第 81–82 张。《07-TT-L3-LS-2v0.pdf》文件第 33 页（印刷第 27 页）。 |
| <a name="mc-bmwz"></a>[BMWZ — 初始高度和倾斜](TWINSCAN%E6%B5%8B%E6%A0%A1%E9%A1%B9%E7%9B%AE%E6%B8%85%E5%8D%95_v2.md#晶圆台-ws) | E，两卡盘。以 TIS 测出的掩模标记像面建立初始面高和 X 扫描倾斜。 | 更新 E 侧 Z 模型的 `szxa` 和零偏 `Z0`。依流程将 `Lz`、`Lry` 置零。报表另列 WS IFM 尺度 `Mx`、`My`（ppm），与直接的尺度系数键名仍需对照。E 侧 `szya` 沿用 WZIM。 | 先用设置掩模 hook 标记及 RS TIS 基准做粗扫描，再让两只 WS TIS 测正常标记，确定像面、两基准间距与高度变化。TIS 观测约束 `Z0+Lz` 和 `szxa+Lry`，模型按所述约定分配。 | 《12-TT-L3-L3-ME_book.pdf》文件第 63–66 页（印刷第 55–58 页），图 2.48、2.50。《TT-MA-ME_setupblock_1-5_1v3.ppt》第 89–94 张。 |
| <a name="mc-wgtd"></a>[WGTD — XYZ 倾斜依赖](TWINSCAN%E6%B5%8B%E6%A0%A1%E9%A1%B9%E7%9B%AE%E6%B8%85%E5%8D%95_v2.md#wgtd) | E，两卡盘。以投影镜头下的 TIS 像来校正 XYZ 对 Rx/Ry/Rz 的依赖。 | rel.3.4.0 示例组 `wse_chuck1_if_model_parameters` 报告 23 个参数，覆盖 XY 光束与 Abbe 几何、入射角误差、Z 姿态耦合。见 [23 项与各组单位](#wgtd-fields)。 | BMTIS 完成后，WS 的 TIS1/TIS2 各测 RS TIS 基准 T1 和 T2，形成 2×2 组合。对每组合采集多种姿态下的 XYZ，用联合拟合分离 IFM 响应与标记、镜头、TIS 位置和镜面图误差。 | 《12-TT-L3-L3-ME_book.pdf》文件第 89–92 页（印刷第 81–84 页），图 2.83–2.86、表 2.2。《TT-MA-ME_setupblock_6-8_1v3.ppt》第 33–38 张。 |
| <a name="mc-grmo"></a>[GRMO — XY 非正交与 Y/X 比例](TWINSCAN%E6%B5%8B%E6%A0%A1%E9%A1%B9%E7%9B%AE%E6%B8%85%E5%8D%95_v2.md#晶圆台-ws) | M/E，两卡盘。定 XY 轴非正交及相对网格尺度，补绝对镜面图遗漏的线性分量。 | 更新非正交及 Y/X 相对尺度。物理上关联 v1 的 `sxy` 和 XY 相对尺度。课程明确说明尺度通过调整 TIS1/TIS2 基准位置实现，未指明直接写 `sfx` 或 `sfy`。 | 两卡盘分别在同一片上曝光四向 XPA 十字标记，各卡盘在 M 侧以 0°、90° 重新装片读两层。用转向分离 M/E 两侧的非正交和 Y/X 比例贡献，拟合后调整坐标及基准。 | 《12-TT-L3-L3-ME_book.pdf》文件第 96–98 页（印刷第 88–90 页），图 2.95–2.99。《TT-MA-ME_setupblock_6-8_1v3.ppt》第 50–58 张。 |

<a name="wgtd-fields"></a>

## WGTD 报表的 23 个候选参数

报表字段来自 E 侧 Chuck 1 示例。表 2.2 给出物理定义，图 2.86 给出 `Current / New / Delta` 及单位。图 2.85 中该次示例的状态为 **`Machine Constants: Not Saved`**，因此字段能作为拟合输出核对，写入状态需看对应实机报表。出处为《12-TT-L3-L3-ME_book.pdf》文件第 91–92 页（印刷第 83–84 页）。

| 参数组 | 报表字段 | 报表单位 | 参数含义 |
| --- | --- | --- | --- |
| XY 光束几何（8） | `K`、`L`、`ax`、`ay`、`cx`、`cy`、`dd`、`ee` | mm | TIS 至 X/Y IFM 距离、上束至 TIS 焦面高度、上两束横向间距的 1/4，以及 Y-IFM 的 X 向偏移和 X-IFM 的 Y 向偏移。 |
| XY 入射角（4） | `Ryix0`、`Rzix0`、`Rxiy0`、`Rziy0` | µrad | X 光束在 Ry/Rz 方向、Y 光束在 Rx/Rz 方向的误差角。 |
| Z 的一次姿态项（3） | `ezxa`、`ezya`、`ezza` | µm | 分别乘 Rx、Ry、Rz 的 Z 系数。 |
| Z 的位置与姿态耦合（4） | `czxxa`、`czxya`、`czxza`、`czyya` | mrad | 分别对应 X·Rx、X·Ry、X·Rz、Y·Ry。 |
| Z 的二次姿态项（4） | `dzxxa`、`dzyya`、`dzzza`、`dzxza` | mm | 分别对应 Rx²、Ry²、Rz²、Rx·Rz。 |

<a name="related-calibrations"></a>

## 归零、镜面图和精调

| 相关项目 | 校准量与测量方法 | 和模型常数的关系 |
| --- | --- | --- |
| [SWZS / WS Initialization Tilts](TWINSCAN%E6%B5%8B%E6%A0%A1%E9%A1%B9%E7%9B%AE%E6%B8%85%E5%8D%95_v2.md#swzs) | 两卡盘、M/E 各找接收信号最佳姿态，确定 `Rx0/Ry0/Rz0`，PSD 校准建立零传感器增益矩阵和归零位置。 | 用于读数定零和初始化。WZIM 后还会更新 M 侧 `Ry0`。出处为《12-TT-L3-L3-ME_book.pdf》文件第 26–27 页（印刷第 18–19 页）、《TT-MA-WS-Calibrations-3v1.ppt》第 97–108 张。 |
| [GIWS / WTAM](TWINSCAN%E6%B5%8B%E6%A0%A1%E9%A1%B9%E7%9B%AE%E6%B8%85%E5%8D%95_v2.md#晶圆台-ws) | GIWS 在受控 X/Y 扫描中利用束间差分和冗余 Rz 读数建立 `XRZ/YRZ/XTY/YTX` 镜面图。课件同段另列以冗余 Ry 求 `XRY/YRY`。WTAM 用双卡盘曝光与读回套刻更新 `XTY/YTX`。 | 这些是随 XY 位置变化的镜面修正表。与主解算参数配套使用。出处为《TT-MA-ME_setupblock_6-8_1v3.ppt》第 39、43–48、64–73 张、《12-TT-L3-L3-ME_book.pdf》文件第 93–95、100–102 页（印刷第 85–87、92–94 页）。 |
| [FPCM — Combined FOCAL](TWINSCAN%E6%B5%8B%E6%A0%A1%E9%A1%B9%E7%9B%AE%E6%B8%85%E5%8D%95_v2.md#系统集成成像平面和套刻) | 对不同焦点曝光，显影后用 AA 读取位移并拟合最佳焦点，校正 M/E 间残留的 X 向 Z 镜曲率。 | 报表明确列出 KU 常数 `Blue Focus Offset Z mirror X-curvature`。该项作用于焦面补偿。出处为《TT-MA-ME_setupblock_6-8_1v3.ppt》第 77–95 张，尤见第 92 张。 |
| [XYDO — Final XY](TWINSCAN%E6%B5%8B%E6%A0%A1%E9%A1%B9%E7%9B%AE%E6%B8%85%E5%8D%95_v2.md#系统集成成像平面和套刻) | 用双卡盘参考层与错位套刻层拟合场间/场内误差，TIS1/TIS2 的 M/E 尺度差参与场间倍率校正。 | 课件明确提到更新 WS scaling，生产中在掩模对准后通过倍率校正。确切底层字段与启用策略待对机台报告。出处为《TT-MA-ME_setupblock_6-8_1v3.ppt》第 96–110 张、《12-TT-L3-L3-ME_book.pdf》文件第 114 页起（印刷第 106 页起）。 |
| [BMAA、BMTIS、LS–AA](TWINSCAN%E6%B5%8B%E6%A0%A1%E9%A1%B9%E7%9B%AE%E6%B8%85%E5%8D%95_v2.md#晶圆台-ws) | 分别建立 AA 标记坐标、曝光侧 TIS 基准、LS M4 相对 AA 的位置。 | 为 WTAF、WGTD、WZTD 提供外部位置或高度基准。出处为《12-TT-L3-L3-ME_book.pdf》文件第 44、58–60、89–90 页（印刷第 36、50–52、81–82 页）。 |

旧配置可找到两类直接校准的前身。rel.3.2 用 ACM 上的 ATM 标记完成 Abbe 臂粗校和 XY 参数精校，与 AA 焦点分次进行。带 CS 的 Z 倾斜依赖在两个工位以 CS 中心光斑恒高，扫描位置和倾角，将 CS 与 Z-IFM 高度差拟合为补偿 MC。AT3.4 资料描述的 WGTD 合并了旧 E 侧 Overlay vs. Rotation and Tilt 与 Z 倾斜依赖功能。出处为《13_AP-L1-ME_rel_3.2.pdf》文件第 29 页、《07-TT-L3-LS-2v0.pdf》文件第 32–33 页（印刷第 26–27 页）图 4.1、《12-TT-L3-L3-ME_book.pdf》文件第 89–90 页（印刷第 81–82 页）。

<a name="parameter-evidence"></a>

## 实机参数核对入口

- **识别 Z 平移与 Ry 冗余的参数来源。** `szxa X`、`szya Y` 是 Z 的行走倾斜项，`srxa X` 是 Ryz 的位置项，`sfz` 是 Z 的尺度。TRIM 复查段原文写 “srxa (X contribution to Ryz)”。课件备注写 “Parameter sfz has been determined by the TRIM test.”出处为《12-TT-L3-L3-ME_book.pdf》文件第 27、57 页（印刷第 19、49 页）和《TT-MA-ME_setupblock_6-8_1v3.ppt》第 35 张。公式见 [ifm_raw 的 Z 原式](ifm_raw.md#z-ifm-原式) 和 [ifm_corr 的 Z/Ryz 公式](ifm_corr.md#corr-z)。
- **分清已报告字段和待核字段。** WGTD 提供明确的 E 侧字段组及单位。WTAF 的 10 项参数中除 Abbe 臂之外的字段、WZTD 的逐项常数和 WGIM 全部键名，需要目标版本的报告。现有资料还未给出 `kze`、`sfryz`、`ux`、`wy`、第三束方向误差字段的独立写入记录。v2 中 `hx`、`hy`、`δy_X`、`δx_Y` 来自当前 CAD，应追溯机型的装调量或实测定义。见 [几何常数和参考点](ifm_model.md#ifm-constants)。
- **对照相同卡盘、工位、坐标基准和单位。** `K/L` 报表释义采用 TIS 参考，M 侧 AA 与 E 侧 TIS 参考需分别核对，与当前 CAD 晶圆中心 O 的距离需做端点换算。后续比对需同时核查字段如何进入公式及保存状态。见 [WGTD 参数表](#wgtd-fields) 与 [ifm_corr 的读数和接口](ifm_corr.md#corr-input)。

### 原页图表索引

下列原图可在本机 Level 3 原件或 [仓库资料规则](../../AGENTS.md#read-only-references) 所述的 MinerU 本机索引中按页查看。

| 原始图表 | 从图中确认的观测关系 |
| --- | --- |
| 《12-TT-L3-L3-ME_book.pdf》文件第 27 页（印刷第 19 页），图 2.5 | 虚线标出 LS 平面。校准前两个 XY 位置的高度关系不同，校准后对齐到同一参考平面，对应 WZIM 的行走倾斜补偿。 |
| 同文件第 32 页（印刷第 24 页），图 2.12 | WS 向 ±X 运动时，图下五个短线段的斜率依次变化，说明计量框架镜不平行可让 Z 通道报告随 X 变化的 Ry。图中短线斜率是一阶角度变化，整体高度形态还包含非线性残余。 |
| 同文件第 60 页（印刷第 52 页），图 2.44 | LS 向下的测高位置和 Rx/Ry/Rz 三个转向同时标出，说明 WZTD 的约束是在不同姿态下维持同一高度参考。 |
| 同文件第 64、66 页（印刷第 56、58 页），图 2.48、2.50 | 光路图显示投影像由 WS 上的 TIS 读取。训练报表把 `Mx/My`、`d_Z0`、`d_szxa` 列为不同的量。 |
| 同文件第 90–92 页（印刷第 82–84 页），图 2.83–2.86 及表 2.2 | RS 的 T1/T2 经镜头成像，WS 上两只 TIS 分别采样。图 2.85 给保存状态，图 2.86 给拟合值与单位，表 2.2 给字段物理定义。 |
| 同文件第 97 页（印刷第 89 页），图 2.95–2.97 | M/E 使用不同 Y 镜面，四向标记与两种装片朝向提供分离两侧非正交和相对尺度所需的观测。 |
| 《TT-MA-ME_setupblock_1-5_1v3.ppt》第 45 张 | TIS 布局、正交条纹标记和倾转示意对应 WTAF 的标记参考与倾角激励。 |

[返回核心项目](#core-calibrations) · [仓库首页](../../README.md)
