# WS-IFM 模型

本文是 ME2 中晶圆台干涉仪（Wafer Stage Interferometer，WS-IFM）的优先参考。主来源为本机 `参考文献/ifm模型.docx`，下文的 DOCX 页码按 Word 渲染的 5 页计数。附件给出 X、Y、Z 和三种分通道角度观测的六个方程。Level 1–3 资料用于核对光路、观测关系及标定步骤。原附件 SHA-256 为 `506566cb2f79d46bddb0ed4fda19fb5a7876571760c22f6dfd41257789081fb5`。

## 光路与输入输出

M 表示测量侧（Measure），E 表示曝光侧（Expose）。通道模型把光束长度组合和台体姿态转换为坐标及角度估计。IFM 通过位移测量跟踪台体，位置参考由归零建立。读数据前要确认 chuck、M/E 工位、归零基准以及报表单位。培训资料显示 Rzx/Rzy 和 Ryx/Ryz 有冗余观测，附件给出了其中 Rzx、Rzy 与 Ryz 的方程。

| 通道 | 测量量 | 模型量与用途 |
| --- | --- | --- |
| X | `mx1` 是上方两束 X 光路长度的平均。`mx2` 是同两束的长度差。 | 平移 `X`、绕 Z 轴的通道估计 `Rzx`。Level 2、3 光路资料还给出 X 通道的 `Ryx`，来自上下束的高差几何。 |
| Y | `my1` 是上方两束 Y 光路长度的平均。`my2` 是同两束的长度差。 | 平移 `Y` 和绕 Z 轴的通道估计 `Rzy`。Level 2、3 光路资料给出 Y 通道还用于观测 `Rx`。 |
| Z | `mz1` 是 Z1、Z2 光路长度的平均。`mz2` 是两者的长度差。`kze` 是 Z1 与 Z2 两路测量之间的有效臂。 | 高度 `Z` 与绕 Y 轴的通道估计 `Ryz`。在所述配置的正常生产中，X-IFM 的 `Ryx` 是 Ry 控制观测量。Z-IFM 的 `Ryz` 用于 Z 测量／控制模型。 |

`Rx`、`Ry`、`Rz` 表示绕相应轴的转角。`Rzx`、`Rzy` 的后缀分别指 X、Y IFM 来源。`Ryx`、`Ryz` 的后缀分别指 X、Z IFM 来源。附件没有给出 `Rx`、`Ryx` 的显式模型、差分通道的相减顺序、旋转的定义顺序和控制器如何生成最终 `Rz`。测量表中的位移和角度字段需对应同一套坐标、符号和单位。

**图像核对。**《09-TT-L3-WSbook.pdf》文件第 58 页（印刷第 50 页）图 1.60、1.61 分别画出 E 侧和 M 侧。两图中 Z1、Z2 都在台体 45° 镜处向上折向计量框架 Z 镜，并各有直返参考光路。Y 干涉仪块在两幅布置图中位于台体的不同侧。图能确定复合光路和冗余测量的由来。通道正负方向要用机型定义或已知方向的位移记录核对。`09-TT-L3-WSbook.pdf` 这一组图适用于其注明的 WS type-2 配置。

| 本机原图 | 从 ME2 根目录定位 |
| --- | --- |
| E 侧，图 1.60 | `参考文献/Markdown_v1/assets/b4514b4ae5eb86cb/images/page_57_image_5_v1.jpg` |
| M 侧，图 1.61 | `参考文献/Markdown_v1/assets/b4514b4ae5eb86cb/images/page_57_image_8_v1.jpg` |
| 台体沿 X 移动时 Z 通道的表观倾斜，图 2.12 | `参考文献/Markdown_v1/assets/37317c0531c59e0e/images/page_31_image_5_v1.jpg` |

最后一图的虚线 X 位置与下方不同倾斜线段说明，计量框架镜不平行时，台体沿 X 移动也会带来 `Ryz` 的位置相关项。WGIM 用 `Ryx` 约束其一阶项。后续镜面图和焦面校准处理各自的残差。出处为《12-TT-L3-L3-ME_book.pdf》文件第 30–32 页（印刷第 22–24 页）。通道与工位参考另见《TT-L2-WS-3v0.pdf》文件第 27 页、《TT-L2-ME-3v0.pdf》文件第 58–59 页。

## XY IFM 原式

下式保留附件第 1 页的变量与运算。`^2` 表示平方。`Xb/4*cx`、`Yb/4*cy` 和 `ay*Ry` 保留原写法，校核见下文。

