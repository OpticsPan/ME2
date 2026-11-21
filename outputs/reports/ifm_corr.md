# ifm_corr 晶圆台干涉仪修正模型

[坐标和八路读数](#corr-input) · [平移和偏航](#corr-xy) · [滚转和俯仰](#corr-tilt) · [Z 与 Ryz](#corr-z) · [代码和标定](#corr-runtime) · [原始参考 ifm_raw](ifm_raw.md) · [技术手稿](ifm_model.md)

`ifm_corr` 是仓库对 **C3 工程扩展版**的统一名称。以下方程按当前归档的 [MATLAB v9 仿真](../code/sim_ws_ifm_6dof_animation_v9.m) 记录，保留其计算顺序与标定向量顺序。原始 C0 手稿以 [ifm_raw](ifm_raw.md) 存档。附件中的原术语见 [v10 原稿](ifm_model.md#ifm-differences)。

<a name="corr-input"></a>

## 坐标与读数

长度单位 mm，角度单位 rad。`T=[X,Y,Z]^T` 为旋转前平移，世界坐标中的原点位移为 `R*T`。X/Y 读数头位于负 X、负 Y 侧。

~~~text
R = RotZ(Rz)*RotX(Rx)*RotY(Ry)
p_world = R*(p_local + T)

xi = delta_OPL_Xi/4
yi = delta_OPL_Yi/4
zi = (delta_OPL_Zi_Ref - delta_OPL_Zi_Fold)/2

mx1 = (x1+x2)/2     mx2 = x1-x2
my1 = (y1+y2)/2     my2 = y2-y1
mz1 = (z1+z2)/2     mz2 = z1-z2

Xb0 = Kx-kx/2       Yb0 = Ly-ly/2
Xb  = X+Xb0         Yb  = Y+Yb0
~~~

输入为各通道扣零后的八路光程变化，主输出为 `(X,Y,Z,Rx,Ryx,Rzx)`，冗余输出为 `Ryz、Rzy`。`Ry、Rz` 的主估计分别取 `Ryx、Rzx`。几何、束号和标定字段见 [附件原稿](ifm_model.md#ifm-geometry)。

<a name="corr-xy"></a>

## 平移与偏航

下列方括号表示 MATLAB v9 的有序特征向量，乘相应的已标定列向量。迭代式中的 `a=Rx、b=Ryx、c=Rzx`，以本轮最新可用值计算。

~~~text
Xnl = mx1 + (Xb/2)*(b^2+c^2) + (Kx/2)*(b^2+c^2)
Ynl = my1 + (Yb/2)*(a^2+c^2) + (Ly/2)*(a^2+c^2)

Phi_Rzx = [mx2/(4*cx), b, a, -Xb*b/(4*cx), -Xb*c/(4*cx), -X/(4*cx)]
Phi_Rzy = [my2/(4*cy), a, b, -Yb*a/(4*cy), -Yb*c/(4*cy), -Y/(4*cy)]
Phi_X   = [Xnl, b, -(c+a*b), -Z, -Xb*b, -Xb*c, Y, a]
Phi_Y   = [Ynl, -a, c+a*b, -X, -Z, -Yb*a, -Yb*c, b]

Rzx = Phi_Rzx * th_Rzx - a*b
Rzy = Phi_Rzy * th_Rzy
X   = Phi_X   * th_X
Y   = Phi_Y   * th_Y
~~~

XY 特征含 `-Z` 以补偿侧镜铅垂微倾，另含位置正交和姿态串扰。两路偏航各含对方倾角、随气隙变化的束线方向误差与位置项，实际符号由标定向量决定。可对照手稿的 [工程扩展说明](ifm_model.md#ifm-extensions)。

<a name="corr-tilt"></a>

## 滚转与主俯仰

~~~text
Phi_Rx  = [-(my1-y3)/dzy, c, b, -Yb*a/dzy, -Yb*c/dzy, -Y/dzy]
Phi_Ryx = [ (mx1-x3)/dzx, c+a*b, a, -Xb*b/dzx, -Xb*c/dzx, -X/dzx]

Rx  = Phi_Rx  * th_Rx
Ryx = Phi_Ryx * th_Ryx
~~~

`dzy、dzx` 是上束至第三束的名义垂向基线。差分项提供主测角，后五项拟合横向偏置、交叉倾角及随气隙变化的上下排方向差。 [原稿中的标定说明](ifm_model.md#ifm-solver)

<a name="corr-z"></a>

## 高度与冗余俯仰

~~~text
Phi_Z   = [mz1, X*a*c, Y, X, a, b, c, X*b, X*c, Y*b, X*a, b^2, c^2, a^2, a*c]
Z       = Phi_Z * th_Z

lead    = (mz2/kze)*(1-2*Z/kze) + (2/kze)*X*a^2 + (4/kze)*X*b^2
Phi_Ryz = [lead, X, Y, Z, a, c, X*a, X*b, X*c, a^2, a*c, b^2]
Ryz     = Phi_Ryz * th_Ryz
~~~

`th_Z(2)/th_Z(1)` 对应折返系数 `czxrz`，由实际光路的标定决定。`kze=465 mm` 是 v9 使用的名义几何臂，读数口径及常数来源见 [机台常数](ifm_model.md#ifm-constants)。

<a name="corr-runtime"></a>

## 标定与运行

1. 默认 `all6` 注入六类装调误差。以 `rng(42)` 生成 300 个标定位姿，按特征顺序做最小二乘。X/Y、Z、Rx、Ryx、Rzy、Ryz 都以相应真值标定，Rzx 的标定目标为 `Rz+Rx*Ry`，在线式中再扣除 `Rx*Ryx`。
2. 每个采样先由均值、差分初始化 X/Y/Z 和角度，再按 `Rzx、Rzy、Rx、Ryx、X、Y、Z` 顺序更新五轮。每轮开始用当前 X、Y 算气隙。Z 随迭代更新，供下一轮 XY 的 `-Z` 项使用。最后用已解 Z 和 `mz2` 求 Ryz。
3. 程序输出预设值、解算值和标定前后误差的扫描动画及曲线。`none`、`ifm_raw_scope` 和 `all6` 改变误差注入范围，解算始终采用 `ifm_corr`。

从仓库根目录运行：

~~~matlab
addpath('outputs/code')
sim_ws_ifm_6dof_animation_v9
~~~

也可显式运行 `sim_ws_ifm_6dof_animation_v9('ifm_corr','all6')`。本机 MATLAB R2024b 复算的默认 121 帧八路读数和八通道解算值，与原附件的工程扩展入口逐元素一致。FreeCAD 的既有报告对应 v7 历史工况。 [v7 历史验证](WS-IFM%E9%99%84%E4%BB%B6C3-FreeCAD%E9%AA%8C%E8%AF%81_v1.md#attached-c3-method)
