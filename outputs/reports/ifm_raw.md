# ifm_raw 晶圆台干涉仪原始模型

[XY 原式](#xy-ifm-原式) · [Z 原式](#z-ifm-原式) · [原件字段](#raw-fields) · [技术文档](ifm_model.md) · [修正模型](ifm_corr.md)

`ifm_raw` 对应原 `ifm-C0`，来源为《ifm模型.docx》。本页按文件第 1 页和第 4 页转录六条原方程，统一显式乘号和平方记号，保留原符号、下标、运算括号和项数。原件在本机 `参考文献/ifm模型.docx`，SHA-256 为 `506566cb2f79d46bddb0ed4fda19fb5a7876571760c22f6dfd41257789081fb5`。第 2–4 页给出 XY 原始参数表，第 5 页给出 Z 输入定义。

## XY IFM 原式

~~~text
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
~~~

`mx1、my1` 分别为 X、Y 上两束的光程均值，`mx2、my2` 分别是各上束对的光程差。原件第 1 页未指定差分方向。本机 `ifm_corr` 的差序和坐标另见 [读数与坐标](ifm_corr.md#corr-input)。

## Z IFM 原式

~~~text
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
~~~

`mz1` 是 Z1/Z2 的平均，`mz2` 是其差，`kze` 为两路测量的有效臂。原件第 4 页说明生产 Ry 控制由 X 路 `Ryx` 提供，并提到 `Ryz` 用于 Z 子模型。六式未给出独立的 `Rx`、`Ryx` 公式或 `Ryz` 到 Z 式的具体接入。 [当前实现](ifm_corr.md#corr-runtime)

<a name="raw-fields"></a>

## 原件字段与转录定位

| 原件写法 | 页码和含义 |
| --- | --- |
| `Kx、Ly` | 第 2 页。后角锥到工位参考点的水平距离。原表指出 E 侧为镜头中心，M 侧为 ATHENA 位置。 |
| `kx、ly` | 第 2 页。X 台体尺寸、Y 镜至 WS 坐标原点水平距离的两倍。 |
| `ax、ay、cx、cy` | 第 2–3 页。焦面到 X/Y 上束的垂直阿贝臂，各组水平束间距的四分之一。 |
| `ay*Ry` | 第 1 页公式。第 2 页参数表把 `ay` 的作用写为 `Y(Rx)`。 |
| `ee、dd` | 第 1、3 页。式中分别用于 X 和 Y，参数表的作用列存在异文。 |
| `Rzxix0、dRzxixh` | 第 3 页参数表。第 1 页相应公式写 `Rzix0、dRzixh`。同页表格中的部分效应和束号与公式有差异。 |
| `Xb/4*cx、Yb/4*cy` | 第 1 页原括号写法。附件未给 `Xb、Yb` 的单独定义。 |
| `sfz、sfryz` | 第 4 页分别外乘 Z 与 Ryz。第 5 页只列 Z 输入定义，Ryz 的绝对尺度和系数量纲需要对应的实机接口。 |

[阅读相关公式变更](ifm_model.md#ifm-differences) · [机器常数和原页出处](ifm_model.md#ifm-constants)
