# WTAF Level 1–3 资料汇整 v1

[项目定位](#wtaf-evidence-scope) · [各级证据](#wtaf-evidence-levels) · [实机步骤](#wtaf-evidence-method) · [参数证据](#wtaf-evidence-constants) · [原图定位](#wtaf-evidence-figures) · [关联项目](WS-IFM机器常数校准项目_v4.md#mc-wtaf) · [成果索引](../README.md)

<a name="wtaf-evidence-scope"></a>

## 项目定位

**WTAF（WS XY interferometer calibration, measure side）**校准晶圆台在测量侧因绕 X、Y、Z 转动而产生的 XY 位置读数偏差。先进对准传感器 AA 提供参考。WS 在两个相距较远的 XY 位置分别将 TIS1、TIS2 板上的 I₀ 标记送到同一只 AA 下。改变姿态并比较 AA 再次找到同一个标记时的 XY 位置。两卡盘各有一套测量侧 IFM 参数。曝光侧相应任务是 WGTD，约束 XYZ，使用曝光侧的参考关系。[校准项目清单](WS-IFM机器常数校准项目_v4.md#mc-wtaf)

<a name="wtaf-evidence-levels"></a>

## 各级证据

| 层级与原始文件 | 已核实的内容 |
| --- | --- |
| L1-《13_AP-L1-ME_rel_3.2.pdf》第 29 页，Sequence 9/14 与讲义备注 | Rel. 3.2 的旧方案先使 ATM 对准标记的光到达 AA 光学模块，再做粗阿贝臂、粗 AA 对焦、精阿贝臂及 XY IFM 参数、精 AA 对焦。随后细化 SBO、BMAA、BMWL。SBO 修正不同衍射级次读到的对准位置差，BMAA coarse 让系统能找到板上的标记。 |
| L2-《12-TT-L2-ME-module.pdf》文件第 18–19 页（印刷第 10–11 页），Measure XY position of TIS1/TIS2 plate | I₀ 是图像传感器板的零号基准标记。AA 找到标记时确定读数参考，IFM 记录从归零起点到找到标记时的 XY 走位。该节说明日常 Stage Align 的读数关系。 |
| L2-《TT-L2-ME-3v0.pdf》文件第 12–13 页（印刷第 6–7 页），图 1.7、1.9、1.10 | 两只板的 I₀ 依次被 AA 扫描。图 1.10 圈出 TIS1 板上的零号标记，右侧放大其 XPA 光栅图样。 |
| L2-《11-TT-L2-AL-module.pdf》文件第 15 页 | 测量侧的反射式标记光栅产生衍射信号。移动晶圆台扫过标记，用信号确定标记位置。 |
| L2-《10-TT-L2-LS-module.pdf》文件第 21 页，L2-《TT-L2-LS-3v0.pdf》文件第 20 页 | 日常 Stage Align 先用 LS 测 TIS 板高度，再把 I₀ 送到 AA 的焦高附近，最后用 AA 找 XY。这说明高度定位和 XY 找标记的分工。 |
| L3-《12-TT-L3-L3-ME_book.pdf》文件第 43–45 页（印刷第 35–37 页），CABF、WTAF、BMAA fine | 非 ACM 路线是 CABF → WTAF → CABF 核查。AA 粗焦与足够准确的 SBO 使 AA 可作 XY 参考。用两个相隔较远的 I₀ 和正负 Rx、Ry、Rz，辨识每卡盘 10 项参数。更新值会覆盖先前的 Ry 阿贝臂。随后 BMAA fine 细调基准板的平移、旋转和倍率（TRM）。 |
| L3-《12-TT-L3-L3-ME_book.pdf》文件第 89 页（印刷第 81 页），图 2.82 | 第 7 设定块更新 BMAA fine 后，第 8 块复做测量侧 XY IFM 校准，并将阿贝臂标定用于整个 WS 范围。图中 M 侧 WTAF、E 侧 WGTD、WS 绝对镜面图和 RS 镜面图汇入后续 WS 非正交性与比例校准。 |
| L3-《TT-MA-ME_setupblock_1-5_1v3.ppt》第 42–46 张 | 第 42–43 张说明非 ACM 的 CABF 路线及长短标记。第 44 张正文列 WTAF 方法、写入后目标和前后关系。第 45 张显示 WS 两个角上的 TIS1/TIS2 以及圈出的 TIS 板 I₀。第 46 张说明 IFM 更新影响 TRM，BMAA fine 复测板标记。 |
| L3-《TT-MA-ME_setupblock_6-8_1v3.ppt》第 31–32 张 | 第 31 张是第 8 设定块总图。第 32 张说明重做原因及「使 WS 旋转中心等于 AA 传感器位置」的等效坐标目标。 |
| L3-《04-TT-L3-ATS-AA-2v0.pdf》文件第 103–109 页（印刷第 97–103 页），图 5.35–5.43 | 图 5.35 区分 IFM 测量高度与 AA 焦高。图 5.36 标出 Ry 阿贝臂的两端。图 5.37 对比等效倾转点偏离标记和经过标记。CABF 用长短标记随倾角和高度的不同响应，先找到 AA 焦高。第 109 页在 CABF 的语境下列出 ifm-ax、ifm-ay（MI），并说明某些版本 CABF 会暂用 Green 7 的阿贝臂，结束后恢复原值。 |

L3-《TT-MA-ME_setupblock_1-5_1v3.ppt》第 44 张备注有一句写施加转角会影响对准位置。该张正文、L3 ME book 文件第 44 页的 Method 和第 89 页的复做说明都明确要求校准后的对准位置不随转角变化，按三处相符的正文整理。

<a name="wtaf-evidence-method"></a>

## 实机步骤与适用边界

1. **准备测量侧参考。** 在非 ACM 路线中先完成用于粗定焦的 CABF，确认 SBO 足够准确。基准板的 I₀ 须能被 AA 捕获。L3 ME book 文件第 43–44 页。
2. **选两处标记。** 在每卡盘上分别测 TIS1-I₀、TIS2-I₀。两处在 X、Y 上相距较远，可分别取得两处的姿态响应。L3 ME book 文件第 44 页及 L3 setupblock 1–5 第 45 张。
3. **转台并重新找标记。** 对 WS 施加正、负 Rx、Ry、Rz。对同一标记在改变姿态后取得 AA 对准位置，比较重新对中时的 XY-IFM 坐标。L2 的 Stage Align 补充了 AA 找标记和 IFM 取位的关系。资料未列出 WTAF 的加角幅值、加角批次顺序、重复数和采样权重。
4. **更新测量侧模型。** 从两个标记的测量确定每卡盘十项 IFM 参数。更新后，同一标记的模型 XY 位置应与施加的正负转角无关。适用目标是卡盘所有 XY 位置，专节明确以两个相距较远的标记取得拟合信息。L3 ME book 文件第 44 页。
5. **接到后续设定。** 初次 WTAF 为 TIS1-I₀ 上的 AA 精调创造条件，IFM 模型更新后 BMAA fine 可重定各板 TRM。第 7 块更新 BMAA fine 后，第 8 块复做测量侧 WTAF。L3 ME book 文件第 43–45、89 页。

AA 焦面、SBO、Z 模型在初次 WTAF 时可能仍会细调。原书将三者列为稍后重复的可能原因，同时认为其初期误差不会严重影响这次测试的有效性。AA 未对准焦高时，标记倾斜本身也会改变 AA 对准结果，故先校 AA 焦高，再用 AA 区分 XY 模型的姿态响应。

<a name="wtaf-evidence-constants"></a>

## 读数、参数及输出边界

- **写入对象。** 测量侧、每卡盘一套 10 项 XY IFM 参数。L3 ME book 文件第 43 页称 XY IFM 阿贝臂为 ax、ay，第 44 页明确覆盖先前的 Ry 阿贝臂。L3 AA 书文件第 109 页出现 ifm-ax、ifm-ay 的底层名称。后者佐证字段写法，完整 WTAF 保存清单仍需对应版本测试报表。
- **实测量。** 不同姿态下 AA 找到同一 I₀ 时的 XY 位置，以及该样本的 WS 转角。TIS1 和 TIS2 是每卡盘上的两处基准板位置。
- **前置量。** AA 焦面、SBO、I₀ 初始定位。AA 光束的倾角、焦高、SBO 和 BMAA 的板 TRM 各有独立的校准项目。
- **判据和模型边界。** 专节要求更新后 XY 对 ±Rx、±Ry、±Rz 保持一致。走位、镜面地图、非正交和尺度另外标定。专节在所述条件下忽略纯 Z 变化带来的 XY 影响及镜面的物理形变。十项的完整字段、正式拟合矩阵和残差阈值待对应版本报表核实。

<a name="wtaf-evidence-figures"></a>

## 原图定位

路径相对于本机参考文献根目录。复用现有 MinerU 转换，并对照原 PDF 页像或从原 PPT 只读导出的幻灯片。

| 原始出处 | 图上能核对的内容 | 本机定位 |
| --- | --- | --- |
| L3-《TT-MA-ME_setupblock_1-5_1v3.ppt》第 45 张 | 上方俯视图两只 TIS 板在卡盘不同角上。中部 TIS2 板详图圈出 I₀。下方配有 Rz、Rx（Ry）标志。 | 原件在 L3 Presentation 目录，第 45 张。中部 MinerU 单图在 Markdown_v1/assets/c9af45c9eb25c12e/images/page_44_image_3_v1.jpg。 |
| L3-《04-TT-L3-ATS-AA-2v0.pdf》文件第 104 页（印刷第 98 页），图 5.36、5.37 | 5.36 标出 Ry 阿贝臂为 IFM 线与目标面之间的垂向高度差。5.37 显示有偏置的倾转点如何使表面测点横移。 | Markdown_v1/assets/220652e52c1294b9/images/page_103_image_8_v1.jpg 与 page_103_image_12_v1.jpg。 |
| L3-《12-TT-L3-L3-ME_book.pdf》文件第 89 页（印刷第 81 页），图 2.82 | 第 8 块的测量侧复做及其后续依赖。 | Markdown_v1/assets/37317c0531c59e0e/images/page_88_image_6_v1.jpg。 |
| L2-《TT-L2-ME-3v0.pdf》文件第 13 页（印刷第 7 页），图 1.10 | TIS1 板 I₀ 的实物位置和放大的 XPA 图样。 | Markdown_v1/assets/e9dff352e800b276/images/page_12_image_11_v1.jpg。 |

[回到项目定位](#wtaf-evidence-scope) · [WS-IFM 参数关联](WS-IFM机器常数校准项目_v4.md#mc-wtaf)