```text
X = sfx * (mx1
    + [(X + Kx - kx/2)/2] * [(Ry - Ryix0)^2 + (Rz - Rzix0)^2]
    + Kx * (Ry^2 + Rz^2)/2
    - ee * (Rz + Rx*Ry)
    - ax*Ry)

Y = sfy * (my1
    + [(Y - Ly + ly/2)/2] * [(Rx - Rxiy0)^2 + (Rz - Rziy0)^2]
    - Ly * (Ry^2 + Rz^2)/2
    + dd * (Rz + Rx*Ry)
    + ay*Ry
    - sxy*X)

Rzx = mx2/(4*cx) - Rx*Ry
      - (Xb/4*cx) * [(Ry - Ryix0)*dRyixh + (Rz - Rzix0)*dRzixh]
      + ux*Ry

Rzy = my2/(4*cy)
      - (Yb/4*cy) * [(Rx - Rxiy0)*dRxiyh + (Rz - Rziy0)*dRziyh]
      + wy*Rx
```

平移模型包含距离相关的束线角度项、参考点几何项、偏摆与 Abbe 臂耦合，以及轴尺度和正交性项。`Rzx`、`Rzy` 的首项分别用上方两束的差除以相应水平束间距 `4*cx`、`4*cy`。原文另外保留了旋转和束线方向误差的修正。

| 字段 | 物理意义或在公式中的作用 |
| --- | --- |
| `Kx`、`Ly` | 对应 X/Y 干涉仪后角锥到参考点的水平距离。附件表注明 E 侧参考为镜头中心，M 侧参考为 ATHENA 位置。 |
| `kx`、`ly` | `kx` 是台体沿 X 的尺寸。`ly` 是 Y 镜面到 WS 坐标原点水平距离的两倍，只有原点居中时才等于台体 Y 尺寸。 |
| `ax`、`ay` | 上层 X/Y 干涉光束到对准焦平面的竖直 Abbe 臂。`ax` 在 X 式中乘 `Ry`，`ay` 的角度项存在原式与表的差异。 |
| `cx`、`cy` | X1/X2 或 Y1/Y2 的水平间距的四分之一。 |
| `ee`、`dd` | X 式用 `-ee*(Rz + Rx*Ry)`，Y 式用 `+dd*(Rz + Rx*Ry)`。附件表与 Level 3 报表定义有差异，见下文。 |
| `ux`、`wy` | X1/X2 或 Y1/Y2 的垂直方向失配角。对应 `Rzx` 中的 `ux*Ry`、`Rzy` 中的 `wy*Rx`。 |
| `Ryix0`、`Rzix0` | X 束线平均方向误差的 Ry、Rz 分量。附件表把后者写成 `Rzxix0`。 |
| `Rxiy0`、`Rziy0` | Y 束线平均方向误差的 Rx、Rz 分量。 |
| `dRyixh`、`dRzixh` | 附件表指 X3 相对上述 X 平均方向的误差差值。表把第二个字段写成 `dRzxixh`。 |
| `dRxiyh`、`dRziyh` | 附件表指 Y3 相对上述 Y 平均方向的误差差值。代入的通道以 `Rzy` 原式为准。 |
| `sfx`、`sfy`、`sxy` | X、Y 光路尺度系数及台体 XY 非正交系数。`sxy` 在 Y 式中耦合 X。 |

出处为《ifm模型.docx》第 1–4 页。`K`、`L` 等曝光侧报表字段的定义见《12-TT-L3-L3-ME_book.pdf》文件第 92 页（印刷第 84 页）表 2.2。具体工程配置中应按所用基准和字段定义核对映射。

### 固定姿态时的 XY 代数解

当 `Rx`、`Ry`、`Rz` 已知并固定时，原式右边的 `X` 与 `Y` 都只以一次自项出现，可以先求 X，再将 X 代入 Y。以下是对原式的代数重排，用于离线计算和交叉检查。

```text
Ax = ((Ry - Ryix0)^2 + (Rz - Rzix0)^2)/2
Bx = mx1 + Ax*(Kx - kx/2) + Kx*(Ry^2 + Rz^2)/2
     - ee*(Rz + Rx*Ry) - ax*Ry
X  = sfx*Bx/(1 - sfx*Ax)

Ay = ((Rx - Rxiy0)^2 + (Rz - Rziy0)^2)/2
By = my1 + Ay*(-Ly + ly/2) - Ly*(Ry^2 + Rz^2)/2
     + dd*(Rz + Rx*Ry) + ay*Ry - sxy*X
Y  = sfy*By/(1 - sfy*Ay)
```

两个分母必须远离零。这个重排假定姿态已知，并沿用附件的 `ay*Ry` 写法。用 4 组合成输入回代检查，X、Y 方程的最大残差小于 1.5×10⁻¹⁴（所选长度单位）。现场控制器的迭代方式、姿态融合和实时求解顺序有待单独查证。

