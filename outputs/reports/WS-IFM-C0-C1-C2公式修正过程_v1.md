# WS-IFM C0 → C1 → C2 公式修正过程 v1

[版本与约定](#versions) · [八个输出对照](#equation-comparison) · [C0 到 C1](#c0-to-c1) · [C1 到 C2 的推导](#c1-to-c2) · [复验结果](#checks) · [完整 C0 原式](#c0-full)

<a name="versions"></a>

## 版本与约定

| 名称 | 公式来源 | 计算方式 |
| --- | --- | --- |
| C0 | 《ifm模型.docx》第 1、4 页 | 用原公式和名义机器常数反解。原件缺少 Rx、Ryx，比较时用 C1 从同组读数计算的两个角作为输入。 [参数选取](WS-IFM-C0-C1%20MATLAB%E4%BB%BF%E7%9C%9F%E6%8A%A5%E5%91%8A_v1.md#c0-source) |
| C1 | 《sim_ws_ifm_6dof_animation_v5.m》 | 改正 X/Y 一阶 Abbe 补偿，补上 Rx、Ryx 解算，Z 与 Ryz 使用 250 组名义仿真标定得到的系数。 |
| **C2** | 已验证的 MATLAB v6 修正式 | 从 v5 四段 XY 光程恢复法向及位姿，从 Z 均值解高度、从 Z 差值另求冗余俯仰。对应 v6 输出字段 `C1Corrected`。 [MATLAB v6](../code/sim_ws_ifm_6dof_animation_v6.m) |

三版对照沿用 v5 的光路和读数。台体点从局部到世界的变换是 `P_world = R·(P_local+T)`，`R=RotX(Rx)·RotY(Ry)·RotZ(Rz)`。报告的 XYZ 为旋转前的位移分量 `T`。下文用 `a=Rx、b=Ryx、c=Rzx`，`Rzy` 与 `Ryz` 分别作为冗余偏航和俯仰，原式的主输入 `Ry、Rz` 分别取 `b、c`。长度用 mm，角度用 rad。

XY 的读数是扣零后二次往返光程差除以 4，Z 各路取直返减折返的扣零光程差除以 2。下文简称这八路为 `x1…x3、y1…y3、d1、d2`。

```text
mx1 = (x1+x2)/2    mx2 = x1−x2
my1 = (y1+y2)/2    my2 = y2−y1
mz1 = (d1+d2)/2    mz2 = d1−d2

uX = mx2/(4cx)                     uY = my2/(4cy)
vX = (x3−mx1+δy_X·uX)/hx           vY = (y3−my1−δx_Y·uY)/hy
Px = (b²+c²)/2                     Py = (a²+c²)/2
```

`4cx、4cy` 是上束间距，`hx、hy` 是上束中点到第三束的正值垂直间距。`δy_X、δx_Y` 是第三束与上束中点之有向横向偏置。C0 的 `kx` 按 DOCX 定义取台体外包络宽度 530 mm。v5 的 `cfg.kx=400 mm` 给出 X 镜面间距，下文记 `rX=200 mm` 为半间距，`rY=ly/2=190 mm`。`LX0=Kx−rX=280 mm、LY0=Ly−rY=235 mm` 是名义 XY 上束绝对光程的四分之一。

<a name="equation-comparison"></a>

## 八个解算输出对照

C0 列为同一仿真中代入名义机器常数后的方程。左端出现自项时，C0 在程序中代数移项求解。C1 的 X/Y 用初值 `mx1、my1` 执行三次更新。C1、C2 各列中的角度和位移表示本版前续步骤计算得到的值。

| 输出 | C0 | C1 | C2 |
| --- | --- | --- | --- |
| Rx | 原件无独立式，复算共用 C1 输入。 | <code>a = vY + b·uY</code> | <code>a = atan2(−nZ_y,nZ_z)</code> |
| Ryx | 原件无独立式，复算共用 C1 输入。 | <code>b = −vX + (δy_X/hx)·(uX−uY)</code> | <code>b = atan2(nZ_x,hypot(nZ_y,nZ_z))</code> |
| Rzx | <code>Rzx = uX − a·b</code> | <code>Rzx = uX − a·b</code> | <code>Rzx = atan2(wX_y,wX_x)</code> |
| Rzy | <code>Rzy = uY</code> | <code>Rzy = uY</code> | <code>Rzy = atan2(−wY_x,wY_y)</code> |
| X | <code>X = mx1 + (X+2Kx−kx/2)·Px − ax·b</code> | <code>X[k+1] = mx1 + (X[k]+2Kx−rX)·Px + ax·b</code> | <code>X = (mx1+LX0)/sX + rX − Kx·sX − ax·nX_z</code> |
| Y | <code>Y = my1 + (Y−Ly+rY)·Py − Ly·Px + ay·b</code> | <code>Y[k+1] = my1 + (Y[k]+2Ly−rY)·Py − ay·a</code> | <code>Y = (my1+LY0)/sY + rY − Ly·sY − ay·nY_z</code> |
| Z | <code>Z = mz1 + X·a·c + ΦZ·q0</code> | <code>Z = [mz1+X·a·c, ΦZ]·θZ</code> | <code>Z = [mz1−g(0)]/[g(ℓ)−g(0)]·ℓ</code>，`ℓ=1 mm`。 |
| Ryz | <code>Ryz = mz2·[(1−2Z/kze)/kze]² + (2X/kze)·a² + (4X/kze)·b² + drxza·a·c</code> | <code>Ryz = [B1, ΦR]·θRyz</code>，<code>B1 = (mz2/kze)·(1−2Z/kze) + (2X/kze)·a² + (4X/kze)·b²</code> | <code>Ryz = θ</code>，满足 <code>H(θ)−mz2 = 0</code>。 |

```text
ΦZ = [Y, X, a, b, c, X·b, X·c, Y·b, X·a, b², c², a², a·c]
q0 = [szya, szxa, ezxa, ezya, ezza, czxya, czxza, czyya,
      czxxa, dzyya, dzzza, dzxxa, dzxza]

ΦR = [X, Y, Z, a, c, X·a, X·b, X·c, a², a·c, b²]
```

C0 的 `q0` 由名义光路在零位的局部导数给定，按 C0 的原参数含义排列。C0 的 Ryz 表中代入名义 `sfryz=1`，其余除 `drxza` 外取零。差分首项在 mm 制下为倒长度，原件未给 `sfryz` 量纲，数值比较时单独标注。C1 的 `θZ、θRyz` 是 v5 拟合系数，次序对应代码中的两个特征向量。C2 的 `nX、nY、nZ、sX、sY、wX、wY、g、H` 定义如下。 [三版计算条件](WS-IFM-C0-C1%20MATLAB%E4%BB%BF%E7%9C%9F%E6%8A%A5%E5%91%8A_v1.md#c0-source)

<a name="c0-to-c1"></a>

## C0 → C1 的修改

1. **X 一阶符号。** 纯 Ry 小转角时，X 上束均值含 `−ax·Ry`。C0 再扣一次，解算 X 的一阶误差为 `−2ax·Ry`。C1 将补偿改为 `+ax·Ry`。X 的第二阶几何结构保留，代码把 X 光学镜面半距取为 200 mm。
2. **Y 的补偿轴、符号和余弦项。** Y 上束均值的一阶变化是 `+ay·Rx`，C0 写成 `+ay·Ry`。C1 改为 `−ay·Rx`，并把 Y 的死程二次项由含 Ry 的组合改成与 Y 面法向有关的 `Rx²+Rz²`，按 v5 光路取正向距离补偿。
3. **角度补全。** C1 用各组上束和第三束求 `Ryx、Rx`，沿用 `Rzx≈uX−Rx·Ryx、Rzy≈uY`。当时用下束差近似角度，并在 Rx 输入上再加一个 `Ryx·Rzy`。
4. **Z 与 Ryz 标定。** C1 保留 C0 Z 式的特征项，用 250 组名义位姿拟合 `θZ`。Ryz 把差分首项改成 `(mz2/kze)(1−2Z/kze)`，把末项 Ry 基函数从一次改成平方，再拟合 `θRyz`。C1 的 `kze=465 mm` 采用两 45° 面中心的 X 间距，前向光路在零位测得的 Z 差分有效臂约 554 mm。拟合首项系数约 0.83932，与 `465/554` 接近。 [v5 残差诊断](WS-IFM-C0-C1%20MATLAB%E4%BB%BF%E7%9C%9F%E6%8A%A5%E5%91%8A_v1.md#c1-diagnosis)

<a name="c1-to-c2"></a>

## C1 → C2 的推导

### 第一步　从四段 XY 光程恢复镜面法向

设一束光从读数头 `H` 以单位方向 `d` 射向经过 `P` 的台镜，镜面单位法向为 `n`。令 `k=n·d`，第一段 `s=[n·(P−H)]/k`。按 v5 角锥回程的展开法，第二次照射以前的两段合为 `2s`，最后回到头平面的一段为 `s(4k²−3)`。所以 `L=s+2s+s(4k²−3)`，得到 `L/4=(n·d)[n·(P−H)]`。

在零姿态附近取 `sX=nX_x>0、sY=nY_y>0`。上束差与下束差可以消除各束共有的位移和死程项。

```text
uX = sX·nX_y          vX = sX·nX_z
uY = −sY·nY_x         vY = sY·nY_z
sX⁴ − sX² + uX²+vX² = 0
sY⁴ − sY² + uY²+vY² = 0

sX = √[(1+√(1−4(uX²+vX²)))/2]
sY = √[(1+√(1−4(uY²+vY²)))/2]
nX = (sX, uX/sX, vX/sX)ᵀ
nY = (−uY/sY, sY, vY/sY)ᵀ
```

四次式由 `||n||²=1` 得到。较大根使 `sX、sY` 在姿态趋零时趋近 1。`vX、vY` 是带投影因子的法向分量，靠近零位才与对应法向分量接近。

### 第二步　按 v5 的转序读出四个角

```text
nZ = nX × nY = (sin b, −sin a·cos b, cos a·cos b)ᵀ
a  = atan2(−nZ_y,nZ_z)
b  = atan2(nZ_x,hypot(nZ_y,nZ_z))

U  = RotY(−b)·RotX(−a)
wX = U·nX
wY = U·nY
Rzx = atan2(wX_y,wX_x)
Rzy = atan2(−wY_x,wY_y)
```

按同一转序展开到角度二阶，有 `vY≈a+b·c`、`vX≈−b+a·c`、`uX−uY≈a·b`。代回 C1 可见 `Rx_C1−Rx≈2b·c`，`Ryx_C1−Ryx≈−a·c+(δy_X/hx)·a·b`。C2 从两个镜面法向求台体 Z 轴后解角，再分别由 X/Y 面读取偏航。这解释了 C1 的主要角度残差。

### 第三步　用两路绝对光程均值求 X、Y

将绝对光程公式代入六个头的 CAD 坐标，对两路上束分别取平均。两条上束的横向坐标对称，均值中的横向项抵消。

```text
mx1 + LX0 = sX·[X−rX + Kx·sX + ax·nX_z]
my1 + LY0 = sY·[Y−rY + Ly·sY + ay·nY_z]
```

分别除以 `sX、sY` 即得对照表中的 C2 平移式。只看角度二阶，X 的 Abbe 部分为 `+ax·b−ax·a·c`，Y 为 `−ay·a−ay·b·c`。C1 已改对了一阶补偿，仍会受它的近似角度和剩余投影项影响。C2 以法向分量直接补偿这两个量。

### 第四步　由 Z 均值解高度，由 Z 差分解 Ryz

Z1/Z2 的折返路径按 45° 台镜 → 固定 Z 镜 → 同一 45° 台镜追迹，并与各自的直返光程相减。对任一段，光线起点为 `S`，入射方向为 `d`，相交平面经过 `P`、法向为 `n`。段长和下段方向为

```text
t = [(P−S)·n]/(d·n)
S_next = S + t·d
d_next = d − 2(d·n)·n
```

固定 `a、b、c` 后，所有方向和镜面法向固定，平面位置随 `T` 线性移动，逐段计算的光程因此对 Z 为仿射函数。令 `g(z)=mz1_forward(X,Y,z,a,b,c)`，用 `g(0)、g(1 mm)` 给出零高截距和高度斜率。C2 把测得 `mz1` 代入该直线求 Z。仅作误差定位时，用预设真值代入 C1 的拟合特征，Z 仍有 46.872 nm、Ryz 仍有 0.372164 µrad 的峰值残差，说明改正输入角度之后，拟合式还需要调整。

求冗余俯仰时固定已解算的 `X、Y、Z、a、c`，设 `H(θ)=mz2_forward(X,Y,Z,a,θ,c)`。用测得的 `mz2` 在 ±5 mrad 的局部分支上求 `H(θ)=mz2`。主俯仰 Ryx 来自 XY 面法向，Ryz 来自 Z 差分。对第 61 帧只给 `mz2` 加 10 nm，Ryz 增加约 0.01806 µrad，Ryx 保持原值。 [Z 差分验证](WS-IFM-C0-C1%20MATLAB%E4%BB%BF%E7%9C%9F%E6%8A%A5%E5%91%8A_v1.md#corrected-equations)

<a name="checks"></a>

## 复验结果

121 帧同一组读数的最大绝对误差如下。Ryz 的 C0 值仍按原式数值标度查看。 [全部 Max/RMS 和逐帧数据](WS-IFM-C0-C1%20MATLAB%E4%BB%BF%E7%9C%9F%E6%8A%A5%E5%91%8A_v1.md#simulation-results)

| 输出 | C0 | C1 | C2 |
| --- | ---: | ---: | ---: |
| X | 87.069 µm | 12.900 nm | 3.09×10⁻⁷ nm |
| Y | 57.413 µm | 29.400 nm | 2.56×10⁻⁷ nm |
| Z | 79.350 nm | 55.071 nm | 2.13×10⁻⁷ nm |
| Rx | 1.800 µrad | 1.800 µrad | 1.95×10⁻⁹ µrad |
| Ryx | 0.690 µrad | 0.690 µrad | 2.59×10⁻⁹ µrad |
| Ryz | 999.687（原式数值） | 0.370 µrad | 1.73×10⁻⁹ µrad |
| Rzx | 0.00269 µrad | 0.00269 µrad | 8.23×10⁻¹⁰ µrad |
| Rzy | 0.000965 µrad | 0.000965 µrad | 7.26×10⁻¹⁰ µrad |

C2 的适用条件来自 v5 的理想平面、角锥路径和转序。79 组额外 MATLAB 位姿、136 组 FreeCAD 实体面重采均回到舍入量级。实机装调常数需按各自用途和量纲接入。 [独立复验](WS-IFM-C0-C1%20MATLAB%E4%BB%BF%E7%9C%9F%E6%8A%A5%E5%91%8A_v1.md#independent-validation) · [机器常数来源](WS-IFM%E6%9C%BA%E5%99%A8%E5%B8%B8%E6%95%B0%E6%A0%A1%E5%87%86%E9%A1%B9%E7%9B%AE_v1.md#parameter-evidence)

<a name="c0-full"></a>

## 完整 C0 原式

以下转录保留《ifm模型.docx》第 1、4 页公式的参数、项和幂次。原件第 2、5 页定义了光程均值和差值、Abbe 臂及 Z 有效臂。 [原式来源与边界](WS-IFM%E6%A8%A1%E5%9E%8B_v1.md#原件差异与实现边界)

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

[回到公式对照](#equation-comparison) · [成果索引](../README.md)
