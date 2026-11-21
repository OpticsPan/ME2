# WS-IFM 八轴解算公开资料调研 v1

[检索结论](#findings) · [八轴原图](#eight-axis-layout) · [公式对照](#published-equations) · [C0 核对](#c0-comparison) · [检索边界与原页](#source-pages) · [成果索引](../README.md)

<a name="findings"></a>

## 检索结论

**与 ME2 同类的 `3X + 3Y + 2Z` 架构已有公开先例。** ASML 的 `US6020964A` 图 18 和正文明确在曝光、对准两工位各设三路 X、三路 Y 和两路 Z 观测。该专利写出双 Z 读数求和得到平均高度、作差观测 Ry 的关系。ASML 的 `US6084673A` 另给出 3X、3Y 的读数组合公式。两个文献合看，可对照 C0 缺少的 `Ryx/Rx` 名义测角几何及 `Ryz` 的主观测来源。本次找到的原文覆盖了布局、若干显式式子和标定思路。同一份资料中逐项对应 C0 的八路高阶逆解、机器常数及实际控制器求解顺序仍未找到。 [ASML 八路布局原页](https://patentimages.storage.googleapis.com/0d/af/b8/b6403797303521/US6020964.pdf#page=31) · [ASML X/Y 解算原页](https://patentimages.storage.googleapis.com/8e/53/50/5ca8d0ec153924/US6084673.pdf#page=26)

| 原始来源 | 轴数和配置 | 公开到哪一步 | 与当前问题的关系 |
| --- | --- | --- | --- |
| ASML，Loopstra、Straaijer，`US6020964A`，2000 | 图 18 的 M、E 各为 3X + 3Y + 2Z。图 6 单独画出双 Z 光路。 | 式 (9)–(10) 给出一个 Z 通道与 X 位置、X 束测得 Ry 的关系。双 Z 用求和、作差获取高度及 Ry。 | 直接核对八路架构、直返参考与折返测量，以及 `mz1/mz2` 的来源。 [图 18](https://patentimages.storage.googleapis.com/0d/af/b8/b6403797303521/US6020964.pdf#page=14) · [双 Z 段落](https://patentimages.storage.googleapis.com/0d/af/b8/b6403797303521/US6020964.pdf#page=24) |
| ASML，Van den Brink、Straaijer，`US6084673A`，2000 | 图 17 为 3X + 3Y，观测五个不同自由度并给出两路 Rz。 | 给出 X/Y 轴束点和基线、读数组合、用冗余偏航测镜面误差的流程。Y 组印刷式有待核对的下标和系数。 | 可验证 `Ryx` 一阶式、`Rx` 的上下束差原理和 `Rzx/Rzy` 冗余。 [图 17](https://patentimages.storage.googleapis.com/8e/53/50/5ca8d0ec153924/US6084673.pdf#page=10) · [解算式](https://patentimages.storage.googleapis.com/8e/53/50/5ca8d0ec153924/US6084673.pdf#page=26) |
| Nikon，Shibazaki、Kanaya，`US8218129B2`，2012 | X/Y IFM 加两套 Z IFM。Z1、Z2 所用折返拓扑与 ME2 不同。 | 式 (1)–(4) 从光程解每侧的 Y、Z，式 (5)–(6) 从两侧位移差及基线显式解偏航和俯仰。正文合并各组信息得到六自由度。 | 是两处 Z 观测反解 Ry 的独立公开推导。其光程倍率、角度和差序按自身图理解。 [式 (1)–(6)](https://patentimages.storage.googleapis.com/e5/2e/74/2f276b1cc8029e/US8218129.pdf#page=38) |
| 滕伟、周云飞、穆海华、杨亮亮，《中国机械工程》，2009 | 运动台 X/Y 五自由度激光测量。 | 期刊摘要明确说明先计算理想及带加工/安装误差的光程，再推导带 Abbe、余弦误差补偿的五自由度解算。 | 对应 C0 横向模型中的误差族。此次能核对期刊摘要，未用正文验证逐项式子。 [期刊原始题录](https://www.cmemo.org.cn/CN/abstract/abstract1446.shtml) |
| Gao、Hu、Zhu、Duan，《Precision Engineering》，2013 | 九台 IFM 测 X–Y 工作台六自由度，使用附加测量。 | 期刊摘要和预览给出小角差分测转角、由附加测量得到平移闭式的方法，作者说明其算法无迭代和超越函数计算。 | 可比较实时解算的思路。公开结果中的角度、平移精度为仿真计算精度。 [期刊论文及 DOI](https://doi.org/10.1016/j.precisioneng.2013.01.006) |
| 上海微电子，林彬，`CN101510058B`，2011 | 工件台水平误差测量和校准。 | 说明书式 (1)–(3) 将 X/Y 表示为光程及姿态的函数，利用不同姿态下的曝光标记拟合机器常数。 | 可对照 C0 参数为何需要外部标定。具体 X/Y 高阶函数和完整八轴逆解在该文献中未展开。 [专利原文](https://patents.google.com/patent/CN101510058B/zh) |

<a name="eight-axis-layout"></a>

## 八轴原图

| ASML 3X + 3Y + 2Z 总体配置 | ASML 双 Z 的 XZ 切面 |
| --- | --- |
| `US6020964.pdf` 文件第 14 页图 18，正文在文件第 31 页印刷第 29 栏。可在图中直接逐条辨认 `X1E–X3E、Y1E–Y3E、Z1E/Z2E` 和对应的 M 侧标签。两侧 Z 照向台体相对边，三路 X/Y 分别接相应侧镜。 [图 18 原页](https://patentimages.storage.googleapis.com/0d/af/b8/b6403797303521/US6020964.pdf#page=14) | 同文件第 5 页图 6，正文在文件第 24 页印刷第 16 栏。图中两侧为斜面 `R3/R4` 与上方固定反射面 `164/168`，另有侧镜直返参考束。正文将两 Z 测量轴记为 `MAX,7/MAX,8`，轴号也可与图 18 互查。 [图 6 原页](https://patentimages.storage.googleapis.com/0d/af/b8/b6403797303521/US6020964.pdf#page=5) |

本机 Level 3《09-TT-L3-WSbook.pdf》文件第 58 页（印刷第 50 页）图 1.60、1.61 也画出 E 与 M 的测量光路。正文说明 X/Y 各三束，两个 Z 干涉仪各含一支折返测量束和一支直返参考束。这里的八轴是八个可用于解算的测量轴；按实体光路逐条追迹时，Z 的两支参考束还需各自计算。两份原图能交叉确认束组与测量功能。第三束高度、X/Y 侧选择、光程倍率和姿态转序按各自图纸和读数协议使用。 [ifm_corr 修正模型](ifm_corr.md)

<a name="published-equations"></a>

## 公开公式与当前模型的对应

### X/Y 束差和名义测角

ASML `US6084673.pdf` 文件第 10 页图 17 分别画出垂直高度基线 `d3/d5` 和横向间距 `d4/d6`。文件第 26 页第 27 栏中，X 组的两条角度公式可用 `I1、I2、I3` 简写。这里的差序沿用该专利。

```text
X 侧偏航 = (I1 - I2) / d4
X 侧 Ry  = ((I1 + I2)/2 - I3) / d3
```

这是 C0 缺少的 `Ryx` 的可核对一阶原理。ME2 的 X3 有横向偏移，实际公式还要先消除相应的 Rz 串扰。该专利用三束均值给出 X，而 C0 的 `mx1` 是上两束均值。换用光程组合会改变平移参考点和 Abbe 几何。 [专利原式](https://patentimages.storage.googleapis.com/8e/53/50/5ca8d0ec153924/US6084673.pdf#page=26) · [ifm_corr 修正模型](ifm_corr.md)

**原页中的 Y 组需要独立核对。** 第 27 栏正文说量测 Y、绕 X 倾斜和绕 Z 偏航，但印刷式把 Y 均值第三项写成 `I3`，把倾斜标成 `φ_y`，其分子写成 `I4 + I5 - I6`。用纯 Y 平移回代，三路 Y 读数同时增加 `t`，这一分子仍增加 `t`。因此该式按字面会把公共 Y 平移混入角度输出。按图 17 做几何差分，Y 的名义倾角应使用第三束与前两束平均值之间的差，再除以高度基线。最终正负号取决于束号与坐标方向。此处的几何判断来自共模平移检验，原件照原样保留。 [图 17](https://patentimages.storage.googleapis.com/8e/53/50/5ca8d0ec153924/US6084673.pdf#page=10) · [原件印刷公式](https://patentimages.storage.googleapis.com/8e/53/50/5ca8d0ec153924/US6084673.pdf#page=26)

### 双 Z 和 Ryz

- **ASML 双 Z。** `US6020964.pdf` 文件第 24 页第 16 栏说明，双 Z 信号相加取得平均高度，信号差与绕 Y 的倾角成比例。图 5 的单 Z 公式 (9)–(10) 还给出另一条可验证的依赖关系。先由两个 X 读数的差除以基线取得 Ry，再用该角补偿单路 Z。公式中的 X 向串扰是否先经光学差分移除，取决于参考光是打在台体侧镜还是固定参考镜。 [双 Z、式 (9)–(10) 与直返参考原页](https://patentimages.storage.googleapis.com/0d/af/b8/b6403797303521/US6020964.pdf#page=24)
- **Nikon 的显式俯仰式。** `US8218129.pdf` 文件第 38–39 页第 20–21 栏，先从折返光程中分离左、右测点的高度。式 (6) 再用 `Δθy = atan((ΔZoL - ΔZoR)/D)`，其中 `D` 是两测点沿 X 的距离。这支持“高度差除以基线”作为小角近似。从 C0 的原始 `mz2` 到这一步，还要先对齐光程与等效高度的比例、正负号和 Z 镜几何。 [Nikon 式 (1)–(6)](https://patentimages.storage.googleapis.com/e5/2e/74/2f276b1cc8029e/US8218129.pdf#page=38)

<a name="c0-comparison"></a>

## 能确认 C0 的什么

| C0 问题 | 公开资料能确认的部分 | 仍需目标机定义的部分 |
| --- | --- | --- |
| `Ryx/Rx` 可否从 IFM 光程独立算出 | X/Y 各用不同高度处的光程差进行测角。上两束的横向差另外提供偏航。 | ME2 第三束偏心、束高失配、真实束向、镜面倾斜和高阶坐标转序。 |
| `Ryz` 为何另有一套俯仰角 | 双 Z 本身提供另一条俯仰观测。Level 2/3 的 TRIM 用 `Ryz−Ryx` 辨认安装及位置相关误差。 | `mz2` 差序、光程/高度倍率、随 Z 变化的等效臂及 `sfryz` 量纲。公开的双 Z 推导没有证实 C0 的平方归一化可直接用物理长度代入。 |
| 右端为何可以出现 `Ry` | 另一束组得到的姿态可以用于补偿。ASML 单 Z 式 (9)–(10) 已公开一个类似的逐步计算实例。 | C0 的原控制器如何给 Ryz 右端的 `Ry` 赋值，以及它和 Z 的耦合计算顺序。 |
| 高阶补偿与实时性 | ASML 的 X/Y 专利讨论用两路偏航辨认镜面形状及通道相对延迟。Gao 等通过改变测量布局，把其六自由度反解化成不需迭代的形式。 | C0 全部高阶项、装调常数的原始定义以及实时周期。不同布局上的闭式可提供方法参考。 |

本机 Level 2《TT-L2-ME-3v0.pdf》文件第 58 页（印刷第 52 页）给出两组冗余的 TRIM 测量。《12-TT-L3-L3-ME_book.pdf》文件第 32 页（印刷第 24 页）图 2.12 示意固定 Z 镜不平行造成 Ryz 随 X 变化，文件第 57 页（印刷第 49 页）明确点名 `srxa`。这些资料把公开的差分测角几何与本机 C0 的校准目的连起来。 [机器常数校准项目](WS-IFM%E6%9C%BA%E5%99%A8%E5%B8%B8%E6%95%B0%E6%A0%A1%E5%87%86%E9%A1%B9%E7%9B%AE_v1.md#mc-wgim) · [IFM 模型整理记录](../../changes/2026-11-21-ifm-model-consolidation_v1.md#retired-ifm)

<a name="source-pages"></a>

## 检索边界与原页

检索日为 2026-11-21。沿中英文关键词、ASML/Nikon 相关专利同族和期刊文献追查，包括 `eight-axis interferometer`、`3 X / 3 Y / 2 Z`、`wafer stage six-degree-of-freedom`、`工件台 八轴 激光干涉仪 解算` 及 C0 的特定常数名。若标题包含 “eight beams” 或 “8 signals”，另检查是否同一台体、是否同一工作分支，以及参考光是否被计作独立信号。

- `WO1999032940A1` 图 9 的正文同样明确写出 3X + 3Y + 2Z，并沿用双 Z 和差关系，可以作为 ASML 同期公开的交叉入口。 [WIPO 公开文本](https://patents.google.com/patent/WO1999032940A1/en)
- `EP1446698A1` 的八束是**单个参考平面内**对硅片台、掩模台及投影镜头等多个部件的测量。`US9383659B2` 的八信号示例是四个双轴读数头的光栅配置。两者都有公开的反算或冗余方法，对应的光路及测量对象不同。 [单平面八束实例](https://patents.google.com/patent/EP1446698A1/en) · [四头八信号实例](https://patents.google.com/patent/US9383659B2/en)
- `CN120521499A` 的实施例提到八组 IFM 与卡尔曼滤波。公开文字可核对采集和估计框架，仍缺逐束几何和可代入的 3X + 3Y + 2Z 高阶反解。 [八组 IFM 的公开文本](https://patents.google.com/patent/CN120521499A/zh)

三份主要美国专利的相关正文和公式用本地 MinerU 转换，公式和原图均按 PDF 原页核对。原件和转换留在本机 `work/ws-ifm-public-eight-axis-v1/`，报告用公开原页链接定位。
