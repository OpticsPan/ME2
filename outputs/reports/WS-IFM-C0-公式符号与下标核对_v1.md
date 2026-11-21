# WS-IFM C0 公式符号与下标逐项核对 v1

[结论与约定](#c0-sign-result) · [X](#c0-check-x) · [Y](#c0-check-y) · [Rzx](#c0-check-rzx) · [Rzy](#c0-check-rzy) · [Z](#c0-check-z) · [Ryz](#c0-check-ryz) · [Rx 和 Ryx](#c0-check-missing) · [FreeCAD 复算](#c0-check-freecad) · [资料与核对范围](#c0-check-sources) · [成果索引](../README.md)

<a name="c0-sign-result"></a>

## 结论与约定

按《ifm模型.docx》第 1、4 页复核 C0。六条显式公式的最外层加减项数为 **X 5、Y 6、Rzx 4、Rzy 3、Z 15、Ryz 14，共 47 项**。表格左列保留原项，右列按同一位置给出校核式，粗体标明变动。括号内的分量随原项编号一起核对，外乘的比例系数不计入项数。右列可按顺序求和，X、Y、Z、Ryz 再分别乘原外层比例系数。带条件的结果需要按表中条件使用。

在当前 CAD 和本文约定下，X 与 Y 的竖直 Abbe 补偿分别是 **`+ax*Ry`、`-ay*Rx`**。两路偏航的名义二阶配置保持 **X 路扣 `Rx*Ry`、Y 路无此项**。Z 式的 `X*Rx*Rz` 需改为负号，Ryz 的差分主项、两项名义角平方补偿也需改正。X/Y 的两组余弦项无法在当前名义模型中分别辨识，`dryya` 的幂次及部分安装误差字段仍待目标机资料确认。保留原项数的核对式在混合工况中仍会留下结构残差。 [原式](WS-IFM%E6%A8%A1%E5%9E%8B_v1.md#xy-ifm-原式) · [旋转约定](WS-IFM-C0-ZXY%E8%BD%AC%E5%BA%8F%E6%A0%B8%E5%AF%B9_v1.md#c0-zxy-conventions)

沿用右手系、主动旋转、列向量和 `R = RotZ(Rz) * RotX(Rx) * RotY(Ry)`。`X、Y、Z` 是实验室坐标中的平移，原点为 CAD 晶圆上表面中心。读数为扣零后的等效单程长度，mm 和 rad 入式。取 `mx1=(x1+x2)/2`、`mx2=x1-x2`、`my1=(y1+y2)/2`、`my2=y2-y1`、`mz1=(z1+z2)/2`、`mz2=z1-z2`，其中小写 `z1、z2` 每路均为直返增量减折返增量。`ax、ay` 是焦面到下方光束的正值高度差。涉及 `ee、dd` 的有向正号，分别按 X 头 Y 坐标减参考点 Y 坐标、Y 头 X 坐标减参考点 X 坐标。实机迁移先对齐方向、倍率、工位和转心。 [CAD 坐标与读数](WS-IFM%E6%A8%A1%E5%9E%8B_v2.md#坐标与观测量) · [常数的标定来源](WS-IFM%E6%9C%BA%E5%99%A8%E5%B8%B8%E6%95%B0%E6%A0%A1%E5%87%86%E9%A1%B9%E7%9B%AE_v1.md#core-calibrations)

<a name="c0-check-x"></a>

## X（5 项，外乘 `sfx`）

| 项 | C0 原项 | 同位置校核式 | 依据 |
| --- | --- | --- | --- |
| X1 | `mx1` | `mx1` | X 上两束均值。纯 X 正向运动时首项取正。 |
| X2 | `+ [(X + Kx - kx/2)/2] * [(Ry - Ryix0)^2 + (Rz - Rzix0)^2]` | `+ [(X + Kx - kx/2)/2] * [(Ry - Ryix0)^2 + (Rz - Rzix0)^2]` | X 镜法向受 Ry、Rz 倾转，两个角及误差分量下标一致。轴向距离的符号及与 X3 的分解待查后角锥和反射面基准。若误差角定义为束相对名义正向倾转，入射夹角确为两角相减。 |
| X3 | `+ Kx*(Ry^2 + Rz^2)/2` | `+ Kx*(Ry^2 + Rz^2)/2` | Ry、Rz 下标正确。该项与 X2 的名义平方部分具有相同角基函数，CAD 可测合量，单独的 `Kx` 项符号待原机模型分解。 |
| X4 | `- ee*(Rz + Rx*Ry)` | **`+ ee*(Rz + Rx*Ry)`** | X 镜法向的 Y 分量到二阶为 `Rz+Rx*Ry`。按本文有向 `ee`，读数偏置为负，反解补正为正。当前 CAD `ee=0`，符号由投影推导。 |
| X5 | `- ax*Ry` | **`+ ax*Ry`** | 纯正 Ry 使 X 上束均值变短。`Ry` 下标保留，反解加回。见 [单轴量测](#c0-check-freecad)。 |

`sfx` 保留为 X 尺度。C0 表把 `Rzix0` 写作 `Rzxix0`。原式和 Level 3 表 2.2 均用 `Rzix0`，其物理含义为 X-IFM 束线平均偏航分量。C0 表也把 `dd、ee` 的作用列互换，以下仍以 `ee` 对 X、`dd` 对 Y。 [原表冲突](WS-IFM%E6%A8%A1%E5%9E%8B_v1.md#原件差异与实现边界) · [资料定位](#c0-check-sources)

<a name="c0-check-y"></a>

## Y（6 项，外乘 `sfy`）

| 项 | C0 原项 | 同位置校核式 | 依据 |
| --- | --- | --- | --- |
| Y1 | `my1` | `my1` | Y 上两束均值。纯 Y 正向运动时首项取正。 |
| Y2 | `+ [(Y - Ly + ly/2)/2] * [(Rx - Rxiy0)^2 + (Rz - Rziy0)^2]` | `+ [(Y - Ly + ly/2)/2] * [(Rx - Rxiy0)^2 + (Rz - Rziy0)^2]` | Y 镜法向受 Rx、Rz 倾转，角度和偏置下标保留。轴向距离的符号及与 Y3 的分解待查实际端点。 |
| Y3 | `- Ly*(Ry^2 + Rz^2)/2` | `- Ly*(`**`Rx^2`**` + Rz^2)/2` | 原件第 2 页 `Ly` 的作用栏是 `Y(Rx², Rz², Y*Rx, Y*Rz)`，纯 Ry 对名义 Y 镜法向无影响。先确认 `Ry^2 -> Rx^2`。CAD 测得合量为正，仍不能单独反推出此项 `Ly` 的符号，见下段。 |
| Y4 | `+ dd*(Rz + Rx*Ry)` | **`- dd*Rz`** | Y 镜法向的 X 分量为 `-sin(Rz)*cos(Rx)`，到二阶只有 `-Rz`，这一项内部 `Rx*Ry` 的系数为零。当前 CAD `dd=0`，符号由投影推导。 |
| Y5 | `+ ay*Ry` | **`- ay*Rx`** | C0 第 2 页表给出 `Y(Rx)`。纯正 Rx 使 Y 上束均值变长，反解扣除。 |
| Y6 | `- sxy*X` | `- sxy*X` | X 自变量与原表 `Y(X)` 一致。若 `sxy` 为未补偿的 `∂my1/∂X`，负号正确。实机有向定义及是否已在输入中应用待核。 |

`sfy` 保留为 Y 尺度。把 X2/X3 和 Y2/Y3 分别合起来看，先令方向偏置为零并在零平移测纯角偶分量。按该 CAD，乘 `(Ry^2+Rz^2)/2` 的 X 有效长度为 **+480 mm**，乘 `(Rx^2+Rz^2)/2` 的 Y 有效长度为 **+425 mm**。把 CAD 距离机械地代入原件，即 `Kx=480、kx=530、Ly=425、ly=380 mm`，则 X 合量为 `+695 mm`，Y 在改角度下标后合量为 `-660 mm`。仅翻转 Y3 前的号，Y 合量仍只有 `+190 mm`。这说明轴向距离端点或两个项的分解也需要核对。保留各自原位置，避免靠任意翻号去拟合合量。当前几何中名义光学 X 镜距为 400 mm，`kx` 对应原文台体 X 尺寸。 [CAD 基线及距离换算](WS-IFM%E6%A8%A1%E5%9E%8B_v2.md#几何参数表) · [量测定义](#c0-check-freecad)

<a name="c0-check-rzx"></a>

## Rzx（4 项）

| 项 | C0 原项 | 同位置校核式 | 依据 |
| --- | --- | --- | --- |
| RZX1 | `mx2/(4*cx)` | `mx2/(4*cx)` | `mx2=x1-x2` 对正 Rz 增大，`4*cx` 是 X 上束水平基线。 |
| RZX2 | `- Rx*Ry` | `- Rx*Ry` | 规定转序下，几何差分的二阶混合项为 `+Rx*Ry`，应扣除。 |
| RZX3 | `- (Xb/4*cx) * [(Ry-Ryix0)*dRyixh + (Rz-Rzix0)*dRzixh]` | `- `**`(Xb/(4*cx))`**` * [(Ry-Ryix0)*dRyixh + (Rz-Rzix0)*dRzixh]` | 若 `Xb` 为有向长度且 `d...` 随 `x1-x2` 的束序定义，式子量纲一致，两个角下标匹配。距离端点、旧 MC 的符号及补偿作用点待实机记录。 |
| RZX4 | `+ ux*Ry` | `+ ux*Ry` | `Ry` 下标匹配 X 上束的不等高误差。若 `ux=(z_X2-z_X1)/(4*cx)`，其中 `z_Xi` 为 X 束起点的高度，原加号成立。原文未给 `ux` 的有向定义。 |

C0 表内 `dRzxixh` 统一成正文的 `dRzixh`。`dRyixh、dRzixh` 在偏航式中应描述 **X1/X2** 上束的方向差；若现有 MC 的定义确为 `X3 - 上束平均`，不能直接把该数值接入此项。 [差分观测](WS-IFM%E6%A8%A1%E5%9E%8B_v1.md#光路与输入输出) · [名义二阶差序](WS-IFM-C0-ZXY%E8%BD%AC%E5%BA%8F%E6%A0%B8%E5%AF%B9_v1.md#c0-zxy-yaw)

<a name="c0-check-rzy"></a>

## Rzy（3 项）

| 项 | C0 原项 | 同位置校核式 | 依据 |
| --- | --- | --- | --- |
| RZY1 | `my2/(4*cy)` | `my2/(4*cy)` | `my2=y2-y1` 对正 Rz 增大。在当前转序下 `Rx*Ry` 对此通道的名义二阶系数为零。 |
| RZY2 | `- (Yb/4*cy) * [(Rx-Rxiy0)*dRxiyh + (Rz-Rziy0)*dRziyh]` | `- `**`(Yb/(4*cy))`**` * [(Rx-Rxiy0)*dRxiyh + (Rz-Rziy0)*dRziyh]` | 若 `Yb` 为有向长度且 `d...` 随 `y2-y1` 的束序定义，量纲一致。`Rx、Rz` 下标匹配。和 X 路一样，距离端点与旧 MC 的有向定义待查。 |
| RZY3 | `+ wy*Rx` | `+ wy*Rx` | `Rx` 下标匹配 Y 上束的不等高误差。若 `wy=(z_Y2-z_Y1)/(4*cy)`，其中 `z_Yi` 为 Y 束起点的高度，原加号成立。原文未给 `wy` 的有向定义。 |

`dRxiyh、dRziyh` 在此方程应描述 **Y1/Y2** 上束的方向差，C0 表的效应栏应写 **Rzy**。对 RZX3、RZY2，若两路共用同一工作距离 `Lb`，每路的原型余弦补偿为 `+Lb*(角度-束线误差)^2/2`。按本路相减顺序对两束方向误差作差，线性化后得到原负号。采用别的差分定义时应同时转换系数符号；下束方向误差可用于下束参与的角度求解。 [原表错位](WS-IFM%E6%A8%A1%E5%9E%8B_v1.md#原件差异与实现边界)

<a name="c0-check-z"></a>

## Z（15 项，外乘 `sfz`）

| 项 | C0 原项 | 同位置校核式 | 依据 |
| --- | --- | --- | --- |
| Z1 | `mz1` | `mz1` | Z 双路均值随正升高增大。 |
| Z2 | `+ X*Rx*Rz` | **`- X*Rx*Rz`** | 固定其余量，FreeCAD 前向均值中 `X*Rx*Rz` 系数约为 +1，故反解扣除。 |
| Z3 | `+ szya*Y` | `+ szya*Y` | WZIM 的 Y 向高度斜率。 |
| Z4 | `+ szxa*X` | `+ szxa*X` | WZIM 的 X 向高度斜率。 |
| Z5 | `+ ezxa*Rx` | `+ ezxa*Rx` | Level 3 表 2.2 对应 Rx。 |
| Z6 | `+ ezya*Ry` | `+ ezya*Ry` | Level 3 对应 Ry。用于 Z 子模型的 Ry 输入见表后。 |
| Z7 | `+ ezza*Rz` | `+ ezza*Rz` | Level 3 对应 Rz。 |
| Z8 | `+ czxya*X*Ry` | `+ czxya*X*Ry` | Level 3 对应 X 与 Ry。 |
| Z9 | `+ czxza*X*Rz` | `+ czxza*X*Rz` | Level 3 对应 X 与 Rz。 |
| Z10 | `+ czyya*Y*Ry` | `+ czyya*Y*Ry` | Level 3 明确是 Y 与 Ry。CAD 同时存在独立的 `Y*Rx` 响应。 |
| Z11 | `+ czxxa*X*Rx` | `+ czxxa*X*Rx` | Level 3 对应 X 与 Rx。 |
| Z12 | `+ dzyya*Ry^2` | `+ dzyya*Ry^2` | Level 3 明确是 Ry 的平方。 |
| Z13 | `+ dzzza*Rz^2` | `+ dzzza*Rz^2` | Level 3 明确是 Rz 的平方。 |
| Z14 | `+ dzxxa*Rx^2` | `+ dzxxa*Rx^2` | Level 3 明确是 Rx 的平方。 |
| Z15 | `+ dzxza*Rx*Rz` | `+ dzxza*Rx*Rz` | Level 3 对应 Rx 与 Rz。与 Z2 相比，此项无 X 位置乘因子。 |

`sfz` 保留为总比例。Z3–Z15 的外层加号沿用 C0 作为有符号拟合系数的接口，系数本身可正可负。C0 第 4 页说明 Z 子模型使用 `Ryz`。因此 Z6、Z8、Z10、Z12 的 `Ry` 可在该子模型入口接 `Ryz`，具体轴融合及计算顺序按目标软件。生产 Ry 控制量仍为 `Ryx`。CAD 另外测得 `mz1` 中约 `-Y*Rx` 和 `-Z*Rx^2` 的响应。`Y*Rx` 与 `czyya*Y*Ry` 的物理基函数独立，不能靠换 `czyya` 下标消掉。 [WZIM 和 WGTD](WS-IFM%E6%A8%A1%E5%9E%8B_v1.md#标定项目与模型项的关系) · [FreeCAD 混合项](#c0-check-freecad)

<a name="c0-check-ryz"></a>

## Ryz（14 项，外乘 `sfryz`）

| 项 | C0 原项 | 同位置校核式 | 依据 |
| --- | --- | --- | --- |
| RYZ1 | `mz2*((1 - 2*Z/kze)/kze)^2` | **`mz2/(kze + 2*Z)`** | mm 制下原括号平方使首项为倒长度。纯 Ry 时测得有效臂为 `kze+2*Z`；保留 Z 一阶近似时可写 `(mz2/kze)*(1-2*Z/kze)`。 |
| RYZ2 | `+ (2/kze)*X*Rx^2` | **`- (1/kze)*X*Rx^2`** | 名义前向差分含 `+1*X*Rx^2`，近零位反解为负号，系数为 1 而非 2。 |
| RYZ3 | `+ (4/kze)*X*Ry^2` | **`- (3/kze)*X*Ry^2`** | 名义前向差分含 `+3*X*Ry^2`，近零位反解为负号，系数为 3 而非 4。 |
| RYZ4 | `+ srxa*X` | `+ srxa*X` | Level 3 明确为 X 对 Ryz 的贡献。 |
| RYZ5 | `+ srya*Y` | `+ srya*Y` | WGIM 确认标定随 X、Y 变化的一阶偏差，具体完整字段表待核。 |
| RYZ6 | `+ srza*Z` | `+ srza*Z` | Z 下标与项形式一致，独立的标定字段和符号待核。 |
| RYZ7 | `+ erxa*Rx` | `+ erxa*Rx` | 字段 x 与 Rx 一致，目标机有向系数待核。 |
| RYZ8 | `+ erza*Rz` | `+ erza*Rz` | 字段 z 与 Rz 一致，目标机有向系数待核。 |
| RYZ9 | `+ crxxa*X*Rx` | `+ crxxa*X*Rx` | 位置 X 与角 Rx 的双下标一致，目标机有向系数待核。 |
| RYZ10 | `+ crxya*X*Ry` | `+ crxya*X*Ry` | 位置 X 与角 Ry 的双下标一致，目标机有向系数待核。 |
| RYZ11 | `+ crxza*X*Rz` | `+ crxza*X*Rz` | 位置 X 与角 Rz 的双下标一致，目标机有向系数待核。 |
| RYZ12 | `+ drxxa*Rx^2` | `+ drxxa*Rx^2` | 两个 x 与 Rx 平方一致，目标机有向系数待核。 |
| RYZ13 | `+ drxza*Rx*Rz` | `+ drxza*Rx*Rz` | 两个转角下标对应 Rx、Rz。前缀与 Z15 的 `dzxza` 不同，勿混用两个标定系数。 |
| RYZ14 | `+ dryya*Ry` | `+ dryya*Ry`（待核幂次） | 原件第 4 页确为一次。`d*yy` 的对称形式指向 `Ry^2`，但字段名与后续附件不足以证明旧参数的阶次。对等幅正负 Ry 测到的同号残差支持平方项，反号残差支持一次项。 |

`sfryz` 的现场数值及量纲待与原机读数倍率一并核对，名义诊断的修正首项取 `sfryz=1`。RYZ2、RYZ3 在近零位按 `1/kze` 归一；采用工作点有效臂时，可将两项的分母同时按工作点替换。表中 RYZ3、RYZ10、RYZ14 的 `Ry` 是串扰补偿用的俯仰输入，复算单项可用预设 Ry，实施时可由独立 X 路 `Ryx` 提供；不要把同周期未知 `Ryz` 当作已知数直接代入。FreeCAD 还测得 `mz2` 含约 `-2*Y*Rx*Ry`，在混合姿态下会影响主项灵敏度。 [原 Ryz 逐项解读](WS-IFM-C0-Ryz%E5%85%AC%E5%BC%8F%E9%80%90%E9%A1%B9%E8%A7%A3%E8%AF%BB_v1.md#ryz-terms) · [WGIM 参数](WS-IFM%E6%9C%BA%E5%99%A8%E5%B8%B8%E6%95%B0%E6%A0%A1%E5%87%86%E9%A1%B9%E7%9B%AE_v1.md#mc-wgim)

<a name="c0-check-missing"></a>

## Rx 和 Ryx

| C0 输出或控制量 | 原件状态 |
| --- | --- |
| `Rx` | 在补偿式中作为输入出现，原件缺独立解算式，因而无原项可核对。 |
| `Ryx` | 原件第 4 页说明 X-IFM 提供生产 Ry 控制观测，未列独立解算式。 |
| 最终 `Ry、Rz` | 原件区分了角度和分通道估计，但未列单独的融合公式。两组冗余仍是 `Ryx/Ryz`、`Rzx/Rzy`。 |

[八束到各通道的对应关系](WS-IFM%E5%85%AB%E8%B7%AF%E5%85%89%E7%A8%8B%E4%B8%8E%E5%85%AD%E8%87%AA%E7%94%B1%E5%BA%A6%E8%A7%A3%E7%AE%97_v1.md#me2-channels)

<a name="c0-check-freecad"></a>

## FreeCAD 复算

基于本机只读 `ws-ifm-agent.FCStd`，用 FreeCAD 0.21.2 另存本机验证副本，施加 **81 组**含零位、单轴、平移与倾转组合的位姿。每组由实际面、反射路径和路径边长度读取，双程路径最大闭合误差为 `7.09e-13 mm`。用 ±1 µrad 检查 Abbe 一阶斜率，±0.8 mrad 检查角度平方和混合项，X/Y 平移取 0、±15 mm，Z 取 0、±5 mm。对等幅正负角取奇差或二阶偶差，对不同平移位置的系数再取中心差。复算使用预设量隔离单项。脚本、路径数据和核验模型在本机 `work/ws-ifm-c0-sign-index-v1/`。

| 读数中的系数 | FreeCAD 估计 | 对照项 |
| --- | ---: | --- |
| `∂mx1/∂Ry`，`∂my1/∂Rx`，`∂my1/∂Ry`（mm/rad） | −43.5，+32.5，0 | X5、Y5 |
| 均值余弦补偿的 X、Y 有效长度（mm） | +480.000，+425.000 | X2+X3、Y2+Y3 |
| `Rx*Ry` 在 `mx2/(4*cx)`、`my2/(4*cy)` 中的系数 | +1.000000，0 | RZX2、RZY1 |
| `X*Rx*Rz`、`Y*Rx`、`Z*Rx^2` 在 `mz1` 中的系数 | +0.999999，−1.000000，−1.000000 | Z2、Z 式结构差异 |
| `X*Rx^2`、`X*Ry^2`、`Y*Rx*Ry` 在 `mz2` 中的系数 | +1.000000，+2.999999，−1.999997 | RYZ2、RYZ3、Ryz 式结构差异 |
| `Z=-5, 0, +5 mm` 时 `∂mz2/∂Ry`（mm/rad） | 544.000，554.000，564.000 | RYZ1 |

在 `Ry=800 µrad` 的三个 Z 高度工况中，令原平方式在 Z=0 处有与修正式相同的数值增益，原首项分别解出 **814.175、800.000、785.303 µrad**，新首项分别为 **799.999625、799.999621、799.999617 µrad**。此对照检验的是首项的高度依赖，归一用的倍率不是原机 `sfryz`。

同一名义 CAD 还给出 X/Y 反解的平移串扰，例如 X 中的 `-Y*Rz + Z*Ry`、Y 中的 `+X*Rz - Z*Rx`。这些和上表所列 Z、Ryz 额外响应表明，仅在 C0 原项内改正负号、下标和分母仍无法覆盖当前 CAD 的全部混合位姿。拟合符号及实机残差需要型号对应的 MC 和标定读数。 [已有全姿态结果](WS-IFM%E6%A8%A1%E5%9E%8B_v2.md#逐项解算的-20-组-freecad-验证)

<a name="c0-check-sources"></a>

## 资料与核对范围

- 《ifm模型.docx》第 1 页为 XY 四式，第 2–4 页为 XY 参数及作用列，第 4 页为 Z 两式和输入说明，第 5 页定义 `mz1、mz2、kze`。核对过正文 XML 与五页渲染。 [原文转录](WS-IFM%E6%A8%A1%E5%9E%8B_v1.md#xy-ifm-原式)
- 《12-TT-L3-L3-ME_book.pdf》文件第 92 页（印刷第 84 页），表 2.2 原图。它标明 `dd` 是 Y-IFM 的 X 向偏置、`ee` 是 X-IFM 的 Y 向偏置，并直接列出 Z 式的 WGTD 位置与角度下标。同书文件第 27–32 页、57 页支持 WZIM、WGIM 的位置斜率归属。第 32 页（印刷第 24 页）图 2.12 的台体 X 向扫描示意能确认计量框架镜不平行会产生位置相关的 Ryz，图中未给出可用于本 CAD 的有向系数。 [标定图表索引](WS-IFM%E6%9C%BA%E5%99%A8%E5%B8%B8%E6%95%B0%E6%A0%A1%E5%87%86%E9%A1%B9%E7%9B%AE_v1.md#原页图表索引)
- 《09-TT-L3-WSbook.pdf》文件第 58 页（印刷第 50 页）图 1.60 显示 Z1、Z2 由台体 45° 面折向计量框架镜。图可校对光路分工。束序和正号来自本文 FreeCAD 读数约定。回看 Level 2 的《TT-L2-ME-3v0.pdf》文件第 58–59 页及 Level 1 的《13_AP-L1-ME_rel_3.2.pdf》文件第 29 页，分别用来核对 WS TRIM 冗余比较和 Abbe 标定作用。 [光路图和出处](WS-IFM%E6%A8%A1%E5%9E%8B_v1.md#光路与输入输出)
