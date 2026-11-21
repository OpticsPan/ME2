# WS-IFM C0 在 ZXY 转序下的核对 v1

[判断范围](#c0-zxy-conventions) · [转角差分](#c0-zxy-yaw) · [单轴 FreeCAD 反例](#c0-zxy-abbe) · [Ryz 高度增益](#c0-zxy-ryz) · [成果索引](../README.md)

**将转序设为 ZXY 后，C0 的名义偏航补偿在一种矩阵定义下成立到二阶。整套 C0 仍无法按原文直接用于当前 WS-IFM 布局。** 早期 FreeCAD 验证采用的矩阵恰为 `Rz·Rx·Ry`，在这个定义下已经用单轴工况发现 X、Y 的一阶 Abbe 不匹配。单轴工况下旋转顺序不影响结果。 [既有 FreeCAD 结论](WS-IFM%E5%8E%9F%E5%A7%8Bv1%E4%B8%80%E9%98%B6FreeCAD%E9%AA%8C%E8%AF%81_v1.md#first-order-result)

<a name="c0-zxy-conventions"></a>

## 两种 ZXY 约定

统一采用右手系、主动旋转和列向量。`a=Rx、b=Ry、c=Rz`。

| ZXY 的含义 | 代入光路的矩阵 | 固定轴的实际施加顺序 |
| --- | --- | --- |
| 矩阵乘积按书写顺序为 Z、X、Y | `R = RotZ(c) * RotX(a) * RotY(b)` | Y → X → Z。早期 FreeCAD/v2 使用这个定义。 |
| 按时间先绕固定 Z，再绕固定 X，再绕固定 Y | `R = RotY(b) * RotX(a) * RotZ(c)` | Z → X → Y。 |

数值部分沿用早期 FreeCAD 的等效单程读数、束号和全局平移参考。后来的 MATLAB v5/v6 和 C3 使用另一姿态约定。本报告以名义几何核对 C0 的转序一致性，实机的完整机器常数和读数定义仍需按目标版本确认。 [早期 FreeCAD 坐标和读数](WS-IFM%E6%A8%A1%E5%9E%8B_v2.md#坐标与观测量) · [MATLAB/C3 约定](WS-IFM-C3%E6%A8%A1%E5%9E%8B%E4%B8%8E%E6%A0%87%E5%AE%9A%E6%A0%B8%E5%AF%B9_v1.md#c3-convention)

<a name="c0-zxy-yaw"></a>

## 转序会改变两路偏航修正

沿用 ME2 差序，记 `uX=(x1-x2)/(4*cx)`、`uY=(y2-y1)/(4*cy)`。`vX、vY` 是扣除第三束横偏后归一化的上下束差。通过镜面法向投影得到下表。角度保留至二阶，安装误差及校准残差取名义零值。

| 矩阵 | `uX` | `uY` | `vX` | `vY` |
| --- | --- | --- | --- | --- |
| `RotZ * RotX * RotY` | `c + a*b` | `c` | `-b` | `a` |
| `RotY * RotX * RotZ` | `c` | `c - a*b` | `-b + a*c` | `a + b*c` |

验证时对候选矩阵进行符号相乘。名义 v5 光程的四个量可写为 `R11*R21、-R22*R12、R11*R31、R22*R32`，对角投影因子到一阶等于 1，因此表中二阶项也适用早期的名义单程差分。当采用前一种矩阵时，C0 的 `Rzx=uX-Rx*Ry`、`Rzy=uY` 均可恢复预设偏航至二阶。采用后一种矩阵时，二阶应该取 `Rzx=uX`、`Rzy=uY+Rx*Ry`。若实际使用后一种矩阵却直接代入 C0，在 `Rx=Ry=0.5 mrad、Rz=0` 工况，两路解算的偏航都会约为 `-0.25 µrad`。这项共同偏差在 `Rzx-Rzy` 中抵消。 [C0 偏航原式](WS-IFM%E6%A8%A1%E5%9E%8B_v1.md#xy-ifm-原式) · [既有转序证据](WS-IFM%E5%85%AB%E8%BD%B4%E8%A7%A3%E7%AE%97%E5%85%AC%E5%BC%80%E8%B5%84%E6%96%99%E8%B0%83%E7%A0%94_v2.md#rotation-order)

<a name="c0-zxy-abbe"></a>

## X/Y 单轴反例与转序无关

《ifm模型.docx》第 1 页对 X 写 `-ax*Ry`、对 Y 写 `+ay*Ry`。原件第 2 页表 1 则定义 `ay` 为 Y 上束到对准焦平面的垂直距离，作用栏为 `Y(Rx)`。同样的三个单轴结论可用既有 FreeCAD 数据直接核对。该数据使用名义正臂长 `ax=43.5 mm`、`ay=32.5 mm`，台体平移均预设为零。

| 工况 | 既有 FreeCAD 名义读数的一阶响应 | 代入 C0 一阶式的表观平移 |
| --- | --- | --- |
| 纯 `Ry=+1 µrad`，检查 X | X 上束均值变化约 `-43.5 nm`，X 反解需加 `ax*Ry`。 | C0 再减 `ax*Ry`，得到 `X=-87 nm`。 |
| 纯 `Rx=+1 µrad`，检查 Y | Y 上束均值变化约 `+32.5 nm`，Y 反解需减 `ay*Rx`。 | C0 的 `+ay*Ry` 在这组工况为零，得到 `Y=+32.5 nm`。 |
| 纯 `Ry=+1 µrad`，检查 Y | Y 上束均值的一阶 Ry 响应为零。 | C0 的 `+ay*Ry` 产生 `Y=+32.5 nm`。 |

每次只转一根轴，其余旋转矩阵为单位矩阵，换转序不会改变这些响应。实际装载到其他机型时，以有向读数及转心确定 Abbe 项的正负。C0 的 Y 式和参数表对 `ay` 所乘角度的差异需要保留并核对。C0 仍缺独立的 `Rx`、`Ryx` 方程。 [原始单轴读数和斜率](WS-IFM%E5%8E%9F%E5%A7%8Bv1%E4%B8%80%E9%98%B6FreeCAD%E9%AA%8C%E8%AF%81_v1.md#zero-pose-slopes) · [C0 公式与符号冲突](WS-IFM%E6%A8%A1%E5%9E%8B_v1.md#原件差异与实现边界)

<a name="c0-zxy-ryz"></a>

## Ryz 的高度增益仍需核对

《ifm模型.docx》第 4 页的 `Ryz` 主项为 `sfryz * mz2 * ((1 - 2*Z/kze)/kze)^2`。第 5 页只定义了光程差和有效臂。在当前 mm 读数约定下，主项尺度需与原机 `sfryz` 的量纲一起核对。

复用既有 FreeCAD 的 `X=Y=Rx=Rz=0、Ry=800 µrad` 三组 Z 高度工况。固定 `kze=554 mm`，仅为隔离高度响应令 `sfryz` 的数值等于 `kze`，使零位主项的数值增益归一。表内把预设 Z 代入 C0 字面平方，保留名义无安装残差设置。

| 预设 Z（mm） | FreeCAD 的 `mz2`（mm，显示值） | C0 主项复算（µrad，零位数值归一） | 对预设 Ry 的误差（µrad） |
| ---: | ---: | ---: | ---: |
| −5 | 0.435199796 | 814.175 | +14.175 |
| 0 | 0.443199790 | 800.000 | −0.0004 |
| +5 | 0.451199784 | 785.303 | −14.697 |

名义几何在这些工况下的有效臂约为 `kze + 2*Z`，因此局部测角比例近似 `1/(kze+2*Z)`。按 C0 字面平方并只调整总比例，会留下随高度变化的增益残差。这里始终只有 Ry 旋转，这个校核与组合转序无关。C0 中 `Z` 通道的安装及混合项仍应沿各自读数、转心和机器常数核对。 [早期 FreeCAD 的八路光程](WS-IFM%E5%8E%9F%E5%A7%8Bv1%E4%B8%80%E9%98%B6FreeCAD%E9%AA%8C%E8%AF%81_v1.md#eight-readouts) · [名义 Z 有效臂测试](WS-IFM%E9%99%84%E4%BB%B6%E5%85%AC%E5%BC%8FFreeCAD%E9%AA%8C%E8%AF%81_v1.md#z-arm-test)
