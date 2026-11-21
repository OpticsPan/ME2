# ifm_corr 晶圆台干涉仪修正模型

[读数与坐标](#corr-input) · [XY 与偏航](#corr-xy) · [滚转与主俯仰](#corr-tilt) · [Z 与冗余俯仰](#corr-z) · [运行实现及扩展](#corr-runtime) · [技术文档](ifm_model.md) · [原始模型](ifm_raw.md)

`ifm_corr` 是附件 `ws_ifm_c3_agent_spec.md` 的 M 侧 C3 方程。实践中的解算和复现采用用户提供的 `sim_ws_ifm_6dof_animation_v7.m`。附件 `build_ifm_c3_manuscript_pdf.py` 所含 v9 手稿用来核对布局、参数释义及原手稿勘误。其表 3 保留的手稿方向符号按该表约定阅读。本页统一采用 C3 说明 `4.1 的负 X、负 Y 侧和有向读数。公式以 mm 和 rad 为内部单位。 [资料出处](ifm_model.md#ifm-sources)

<a name="corr-input"></a>

## 坐标与读数

~~~text
T = [X, Y, Z]^T
R = RotZ(Rz) * RotX(Rx) * RotY(Ry)
p_world = R * (p_local + T)

mx1 = (x1+x2)/2   mx2 = x1-x2
my1 = (y1+y2)/2   my2 = y2-y1
mz1 = (z1+z2)/2   mz2 = z1-z2

Xb0 = Kx-kx/2     Yb0 = Ly-ly/2
Xb  = X+Xb0       Yb  = Y+Yb0
~~~

主输出为 `(X, Y, Z, Rx, Ryx, Rzx)`，冗余为 `(Ryz, Rzy)`。`Ry`、`Rz` 作为方程右端输入时按 v7 取 `Ryx`、`Rzx`。长度原始路径的归一化及八路分工见 [读数接口](ifm_model.md#ifm-readout)。

<a name="corr-xy"></a>

## X、Y、Rzx、Rzy

~~~text
X = sfx * (
      mx1
    + (Xb/2) * ((Ry - Ryix0)^2 + (Rz - Rzix0)^2)
    - (Xb0/2) * (Ryix0^2 + Rzix0^2)
    + (Kx/2) * (Ry^2 + Rz^2)
    - ee * (Rz + Rx*Ry)
    + ax*Ry )

Y = sfy * (
      my1
    + (Yb/2) * ((Rx - Rxiy0)^2 + (Rz - Rziy0)^2)
    - (Yb0/2) * (Rxiy0^2 + Rziy0^2)
    + (Ly/2) * (Rx^2 + Rz^2)
    + dd * (Rz + Rx*Ry)
    - ay*Rx
    - sxy*X )

Rzx = mx2/(4*cx) - Rx*Ry
      - ((Xb*Ry - X*Ryix0)*dRyixh + (Xb*Rz - X*Rzix0)*dRzixh)/(4*cx)
      + ux*Ry

Rzy = my2/(4*cy)
      - ((Yb*Rx - Y*Rxiy0)*dRxiyh + (Yb*Rz - Y*Rziy0)*dRziyh)/(4*cy)
      + wy*Rx
~~~

XY 余弦修正中的常数减项用于扣除束线平均偏斜在零位的贡献。`Rzx` 和 `Rzy` 的上排差分方向误差分别对应 X1/X2、Y1/Y2。`ee、dd` 的项式沿用附件的定义，带符号常数须依据目标机的偏置坐标录入。 [参数释义](ifm_model.md#ifm-constants)

<a name="corr-tilt"></a>

## Ryx 与 Rx

~~~text
Ryx = (mx1 - x3)/dzx
      - ((Xb*Ry - X*Ryix0)*dRyixv + (Xb*Rz - X*Rzix0)*dRzixv)/dzx
      + (-yx3/dzx + vx)*(Rz + Rx*Ry)
      - (X/dzx)*c_X

Rx = -(my1 - y3)/dzy
     - ((Yb*Rx - Y*Rxiy0)*dRxiyv + (Yb*Rz - Y*Rziy0)*dRziyv)/dzy
     + (-xy3/dzy + vy)*Rz
     - (Y/dzy)*c_Y
~~~

第一项是上排均值与第三束的垂向测角。第二项补偿随气隙变化的上下排方向差。第三项扣除第三束的有向横偏引入的偏航，名义偏置和安装失准可合为一个标定系数。末项用于零倾角、大行程下的余弦差。用 `theta_Rx`、`theta_Ryx` 整体拟合时，常数直接按相应特征顺序使用。 [标定特征与顺序](ifm_model.md#ifm-solver)

<a name="corr-z"></a>

## Z 与 Ryz

~~~text
Z = sfz * (
      mz1 + czxrz*X*Rx*Rz
    + szya*Y + szxa*X
    + ezxa*Rx + ezya*Ry + ezza*Rz
    + czxya*X*Ry + czxza*X*Rz + czyya*Y*Ry + czxxa*X*Rx
    + dzyya*Ry^2 + dzzza*Rz^2 + dzxxa*Rx^2 + dzxza*Rx*Rz )

Ryz = sfryz * (
        (mz2/kze)*(1 - 2*Z/kze)
      + (2/kze)*X*Rx^2 + (4/kze)*X*Ry^2
      + srxa*X + srya*Y + srza*Z
      + erxa*Rx + erza*Rz
      + crxxa*X*Rx + crxya*X*Ry + crxza*X*Rz
      + drxxa*Rx^2 + drxza*Rx*Rz + dryya*Ry^2 )
~~~

`czxrz` 保留为受光路拓扑影响的标定系数。本机当前单程折返几何拟合约为 3.00137。`kze=465 mm` 是 v7 的输入几何臂，零位的 Z 净差分灵敏度约为 554 mm，v7 用 `sfryz≈0.839318` 补偿零位增益。高度工作区扩大时应复核两者在同一读数口径下的对应。 [高度外推和有效臂](ifm_model.md#ifm-validation)

<a name="corr-runtime"></a>

## 附件 v7 实现范围

| 模块 | v7 实际计算 | C3 说明所列接口 |
| --- | --- | --- |
| X、Y 主平移 | 包含平均束线偏斜、零位扣除、死程余弦和 Abbe 项。 | `sfx/sfy、ee、dd、sxy` 可随有向标定进入完整式。 |
| Rzx、Rzy | `Rzx=mx2/(4*cx)-Rx*Ryx`，`Rzy=my2/(4*cy)`。 | 上排非平行和不等高补偿可在取得该类参数后启用。 |
| Rx、Ryx | 两个五特征标定向量，随 XY 和姿态迭代。 | 对应上列四组物理项，差分增益也参与拟合。 |
| Z、Ryz | 先以 `Ryx` 求 Z，再以已求 Z 和 `Ryx` 算 Ryz。 | 手稿说明还提到 Ryz 用于 Z 子模型，具体实机接入取决于既有控制接口。 |
| 侧镜铅垂倾斜 | 当前 v7 解算未启用。 | 手稿可选扩展为 X 括号内 `-sxz*Z`、Y 括号内 `-syz*Z`，以实测斜率启用。 |

[完整技术说明](ifm_model.md) · [FreeCAD 工况与解算](WS-IFM%E9%99%84%E4%BB%B6C3-FreeCAD%E9%AA%8C%E8%AF%81_v1.md#attached-c3-method)
