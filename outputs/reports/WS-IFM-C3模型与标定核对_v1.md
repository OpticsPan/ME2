# WS-IFM-C3 模型、Rx 推导与机器常数核对 v1

[模型约定](#c3-convention) · [Rx 与 Ryx 并排推导](#rx-derivation) · [装调误差与机器常数](#c3-calibration) · [八个输出](#c3-equations) · [验证结果](#c3-validation) · [原页索引](#source-pages) · [成果索引](../README.md)

**C3 用当前光路的几何反解处理名义耦合，同时保留 C0 的装调误差、尺度、面形与姿态拟合项。** 在当前转序下，Rx 和 Ryx 的主项分别取 Y、X 上下束差，二阶项分别为 $-Ryx\,Rz$ 和 $+Rx\,Rz$。绝对 Abbe 臂 $a_y$ 补偿 Y 平移，Y3 与上束的高度差 $h_Y$ 决定 Rx 的测角比例。已用 121 帧 MATLAB、136 组 FreeCAD 名义光程和 16 组带已知误差的合成光程复算。实机常数的取值、坐标映射和部分 C0 字段的用法仍需由目标卡盘及工位的报表和原始观测落实。[三版公式来源](WS-IFM-C0-C1-C2%E5%85%AC%E5%BC%8F%E4%BF%AE%E6%AD%A3%E8%BF%87%E7%A8%8B_v1.md#equation-comparison) · [WS-IFM 校准项目](WS-IFM%E6%9C%BA%E5%99%A8%E5%B8%B8%E6%95%B0%E6%A0%A1%E5%87%86%E9%A1%B9%E7%9B%AE_v1.md#core-calibrations)

<a name="c3-convention"></a>

## 模型约定

- C0 为《ifm模型.docx》第 1–5 页。原件给出 X、Y、Rzx、Rzy、Z、Ryz，定义式中的机器常数，也说明生产中的 Ry 控制使用 X-IFM 的 Ryx。当前附件缺 Rx 和 Ryx 的独立解算式。Level 3 图 1.60、1.61 及同页正文明确指出 Y 上两束测 Y/Rz、Y3 补充测 Rx，X 三束按同样布局测 X/Rz/Ry。 [C0 原式与光路图](WS-IFM%E6%A8%A1%E5%9E%8B_v1.md#光路与输入输出) · [源页定位](#source-pages)
- 数值复验沿用 MATLAB v5/v6 的 $R=R_x(a)R_y(b)R_z(c)$、$p_\mathrm{world}=R(p_\mathrm{local}+T)$，其中 $a=Rx$、$b=Ryx$、$c$ 为用于姿态变换的 Rz，$T=(X,Y,Z)^\mathsf T$。XY 六路以各自扣零后的总光程除以 4，Z 两路以折返束减直返束、扣零后取负并除以 2。长度用 mm，角度用 rad。该坐标与计数约定决定下文的符号。[MATLAB 转序与光程协议](WS-IFM-C0-C1%20MATLAB%E4%BB%BF%E7%9C%9F%E6%8A%A5%E5%91%8A_v1.md#c1-diagnosis)
- C3 的参考几何记为 $F_0$。它显式计算名义光路，也可装入端点、轴向和符号已确认的几何常数。标定的装调偏差在校准后的几何追迹 $F_\mathrm{inst}$ 中使用。余下系统误差按 C0 参数的物理含义拟合给定。一个效应计入几何后，该效应的经验系数要以同一几何为基线重算。

<a name="rx-derivation"></a>

## Rx 与 Ryx 并排推导

以上两束的等效角锥坐标均值为参照。定义 $B_X=4c_x=y^{H}_{X2}-y^{H}_{X1}$、$B_Y=4c_y=x^{H}_{Y2}-x^{H}_{Y1}$，$h_X,h_Y$ 是上束均值到第三束的正高度差，$\delta y_X,\delta x_Y$ 是第三束相对上束均值的有符号横向偏移。上标 $H$ 指等效光头位置。先写上束等高、平行入射的参考模型，$x_i,y_i$ 为扣零、归一化并移除已知装调误差后的读数。

|  | X 束组推 Ryx | Y 束组推 Rx |
| --- | --- | --- |
| C0 的上束组合 | $mx1=(x_1+x_2)/2,\quad mx2=x_1-x_2$ | $my1=(y_1+y_2)/2,\quad my2=y_2-y_1$ |
| 上束差 | $u_X=mx2/B_X$ | $u_Y=my2/B_Y$ |
| 去掉下束横偏引入的偏航投影 | $v_X=(x_3-mx1+\delta y_Xu_X)/h_X$ | $v_Y=(y_3-my1-\delta x_Yu_Y)/h_Y$ |
| 名义二阶反解 | $Ryx=v_{Y}u_Y-v_X+O(\lVert\theta\rVert^3)$ | $Rx=v_Y+v_Xu_Y+O(\lVert\theta\rVert^3)$ |
| 用物理角度展开二阶项 | $Ryx=-v_X+Rx\,Rz+O(\lVert\theta\rVert^3)$ | $Rx=v_Y-Ryx\,Rz+O(\lVert\theta\rVert^3)$ |

**几何起点。** 对理想平行束，四段总长除以 4 为 $(n\!\cdot\!d)[n\!\cdot\!(P-H)]$，其中 $P$ 为台镜面上一点，$H$ 为等效角锥点。X 侧取 $d=e_X$，Y 侧取 $d=e_Y$。同一面上的两束相减，$P$ 项消掉，仅保留光头的相对位置投影。沿用此计数约定，X 侧差分的顺序是 1−2，Y 侧是 2−1。设 $s_X=n_{X,x}$、$s_Y=n_{Y,y}$，直接得到

$$
 u_X=s_X n_{X,y},\quad v_X=s_X n_{X,z},\qquad
 u_Y=-s_Y n_{Y,x},\quad v_Y=s_Y n_{Y,z}.
$$

因此 $u_X,u_Y$ 是参与差分的光学投影。它们在一阶才等于偏航。把 $u_Y$ 在下束横偏项中直接替换为一个已做高阶修正的欧拉角，需要重新检查展开阶次。由 $R$ 写出投影并按 $\theta=(a,b,c)$ 展开得

$$
\begin{aligned}
 v_X&=\cos b\cos c(\sin a\sin c-\cos a\sin b\cos c)\\
    &=-b+ac+\tfrac23 b^3+\tfrac12 ba^2+bc^2+O(\lVert\theta\rVert^4),\\
 v_Y&=(\cos a\cos c-\sin a\sin b\sin c)(\sin a\cos c+\cos a\sin b\sin c)\\
    &=a+bc-\tfrac23 a^3-ac^2+O(\lVert\theta\rVert^4).
\end{aligned}
$$

这给出 C1 的具体改动。C1 在 $v_Y$ 后写 $+Ryx\cdot Rzy$，而 $v_Y$ 已含正的 $Ryx\,Rz$。在当前转序下，反解应减去这一项。C1 的 Rx 主残差因而约为 $2Ryx\,Rz$。当只有 Rx 时，$v_Y=\sin(Rx)\cos(Rx)$，也能单独检查三阶系数。

**有限姿态解。** 对 $j=X,Y$ 取 $s_j^2=[1+\sqrt{1-4(u_j^2+v_j^2)}]/2$ 的近零位分支。$n_X=(s_X,u_X/s_X,v_X/s_X)^\mathsf T$，$n_Y=(-u_Y/s_Y,s_Y,v_Y/s_Y)^\mathsf T$。向量 $n_X\times n_Y$ 沿台体 Z 轴。它的三个分量在共同正分母 $s_Xs_Y$ 下分别为 $C,-A,B$，其中

$$
 A=s_X^2v_Y+v_Xu_Y,\qquad
 B=s_X^2s_Y^2+u_Xu_Y,\qquad
 C=u_Xv_Y-s_Y^2v_X .
$$

$$
 \boxed{Rx=\operatorname{atan2}(A,B)},\qquad
 \boxed{Ryx=\operatorname{atan2}\!\left(C,\sqrt{A^2+B^2}\right)} .
$$

在镜面法向和回程几何均已校正的工作分支内，这两式保留全部名义姿态耦合，不需要预先知道真实 Ry。根号内为负、法向接近共线或光路离开有效反射面时，应判定输入或当前模型超出工作域。

**Abbe 项的位置。** 旋转造成的 Y 向一阶位移为 $-z\,Rx+x\,Rz$。上束在 $z=-a_y$，故其归一化均值含 $+a_y Rx$ 响应。Y 反解所扣的精确 Abbe 项是 $-a_y n_{Y,z}$。若以同一焦平面表示第三束高度为 $-a_{y3}$，三束中的共同 Abbe 响应在差分中消掉，留下 $(a_{y3}-a_y)Rx=h_Y Rx$。X 侧同理。若三束的等效高度、入射方向或反射面存在差异，未消掉的差分直接进入 Rx，见[标定后的差分式](#c3-calibration)。

<a name="c3-calibration"></a>

## 装调误差与机器常数

### 上束不等高及单束误差怎么进入 Rx

以 Y 侧为例，令 $\Delta z_Y=z^H_{Y2}-z^H_{Y1}$。$E_{21}$ 和 $E_{3u}$ 是读数中额外加上的差分误差，分别对应 Y2−Y1，及 Y3−上束均值，单位为 mm。对共用镜面、同向发射的参考模型，有

$$
 \begin{aligned}
 my2-E_{21} &= B_Yu_Y-\Delta z_Yv_Y,\\
 y_3-my1-E_{3u} &=\delta x_Yu_Y+h_Yv_Y .
 \end{aligned}
$$

$$
 \boxed{v_Y=
 \frac{y_3-my1-E_{3u}-(\delta x_Y/B_Y)(my2-E_{21})}
 {h_Y+(\delta x_Y/B_Y)\Delta z_Y}},\qquad
 u_Y=\frac{my2-E_{21}+\Delta z_Yv_Y}{B_Y}.
$$

X 侧用 $\Delta z_X=z^H_{X2}-z^H_{X1}$。扣除本侧差分误差以后，$mx2=B_Xu_X+\Delta z_Xv_X$，$x_3-mx1=-\delta y_Xu_X+h_Xv_X$，同样解二元方程。若用 C3 的逐束校准计算扣除了相同的高度失配，参考几何中的 $\Delta z$ 取参考布局的值。近零位、上束等高时，漏掉的 Y 差分误差约引入 $\Delta Rx=[E_{3u}-(\delta x_Y/B_Y)E_{21}]/h_Y$。因此上束偏航通道校准也会影响 Rx，影响大小与 Y3 横偏有关。

C0 把 Y 上束的垂向失配写作 $+wy\cdot Rx$ 进入 Rzy。仅存在上束有效高度差、且与本文差序和角度定义一致时，上式给出等效系数 $\Delta z_Y/B_Y$。实机的 `wy` 是否包含其他光学效应，需要 WGIM 的通道拟合记录确认。C0 表把 `dRxiyh、dRziyh` 定义为 Y3 相对 Y 束平均方向的偏差，但公式将它们放在 Rzy，表的效应栏又写 Rzx。X 的对应 `dRyixh、dRzixh` 也有 X3 与上束差分的归属疑点。C3 按光路及报表确认后的束号建立 $E_{3u}$ 或 $E_{21}$，同一偏差不在两处重复施加。

### 镜面倾斜、光束不平行和面形

按束计算

$$
 m_i^\star=m_i-E_i(q),\qquad
 E_i(q)=F_{\mathrm{inst},i}(q)-F_{0,i}(q)+E_{i,\mathrm{res}}(q),
 \qquad q=(X,Y,Z,Rx,Ryx,Rz).
$$

$F_\mathrm{inst}$ 和 $F_0$ 使用相同的扣零基准、束号和光程倍率。可用装调数据将台镜安装法向写成 $R(q)n_i^\mathrm{body}$，将固定 Z 镜安装法向放在计量框架坐标里，给每束指定光头、方向和回程参考面。局部面形测定值以镜面图或相应的差分残差接口接入。对 X/Y 的两次反射加理想角锥回程，如果角锥中心为 $H_i$、固定回程参考面单位法向为 $e_i$、出射单位向量为 $d_i$，逐段相交并扣零后有

$$
 F_i(q)=
 \frac{\big[(e_i\!\cdot n_i)\,\big(n_i\!\cdot(P_i-H_i)\big)\big]_q
       -\big[(e_i\!\cdot n_i)\,\big(n_i\!\cdot(P_i-H_i)\big)\big]_0}{e_i\!\cdot d_i}.
$$

推导时设出射点为 $S_i$，第一段长为 $g=[n_i\cdot(P_i-S_i)]/(n_i\cdot d_i)$。绕角锥中心点反射后，回到镜面的两段合长为 $2[n_i\cdot(P_i-H_i)]/(n_i\cdot d_i)$。最后沿 $-d_i$ 与参考面求交。总长相加时，含 $1/(n_i\cdot d_i)$ 的段长相消，留下上式的投影和一个与位姿无关的常数。扣零移除该常数。

当回程参考面与出射线正交，$e_i=d_i$，即回到前面的投影形式。若实机光学拓扑不同，按对应的回返路径做 $F_i$，或由实测标定残差定义 $E_i$。本次合成验证对非平行光束采用了每束垂直于其出射线的回程参考面。Z 两路用折返和直返各自的镜面追迹。

### C0 常数对接

| C0 常数或项 | Level 1–3 证据 | C3 中的接入位置及约束 |
| --- | --- | --- |
| `ax、ay、cx、cy` | WTAF 标定 M 侧 XY 对倾角的依赖。WGTD 表 2.2 明确列四个字段，`ax/ay` 到 TIS 焦平面。Level 1 的 ATM 流程也单独校准 Abbe 臂。 | `ax/ay` 用于 X/Y 均值的 Abbe 补偿。`cx/cy` 以四倍值作为上束水平基线。按 AA、TIS 或模型原点的实际端点换算。 |
| `Kx、Ly、kx、ly、dd、ee` | C0 定义角锥距离和台镜尺寸。WGTD 列 `K/L` 及 `dd/ee`，原表中 `dd` 是 Y-IFM 的 X 向位置误差，`ee` 是 X-IFM 的 Y 向位置误差。 | 用在光头、反射面及参考点坐标。确认偏置方向和工位基准后再映射。$\delta x_Y,\delta y_X$ 是第三束相对上束的偏移，需从第三束几何获得。 |
| `Ryix0、Rzix0、Rxiy0、Rziy0` | WGTD 表 2.2 四项束线方向误差，图 2.86 以 µrad 报告。C0 平移式也含其与姿态的差。 | 确认定义后作束组方向分量，也可在同一坐标下拟合方向误差残差。只有组平均时，仍需逐束差量才能区分上束与第三束。C0 距离乘角差平方中的名义角度项已由几何处理。 |
| `ux、wy、Xb、Yb、dRyixh、dRzixh、dRxiyh、dRziyh` | C0 第 1、3 页给出相应项及定义。WGIM 图 2.9–2.12 显示上束不等高和基于 X/Y 冗余偏航的校准。当前报表未确认这些全部键名、`Xb/Yb` 的两个端点及各 `d*` 束号。 | 已量得束位/束向则进入 $F_\mathrm{inst}$，其余进入对应通道的拟合差量。确认 `Xb/Yb` 是长度时，C0 的比例块按 `Xb/(4cx)、Yb/(4cy)` 才无量纲。 |
| $h_X,h_Y$、$\delta y_X,\delta x_Y$、$\Delta z_X,\Delta z_Y$ | 当前几何提供名义值。WGIM 证明存在束高失配及串扰。WGTD 的 23 项表未列各第三束相对位置。 | 输入第三束装调几何或实测有效臂。单轴正负倾转可区分测角比例和零偏。用实测正负偏航与正负倾转配合，确认横偏和高度串扰。 |
| `sfx、sfy、sxy` | C0 给出尺度及非正交。BMWZ、GRMO 涉及尺度和 XY 非正交，报表作用点须和软件版本对照。 | 输出尺度及坐标校正，位置方程保留 `−sxy·X` 的接口。若同一尺度或坐标旋转已应用于输入读数或参考系，再按剩余误差标定输出。 |
| `szxa、szya、sfz` | WZIM 报告 XTZ/YTZ 斜率，`szya` 在同一卡盘跨侧沿用。BMWZ 建立 E 侧初始高度/倾斜。Level 3 课件注明 `sfz` 由 TRIM 确定。 | 同基准的 Z 斜率及尺度进入 Z。若固定 Z 镜实测倾斜已入追迹，斜率使用扣除该贡献后的量。 |
| `ezxa、ezya、ezza、czxxa、czxya、czxza、czyya、dzxxa、dzyya、dzzza、dzxza` | E 侧 WGTD 表 2.2 逐项列出定义。M 侧 WZTD 校准 Z 倾转点与倾斜依赖，现有资料未列 M 侧全部键名。 | 保留原特征基底，按几何扣除后剩余的高度误差拟合。报表的 `ez*` 为 µm、`cz*` 为 mrad、`dz*` 为 mm。 |
| `kze、sfryz、srxa、srya、srza、erxa、erza、crxxa、crxya、crxza、drxxa、drxza、dryya` | WGIM 明确校准 Ryx/Ryz 间偏差，资料明确识别 `srxa`。其余完整写入表及 `sfryz` 的量纲待核。C0 原件写 `dryya·Ry`。 | `kze` 通过 Z 差分对 Ry 的局部增益核对。其余保留为 Ryz 的角度修正。`dryya` 保留线性，需和总角度增益分离辨识。原件的差分项含倒臂平方，若读数为长度则其结果为倒长度。本版以同单位的差分光程反解角度，旧 `sfryz` 数值的迁移需要核查。 |

WGTD 表中的示例是 rel.3.4.0 E 侧 Chuck 1 的拟合结果，图 2.85 显示 `Machine Constants: Not Saved`。实际装载需要同一卡盘、同一 M/E 工位、同一归零和符号下的保存值。如果旧常数是**总系数**，只有能把新几何的贡献投影到相同的自变量、单位和坐标时，才可计算两者之差。比如旧版和新基线若都按同一 $Rx\,Rz$ 特征表述 Ryz，总 `drxza` 要先扣掉该基线同特征的贡献。基底或姿态定义发生变化时，用原校准工况对 C3 的残差重新拟合。[WGTD 报表及原页](WS-IFM%E6%9C%BA%E5%99%A8%E5%B8%B8%E6%95%B0%E6%A0%A1%E5%87%86%E9%A1%B9%E7%9B%AE_v1.md#wgtd-fields) · [其余项目及字段证据](WS-IFM%E6%9C%BA%E5%99%A8%E5%B8%B8%E6%95%B0%E6%A0%A1%E5%87%86%E9%A1%B9%E7%9B%AE_v1.md#parameter-evidence)

<a name="c3-equations"></a>

## C3 的八个输出

用 $m_i^\star$ 重新组合 $mx1^\star,mx2^\star,my1^\star,my2^\star,mz1^\star,mz2^\star$。后两个分别为 $(z_1^\star+z_2^\star)/2$ 和 $z_1^\star-z_2^\star$。对 X/Y 用[差分反解](#rx-derivation)得到 $s_X,s_Y,n_X,n_Y,a,b$。设 $U=R_y(-b)R_x(-a)$，$w_X=Un_X,w_Y=Un_Y$。$L_{X0},L_{Y0}$ 为正向参考光程在零位的四分之一值。$\bar y_X$ 是上两条 X 束的平均 Y 坐标，$\bar x_Y$ 是上两条 Y 束的平均 X 坐标。

$$
\begin{aligned}
 X_g&=\frac{mx1^\star+L_{X0}}{s_X}+\frac{k_x}{2}-K_xs_X+\bar y_X n_{X,y}-a_x n_{X,z},\\
 Y_g&=\frac{my1^\star+L_{Y0}}{s_Y}+\frac{\ell_y}{2}-L_y s_Y+\bar x_Y n_{Y,x}-a_y n_{Y,z}.
\end{aligned}
$$

这两个式子显式处理死程、偏心和 Abbe 误差。对当前转序，X 的 Abbe 补偿到二阶为 $+a_x b-a_x ac$，Y 为 $-a_y a-a_y bc$。相对 C0 第 1 页，当前几何把 Y 补偿的主角从 `Ry` 改为 `Rx`，与 C0 第 2 页 `ay` 的作用栏相符。死程和偏心使用变换后的实际投影。C0 的 `X·Rx·Rz` 正项也见于 Level 3 课件的 Z 模型，当前 v5 转序和 Z 回程应通过逐段几何计算，历史式的符号只能在同一坐标约定下比较。

定义 $G_1(z)$ 为参考几何在 $(X,Y,z,a,b,c)$ 下预测的 Z 均值，$G_2(\vartheta)$ 为在 $(X,Y,Z,a,\vartheta,c)$ 下预测的 Z 差分。对折返束及直返束的每一段，起点 $S$、方向 $d$、平面点 $P$、法向 $n$ 给出有向长度 $t=(P-S)\cdot n/(d\cdot n)$，然后用 $S+td$ 和 $d-2(d\cdot n)n$ 更新。相同行程应用相同扣零及计数倍率。固定角度时，$G_1(z)$ 对 $z$ 为仿射函数，取 $\gamma_Z=[G_1(1\,\mathrm{mm})-G_1(0)]/(1\,\mathrm{mm})$。设 $Z_g=[mz1^\star-G_1(0)]/\gamma_Z$。$\vartheta_g$ 是 $G_2(\vartheta)=mz2^\star$ 在近零分支的根。$\partial G_2/\partial\vartheta$ 有效地给出当前工作点的角度测量臂，零位与 `kze` 对照。该写法同时包含 C0 Ryz 的名义位置、姿态耦合和有效臂随高度变化，免去直接迁移 C0 的平方归一化。

| 输出 | C3 公式 |
| --- | --- |
| X | $X=sfx\cdot X_g$ |
| Y | $Y=sfy\cdot(Y_g-sxy\,X)$ |
| Rx | $Rx=\operatorname{atan2}(A,B)$ |
| Ryx | $Ryx=\operatorname{atan2}(C,\sqrt{A^2+B^2})$ |
| Rzx | $Rzx=\operatorname{atan2}(w_{X,y},w_{X,x})$ |
| Rzy | $Rzy=\operatorname{atan2}(-w_{Y,x},w_{Y,y})$ |
| Z | $Z=sfz\cdot[Z_g+P_Z(X,Y,a,b_Z,c)]$ |
| Ryz | $Ryz=s_\vartheta\cdot[\vartheta_g+P_\vartheta(X,Y,Z,a,b,c)]$ |

$Rz=c$ 沿用 v5/v6 的取法，以 Rzx 驱动姿态变换，以 Y 镜面法向分别求 Rzy 供比较。两路偏航使用共同的倾角解，保留各自镜面的误差信息。Ryx 来自六路 X/Y，Ryz 由 Z1/Z2 差分取得。在名义 Z 几何中使用主角 $b=Ryx$，Z 的 C0 兼容余项可将原通道 Ryz 用作 $b_Z$。此时 Z 和 Ryz 联立迭代，仍保留 Z 差分提供的独立观测。$s_\vartheta$ 是同单位下的无量纲角度增益，由 `sfryz` 的定义核对后换算或重新标定。$sfz,sfx,sfy$ 必须和实际读数的倍率相容。

用带波浪号的 C0 符号表示相对于 C3 基线的残差系数，逐项保留原有物理特征。

$$
\begin{aligned}
P_Z={}&\widetilde{szxa}X+\widetilde{szya}Y
 +\widetilde{ezxa}a+\widetilde{ezya}b_Z+\widetilde{ezza}c\\
 &+\widetilde{czxxa}Xa+\widetilde{czxya}Xb_Z+\widetilde{czxza}Xc+\widetilde{czyya}Yb_Z\\
 &+\widetilde{dzxxa}a^2+\widetilde{dzyya}b_Z^2+\widetilde{dzzza}c^2+\widetilde{dzxza}ac ,\\[4pt]
P_\vartheta={}&\widetilde{srxa}X+\widetilde{srya}Y+\widetilde{srza}Z
 +\widetilde{erxa}a+\widetilde{erza}c\\
 &+\widetilde{crxxa}Xa+\widetilde{crxya}Xb+\widetilde{crxza}Xc
 +\widetilde{drxxa}a^2+\widetilde{drxza}ac+\widetilde{dryya}b .
\end{aligned}
$$

$P_Z$ 的输出是 mm，$P_\vartheta$ 的输出是 rad。这里按 C0 原件使用 `dryya·Ry`。如目标软件报表确认实际用的是另一项，应按该版本参数定义更新特征及单位。Rzx/Rzy 中随位置和倾转的校准，以及 Rx/Ryx 的逐束装调校正，均可通过 $E_i$ 施加到所属读数。已在 $E_i$ 扣除的 Z 误差应相应从 $P_Z,P_\vartheta$ 的拟合目标中去掉。

一次求解先取 $E_i=0$ 得到近零分支初值，再按上一轮位姿更新 $E_i(q)$、八个输出及必要的 $b_Z$。在测量域内检查求交有效、$B_X,B_Y,h_X,h_Y$ 对应的差分矩阵可逆、$\gamma_Z$ 非零、$G_2$ 在近零分支有唯一根。停止以读数回代和位姿增量收敛为准。对装调较大或初值不稳的机台，应在已知工作分支上求同一组方程的残差并检查局部秩。实际标定保留 `Rzx−Rzy`、`Ryx−Ryz` 的残差随位置与倾角的曲线，避免把两组独立通道的信息在求解前合并。

<a name="c3-validation"></a>

## 验证结果

### Rx 和 Ryx 复算

使用现成的扣零八路光程和预设姿态逐组算角。名义几何取 $4c_x=210$、$4c_y=180$、$h_X=55$、$h_Y=68$、$\delta y_X=-20$、$\delta x_Y=15$，单位 mm。这里只在复算时使用这些尺寸。两组数据中角度的最大幅度约为 Rx 0.8 mrad、Ry 1.0 mrad、Rz 0.9 mrad。表中为相对预设的最大绝对误差，单位 µrad。[121 帧数据](../data/WS-IFM-C0-C1%E4%BB%BF%E7%9C%9F%E6%95%B0%E6%8D%AE_v1.csv) · [136 组 FreeCAD 数据的生成方式](WS-IFM-C0-C1%20MATLAB%E4%BB%BF%E7%9C%9F%E6%8A%A5%E5%91%8A_v1.md#independent-validation)

| 数据 | C1 Rx / Ryx | C3 名义一阶 Rx / Ryx | C3 名义二阶 Rx / Ryx | C3 有限姿态 Rx / Ryx |
| --- | ---: | ---: | ---: | ---: |
| MATLAB 121 帧 | 1.80047 / 0.68961 | 0.90020 / 0.46730 | 0.000341 / 0.000971 | 1.95×10⁻⁹ / 2.59×10⁻⁹ |
| FreeCAD 136 组 | 1.80189 / 1.01270 | 0.90099 / 0.72180 | 0.000342 / 0.000988 | 2.30×10⁻⁹ / 3.41×10⁻⁹ |

C0 缺少 Rx 和 Ryx 原式，故此表从 C1 开始对比。若需要核对 C0 已给出的其余六式，可跳至[原式、仿真条件和逐通道结果](WS-IFM-C0-C1%20MATLAB%E4%BB%BF%E7%9C%9F%E6%8A%A5%E5%91%8A_v1.md#c0-source)。

### 八通道与装调误差测试

独立 Python 复算用原始 MATLAB 和 FreeCAD 读数检查八个输出。另建 16 组带非零误差的合成工况，在 X/Y 逐束设入射角及位置偏差、台镜法向误差，在两个固定 Z 镜设不同的安装倾角，并加入部分 C0 形式的非零 Z/Ryz 残差。误差量级为十至数百 µrad 的光束及镜面倾角，以及十分之一 mm 量级的光头位置偏差。测试使用施加的实测量替代值作为已知输入，逐段相交追迹产生待解读数，C3 用闭式 XY 光程及分支反解恢复。XY 闭式与逐段追迹的最大差为 $7.60\times10^{-13}$ mm。

| 光程数据 | 最大 XYZ 误差（nm） | 最大角度误差（µrad） |
| --- | ---: | ---: |
| MATLAB 名义光程，C3 | 5.01×10⁻⁷ | 2.59×10⁻⁹ |
| FreeCAD 名义光程，C3 | 3.85×10⁻⁷ | 3.41×10⁻⁹ |
| 16 组合成装调误差，只用名义几何 | 1.374×10⁴ | 32.984 |
| 同一合成读数，C3 带已知装调量和残差 | 5.83×10⁻⁷ | 3.24×10⁻⁹ |

合成组单独给 $mz2$ 加 10 nm、保持均值，Ryz 变化 0.01804 µrad，Rx、Ryx、Rzx、Rzy 在数值精度内保持不变，Z 经 $b_Z$ 的补偿变化约 −0.000054 nm。上束高度差也单独注入验证，按二元差分式修正后恢复原解。两份本机复算脚本位于 `work/ws-ifm-rx-derivation-v1/verify_rx_v1.py`、`work/ws-ifm-rx-derivation-v1/verify_c3_v1.py`，沿用此前实验的 `work/ws-ifm-matlab-simulation-v1/validated_simulation_v1.mat`。

**验证范围。** 结果确认当前布局的几何解和这些已知误差的接入方式。带误差数据验证的是前向、反向一致性，使用的是合成装调量。实机验证需要同一卡盘、同一工位的已保存常数和原始测校观测，并核对未辨明的束号、方向、倍率及系数来源。分离纯倾转与位置扫描能核对 Abbe 臂、上/下束测角增益、Rz 串扰和 Z 有效臂。沿用校准网格的组合倾角作独立验算，可检查两组冗余残差和外部位置、姿态参考误差。

<a name="source-pages"></a>

## 原件及原图定位

| 原件 | 文件页和原图 | 用于本次推导的证据 |
| --- | --- | --- |
| `ifm模型.docx` | 第 1–5 页，按 Word 分页。第 2–4 页表 1。 | 第 1 页的四条 XY 原式、第 2 页上束均值/差分及 `ay` 的 `Y(Rx)`、第 3 页束向误差的归属疑点、第 4–5 页 Z/Ryz 原式及 `mz1/mz2` 定义。 |
| `13_AP-L1-ME_rel_3.2.pdf` | 第 29 页（幻灯片 29）的 Advanced alignment 流程图。 | 原图显示 ATM 对位、Abbe 臂校准、AA 焦面和 WS XY IFMs 校准在同一迭代流程中。 |
| `TT-L2-WS-3v0.pdf` | 第 27 页（印刷 21），图 1.30。 | 图中 X、Y 组指向移动镜块，Z 组另有折返路径。同一晶圆台的线束需按光路类型分别建模。 |
| `TT-L2-ME-3v0.pdf` | 第 58 页（印刷 52），WS Tilt Rotation Interferometer Matrix。 | 正文明确写 X 三束测 X、Rz、Ry，Y 三束测 Y、Rz、Rx。TRIM 以两条 Rz 和两条 Ry 的冗余辨认误差，并给出网格和组合倾角的采样方式。 |
| `09-TT-L3-WSbook.pdf` | 第 58 页（印刷 50），图 1.60、1.61。 | E、M 光路均显示台体镜面和各束的相对位置。正文明确写下束 Y3 测 Rx，X 的三束布局相同。图能确认上下束关系，尺寸来自当前模型或实测。 |
| `12-TT-L3-L3-ME_book.pdf` | 第 27–29 页（印刷 19–21）图 2.5–2.7；第 30–32 页（印刷 22–24）图 2.9–2.12；第 44 页（印刷 36）；第 57 页（印刷 49）；第 91–92 页（印刷 83–84）图 2.85–2.86、表 2.2。 | WZIM 的高度/行走校准、WGIM 的失配轴与冗余残差、WTAF 对倾角的 XY 标定、TRIM 的 `srxa`，以及 E 侧 WGTD 的候选常数和量纲。图 2.9–2.10 对照上束不等高造成的测角轴倾斜，图 2.11 显示平移导致的表观偏航，图 2.12 显示固定镜不平行造成的 Ryz 随 X 变化。 |
| `TT-MA-ME_setupblock_6-8_1v3.ppt` | 第 35 张备注。 | 明写 Z 的几何耦合和拟合项，并记载已由初始 Z 倾斜校准取得 `szxa/szya`、由 TRIM 取得 `sfz`。 |

以上原件从 ME2 本机的 `参考文献/` 下定位，PDF 文字复用了原页映射的 MinerU 转换。原图及原件保存在本机。[原页索引与定位路径](WS-IFM%E6%9C%BA%E5%99%A8%E5%B8%B8%E6%95%B0%E6%A0%A1%E5%87%86%E9%A1%B9%E7%9B%AE_v1.md#parameter-evidence) · [仓库光路示意图](../images/WS-IFM-CAD%E6%95%B0%E5%AD%A6%E6%A8%A1%E5%9E%8B%E5%9B%BE_v5.svg)
