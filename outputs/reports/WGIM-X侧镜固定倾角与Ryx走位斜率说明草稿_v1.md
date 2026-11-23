# WGIM 图 3.6 答疑草稿 v1　固定侧镜倾角会使 Ryx 随 X 增长吗？

[纯平移的光程](#translation) · [闭环读数与实际运动](#feedback) · [对照图 3.6](MEtrology-WGIM-WTAF整理草稿_v10.md#wgim-x-path-difference)

**按图 3.6 的几何，固定安装倾角只产生固定的上下束光程差。WS 保持姿态沿 X 平移时，X 组解算出的俯仰增量为零。** 此处讨论绕 Y 的俯仰 Ry。Ryx 表示从 X 组三束得到的 Ry；仓库模型中 Rx 由 Y 组解算。[模型表 3](ifm_model.md#ifm-table-3)

<a name="translation"></a>

## 纯平移时两排光束各变化多少？

在机架上取同一个 X 参考面。设上排 X1、X2 的平均单程几何距离为 $L_u$，下束 X3 的单程几何距离为 $L_3$。起点 A 的台体水平，平面侧镜与 Z 轴夹角为 $\alpha$，两排平行光束的垂直间距为 $d_{zx}$。WS 沿 +X 走过 $\Delta X$ 到 B，期间保持姿态。按图示入射方向，有

| 同一机架参考面 | 起点 A | 终点 B | 从 A 到 B 的增量 |
| --- | --- | --- | --- |
| 上排平均距离 | $L_u(A)$ | $L_u(A)+\Delta X$ | $\Delta X$ |
| 下束距离 | $L_3(A)$ | $L_3(A)+\Delta X$ | $\Delta X$ |
| 上排减下排 | $d_{zx}\tan\alpha$ | $d_{zx}\tan\alpha$ | $0$ |

如果直接用起点的几何程差除以束距，会得到 $\tan\alpha$，小角度下约为 $\alpha$。IFM 从各路参考相位测位移变化。以 A 为零、两排比例相同时，上排平均位移 $m_u$ 和下束位移 $m_3$ 都等于 $\Delta X$，所以 $\Delta R_{yx}\simeq(m_u-m_3)/d_{zx}=0$。即使保留角度零偏，它也只改变读数的起点。[图 3.6（1）的红段](MEtrology-WGIM-WTAF整理草稿_v10.md#wgim-upper-lower-range) · [IFM 净读数定义](ifm_model.md#ifm-readout)

<a name="feedback"></a>

## 哪种情况下会出现斜率？

举例让下束对同一段 X 行程多读一个固定比例 $\varepsilon>0$。台体真实俯仰保持不变时，上排读 $m_u=\Delta X$，下束读 $m_3=(1+\varepsilon)\Delta X$。此时多读量随行程累积，未经补偿的 X 组读出 $\Delta R_{yx}\simeq-\varepsilon\Delta X/d_{zx}$。图 3.6（2）右下角单独引入了这个条件。左上和右上则给定了 WS 在走位中真实转动；那两幅图演示三束如何测到这个转动。[子图（2）](../images/WGIM-X三束光程差与俯仰局部_v1.png)

若改用上述有比例误差的 Ryx **闭环锁定零增量**，并假设理想跟踪，控制器会让 WS 真实转动，直至反馈读数回到设定值。按小角度一阶叠加，有

$$
\Delta R_{yx}^{\rm fb}
 \simeq \Delta R_y^{\rm true}-\frac{\varepsilon\,\Delta X}{d_{zx}}
 \simeq 0,\qquad
\Delta R_y^{\rm true}\simeq\frac{\varepsilon\,\Delta X}{d_{zx}}.
$$

这个闭环例子中，随行程增长的是实际台体相对机架的俯仰，受控的 Ryx 反馈读数保持在设定值附近。若只有固定侧镜倾角，则上式中 $\varepsilon=0$，闭环也无需施加随行程增长的角度修正。

**WGIM 如何使用这个区分？** L3-《12-TT-L3-L3-ME_book.pdf》文件第 31–32 页（印刷第 23–24 页）把系统误差较小的 Ryx 作为参照。第 32 页图 2.12 底部的短线表示 Z 组测得的 Ryz；当两面固定 Z 镜的坡度不同时，两路 Z 测高之差随 X 改变。WGIM 据此校正 Ryz 相对 Ryx 的一阶位置依赖。[Level 3 原图与页码](WGIM资料汇整_v1.md#source-figures) · [相关校准项 srxa](WGIM资料汇整_v1.md#constants)