## Z IFM 原式

《ifm模型.docx》第 4–5 页把 Z 光路的多个安装及面形误差合并为参数化模型。`Z` 与 `Ryz` 分成两条方程，附件说明省略更高阶项。下式只把原来的相邻乘法写成 `*`，并统一平方记号。

```text
Z = sfz * (mz1 + X*Rx*Rz
    + szya*Y + szxa*X
    + ezxa*Rx + ezya*Ry + ezza*Rz
    + czxya*X*Ry + czxza*X*Rz + czyya*Y*Ry + czxxa*X*Rx
    + dzyya*Ry^2 + dzzza*Rz^2 + dzxxa*Rx^2 + dzxza*Rx*Rz)

Ryz = sfryz * (mz2 * ((1 - 2*Z/kze)/kze)^2
      + (2/kze)*X*Rx^2 + (4/kze)*X*Ry^2
      + srxa*X + srya*Y + srza*Z
      + erxa*Rx + erza*Rz
      + crxxa*X*Rx + crxya*X*Ry + crxza*X*Rz
      + drxxa*Rx^2 + drxza*Rx*Rz + dryya*Ry)
```

| 子模型 | 项和字段 |
| --- | --- |
| Z 平均值及几何项 | `mz1`、全式系数 `sfz`、原式显式几何项 `X*Rx*Rz`。 |
| Z 随位置和姿态的线性项 | `szxa`、`szya` 对应沿 X、Y 运动的高度斜率。`ezxa`、`ezya`、`ezza` 分别系于 Rx、Ry、Rz。 |
| Z 混合项与二次姿态项 | `czxxa`、`czxya`、`czxza`、`czyya` 乘位置与姿态的乘积。`dzxxa`、`dzyya`、`dzzza` 乘角的平方，`dzxza` 乘 Rx·Rz。 |
| Ryz 主项 | `mz2` 是差分输入，`kze` 是有效臂，`sfryz` 乘全式。`mz2` 的归一化和 `dryya` 的幂次按附件保留。 |
| Ryz 其余项 | `srxa`、`srya`、`srza` 乘 X、Y、Z。`erxa`、`erza` 乘角度。`crxxa`、`crxya`、`crxza`、`drxxa`、`drxza`、`dryya` 的自变量按上方原式读取。 |

## 标定项目与模型项的关系

这里以 Level 3 的 rel.3.4 资料为交叉参照。具体流程、测点和其他测试见[测校项目清单 v2](TWINSCAN测校项目清单_v2.md)中的 WS 章节。

| 测校 | 侧别与参考 | 对模型的作用与出处 |
| --- | --- | --- |
| WZIM，初始高度与倾斜 | M 侧，以 LS M4 为高度基准。裸晶圆转 180° 重测以分离晶圆楔角。 | 建立 Z0、Ry0，并调整 XTZ/YTZ 一阶项，附件中的代表字段为 `szxa`、`szya`。资料在推导中也采用 `szx0`、`szy0`。见《12-TT-L3-L3-ME_book.pdf》文件第 27–29 页、《TT-MA-ME_setupblock_1-5_1v3.ppt》第 10–18 张。 |
| WGIM，WS TRIM | 以 X/Y 的 Rz 冗余读数及 X/Z 的 Ry 冗余读数作比较。 | 消除 Rz 与姿态、平移的主要串扰，并拟合 `Ryz` 对比 `Ryx` 的一阶偏差。培训书后续复查明确举例 `srxa` 是 X 对 Ryz 的贡献。见《12-TT-L3-L3-ME_book.pdf》文件第 30–32、57 页、《TT-L2-ME-3v0.pdf》文件第 58–59 页。 |
| WTAF，XY 倾斜依赖 | M 侧，使用 AA 对已知标记进行不同倾转下的横向位置观测。 | 拟合 M 侧 XY 模型参数，覆盖 Abbe 臂。早期粗标与后续精标可更新同一类参数。见《12-TT-L3-L3-ME_book.pdf》文件第 44 页、《TT-MA-ME_setupblock_1-5_1v3.ppt》第 44–46 张、《13_AP-L1-ME_rel_3.2.pdf》文件第 29 页。 |
| WZTD，Z 倾斜依赖 | M 侧，以 LS 中央光斑观测不同位置和姿态下的高度。 | 让 Z-IFM 的有效倾转点对准 LS，降低恒高倾转时的表观 Z 变化。见《12-TT-L3-L3-ME_book.pdf》文件第 60 页、《TT-MA-ME_setupblock_1-5_1v3.ppt》第 81–82 张。 |
| WGTD，XYZ 倾斜依赖 | E 侧，TIS1/TIS2 normal 各测 RS 基准板的 T1/T2，在多种姿态下拟合。 | E 侧报表组例 `wse_chuck1_if_model_parameters` 显示 23 个字段。几何与光束方向组为 `K`、`L`、`ax`、`ay`、`cx`、`cy`、`dd`、`ee`、`Ryix0`、`Rzix0`、`Rxiy0`、`Rziy0`。Z 相关组为 `ezxa`、`ezya`、`ezza`、`czxxa`、`czxya`、`czxza`、`czyya`、`dzxxa`、`dzyya`、`dzzza`、`dzxza`。该报表是特定版本的字段证据。见《12-TT-L3-L3-ME_book.pdf》文件第 89–92 页、《TT-MA-ME_setupblock_6-8_1v3.ppt》第 33–38 张。 |
| GIWS、GRMO 与焦面校准 | 双侧镜面／网格参考，应用范围随版本和配置。 | GIWS 处理位置相关镜面图，GRMO 处理 XY 非正交和尺度。较新的无 CS 流程还用 Combined FOCAL 约束与焦面有关的 Z 镜残差。旧版的 CS 相对 Z 镜面图应按旧版流程追溯。见《TT-MA-ME_setupblock_6-8_1v3.ppt》第 39–58、77–94 张、《12-TT-L3-L3-ME_book.pdf》文件第 53–56 页、《13_AP-L1-ME_rel_3.2.pdf》文件第 62–67 页。 |

## 原件差异与实现边界

| 待核对项 | 证据与处理 |
| --- | --- |
| Y 的 `ay` 转角及 `Ly` 二次角项 | 附件第 1 页 Y 式是 `+ay*Ry`，第 2 页表给出 Y(Rx)。`Ly` 的第一组角含 Rx，第二组明确写成 `Ry^2 + Rz^2`。保留公式中的轴，查目标机参数表或已知方向的独立姿态数据后再定。 |
| `dd`、`ee` 的轴与作用 | 附件第 1 页公式把 `ee` 用于 X、`dd` 用于 Y，第 3 页表的 Effect 栏相反。Level 3 曝光报表解释 `dd` 为 Y-IFM 在 X 方向的位置误差，`ee` 为 X-IFM 在 Y 方向的位置误差。用原机定义和旋转数据确认轴、符号和基准。见《12-TT-L3-L3-ME_book.pdf》文件第 92 页。 |
| 字段拼写与分通道 | 附件把 `Rzix0`、`dRzixh` 在表里写作 `Rzxix0`、`dRzxixh`。表还把 Y3 差分项的 Effect 写成 Rzx，第 1 页原式则出现在 `Rzy`。Level 3 曝光报表使用 `Rzix0`，其余字段应查机型报表。 |
| `(Xb/4*cx)`、`(Yb/4*cy)` | 原件未定义 `Xb`、`Yb`。同页首项明确有 `(4*cx)`、`(4*cy)` 的分母括号，后续项写法采用左结合的代码语法时，会得到 `(Xb/4)*cx`、`(Yb/4)*cy`。实现前确认距离定义、括号和量纲，再做符号检查。 |
| `Ryz` 的 Z 差分归一化和角度幂次 | 原件第 4 页写 `mz2*((1-2*Z/kze)/kze)^2` 和 `dryya*Ry`。`sfryz` 的数值与量纲未附，保留平方及一次 Ry，并以已知 Z/Ry 位移、目标机模型或参数说明校核。 |
| `Ryz` 到 Z 的实现接口 | 原件说明 `Ryz` 用于 Z 部分，但展示的 `Z` 公式只显式使用 `Ry`，没有给出两者如何接入。Level 3 确认常规 Ry 控制使用 `Ryx`，Z 方向仍受 `Ryz` 影响。控制器接口与求值顺序需要另行确认。 |
| 图 1 与第 3 节 | 附件第 4 页保留 “Figure 1” 的标题，第 5 页提及第 3 节。这个 DOCX 五页里没有对应图本体或第 3 节，光路和标定的交叉证据来自上列 Level 1–3 页。 |

工程使用前核对 Chuck 1/2、M/E、机型和版本。数据进入运算前，统一输入长度及角度单位并逐字段查录入单位。WGTD 示例对几何长度、束线角和 Z 系数采用多种单位，不能把所有列按同一个比例换算。若只做模型验证，可先用零转角、零束线误差、单位尺度和零非正交的合成数据检查 `X=mx1`、`Y=my1`、`Z=mz1`，再独立扫一个转角检查串扰项。实机数值验收应依据适用的机型定义和标定数据。
