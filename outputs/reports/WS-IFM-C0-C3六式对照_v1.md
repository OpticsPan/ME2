# WS-IFM C0 与 C3 六条公式对照 v1

[完整公式](#c0-c3-formulas) · [待确认项的使用条件](#c0-c3-conditions) · [逐项依据和 FreeCAD 数据](WS-IFM-C0-%E5%85%AC%E5%BC%8F%E7%AC%A6%E5%8F%B7%E4%B8%8E%E4%B8%8B%E6%A0%87%E6%A0%B8%E5%AF%B9_v1.md#c0-check-freecad) · [成果索引](../README.md)

<a name="c0-c3-formulas"></a>

## C0 原式与 C3 校核式

本文采用本次命名，**C3 指从 C0 保留项数得到的六条校核式**。沿用主动旋转、列向量和 `R = RotZ(Rz) * RotX(Rx) * RotY(Ry)`。左列为《ifm模型.docx》第 1、4 页的公式，统一了乘号和平方的写法。右列粗体式子是校核后改动，**待确认**紧跟对应项或系数。计数按最外层加减项，外乘尺度和括号内分量随原项计。六式合计 **47 项**。 [C0 原文与参数](WS-IFM%E6%A8%A1%E5%9E%8B_v1.md#xy-ifm-原式) · [47 项校核依据](WS-IFM-C0-%E5%85%AC%E5%BC%8F%E7%AC%A6%E5%8F%B7%E4%B8%8E%E4%B8%8B%E6%A0%87%E6%A0%B8%E5%AF%B9_v1.md#c0-sign-result)

| 解算式 | 原项数 | C0 原式 | C3 校核式 |
| --- | ---: | --- | --- |
| **X** | 5 | `X = sfx * (` `mx1`<br>`+ [(X + Kx - kx/2)/2] * [(Ry - Ryix0)^2 + (Rz - Rzix0)^2]`<br>`+ Kx*(Ry^2 + Rz^2)/2`<br>`- ee*(Rz + Rx*Ry)`<br>`- ax*Ry` `)` | `X = sfx * (` `mx1`<br>`+ [(X + Kx - kx/2)/2] * [(Ry - Ryix0)^2 + (Rz - Rzix0)^2]` 〔**待确认** 距离端点与符号〕<br>`+ Kx*(Ry^2 + Rz^2)/2` 〔**待确认** 与上一项的距离分解〕<br>**`+ ee*(Rz + Rx*Ry)`** 〔**待确认** 实机偏置正向〕<br>**`+ ax*Ry`** `)` |
| **Y** | 6 | `Y = sfy * (` `my1`<br>`+ [(Y - Ly + ly/2)/2] * [(Rx - Rxiy0)^2 + (Rz - Rziy0)^2]`<br>`- Ly*(Ry^2 + Rz^2)/2`<br>`+ dd*(Rz + Rx*Ry)`<br>`+ ay*Ry`<br>`- sxy*X` `)` | `Y = sfy * (` `my1`<br>`+ [(Y - Ly + ly/2)/2] * [(Rx - Rxiy0)^2 + (Rz - Rziy0)^2]` 〔**待确认** 距离端点与符号〕<br>**`- Ly*(Rx^2 + Rz^2)/2`** 〔**待确认** Ly 前的号〕<br>**`- dd*Rz`** 〔**待确认** 实机偏置正向〕<br>**`- ay*Rx`**<br>`- sxy*X` 〔**待确认** sxy 有向定义与作用点〕 `)` |
| **Rzx** | 4 | `Rzx = ` `mx2/(4*cx)` `- Rx*Ry`<br>`- (Xb/4*cx) * [(Ry-Ryix0)*dRyixh + (Rz-Rzix0)*dRzixh]`<br>`+ ux*Ry` | `Rzx = ` `mx2/(4*cx)` `- Rx*Ry`<br>**`- (Xb/(4*cx)) * [(Ry-Ryix0)*dRyixh + (Rz-Rzix0)*dRzixh]`** 〔**待确认** 距离端点和方向差定义〕<br>`+ ux*Ry` 〔**待确认** ux 的正向〕 |
| **Rzy** | 3 | `Rzy = ` `my2/(4*cy)`<br>`- (Yb/4*cy) * [(Rx-Rxiy0)*dRxiyh + (Rz-Rziy0)*dRziyh]`<br>`+ wy*Rx` | `Rzy = ` `my2/(4*cy)`<br>**`- (Yb/(4*cy)) * [(Rx-Rxiy0)*dRxiyh + (Rz-Rziy0)*dRziyh]`** 〔**待确认** 距离端点和方向差定义〕<br>`+ wy*Rx` 〔**待确认** wy 的正向〕 |
| **Z** | 15 | `Z = sfz * (` `mz1` `+ X*Rx*Rz`<br>`+ szya*Y` `+ szxa*X`<br>`+ ezxa*Rx`<br>`+ ezya*Ry`<br>`+ ezza*Rz`<br>`+ czxya*X*Ry`<br>`+ czxza*X*Rz`<br>`+ czyya*Y*Ry`<br>`+ czxxa*X*Rx`<br>`+ dzyya*Ry^2`<br>`+ dzzza*Rz^2` `+ dzxxa*Rx^2` `+ dzxza*Rx*Rz` `)` | `Z = sfz * (` `mz1` **`- X*Rx*Rz`**<br>`+ szya*Y` `+ szxa*X`<br>`+ ezxa*Rx`<br>`+ ezya*Ry` 〔**待确认** Ry 接入〕<br>`+ ezza*Rz`<br>`+ czxya*X*Ry` 〔**待确认** Ry 接入〕<br>`+ czxza*X*Rz`<br>`+ czyya*Y*Ry` 〔**待确认** Ry 接入〕<br>`+ czxxa*X*Rx`<br>`+ dzyya*Ry^2` 〔**待确认** Ry 接入〕<br>`+ dzzza*Rz^2` `+ dzxxa*Rx^2` `+ dzxza*Rx*Rz` `)` |
| **Ryz** | 14 | `Ryz = sfryz * (` `mz2*((1 - 2*Z/kze)/kze)^2`<br>`+ (2/kze)*X*Rx^2`<br>`+ (4/kze)*X*Ry^2`<br>`+ srxa*X` `+ srya*Y`<br>`+ srza*Z`<br>`+ erxa*Rx` `+ erza*Rz`<br>`+ crxxa*X*Rx` `+ crxya*X*Ry`<br>`+ crxza*X*Rz`<br>`+ drxxa*Rx^2` `+ drxza*Rx*Rz`<br>`+ dryya*Ry` `)` | `Ryz = sfryz * (` **`mz2/(kze + 2*Z)`** 〔**待确认** sfryz 量纲与倍率〕<br>**`- (1/kze)*X*Rx^2`**<br>**`- (3/kze)*X*Ry^2`**<br>`+ srxa*X` `+ srya*Y` 〔**待确认** 实机字段〕<br>`+ srza*Z` 〔**待确认** 实机字段及有向定义〕<br>`+ erxa*Rx` 〔**待确认** 实机有向系数〕 `+ erza*Rz` 〔**待确认** 实机有向系数〕<br>`+ crxxa*X*Rx` 〔**待确认** 实机有向系数〕 `+ crxya*X*Ry` 〔**待确认** 实机有向系数〕<br>`+ crxza*X*Rz` 〔**待确认** 实机有向系数〕<br>`+ drxxa*Rx^2` 〔**待确认** 实机有向系数〕 `+ drxza*Rx*Rz` 〔**待确认** 实机有向系数〕<br>`+ dryya*Ry` 〔**待确认** Ry 或 Ry^2〕 `)` |

<a name="c0-c3-conditions"></a>

## 待确认项的使用条件

- **XY 余弦项。** FreeCAD 验证了 X/Y 两组余弦项的合量。单项距离基准仍需原机资料。Y 中 `Ly` 项已确定用 `Rx^2`，`-Ly` 暂按 C0。 `dd、ee` 的公式符号采用光头坐标减参考点坐标的有向定义，`sxy` 的减号对应输入尚未做非正交补偿的读数。 [X 和 Y 的逐项证据](WS-IFM-C0-%E5%85%AC%E5%BC%8F%E7%AC%A6%E5%8F%B7%E4%B8%8E%E4%B8%8B%E6%A0%87%E6%A0%B8%E5%AF%B9_v1.md#c0-check-x)
- **两路偏航。** `Xb/(4*cx)` 和 `Yb/(4*cy)` 分别按 `Xb、Yb` 是光程长度给出。束线方向差应与 `x1-x2`、`y2-y1` 的上束差序一致。原件参数表涉及 X3/Y3 的文字待与目标机字段定义核对。 [差分及失配符号](WS-IFM-C0-%E5%85%AC%E5%BC%8F%E7%AC%A6%E5%8F%B7%E4%B8%8E%E4%B8%8B%E6%A0%87%E6%A0%B8%E5%AF%B9_v1.md#c0-check-rzx)
- **Z 与 Ryz。** C0 第 4 页说明 Z 子模型使用 `Ryz`，表内保留 `Ry` 写法并标出涉及入口的四个位置。具体接入以实机接口为准。Ryz 式中的补偿角 `Ry` 可以由独立的 X 路 `Ryx` 提供。`dryya*Ry` 按原文一次项列出，幂次待确认。 `sfryz` 数值迁移需核对量纲和倍率。 [Z 字段](WS-IFM-C0-%E5%85%AC%E5%BC%8F%E7%AC%A6%E5%8F%B7%E4%B8%8E%E4%B8%8B%E6%A0%87%E6%A0%B8%E5%AF%B9_v1.md#c0-check-z) · [Ryz 字段与幂次](WS-IFM-C0-%E5%85%AC%E5%BC%8F%E7%AC%A6%E5%8F%B7%E4%B8%8E%E4%B8%8B%E6%A0%87%E6%A0%B8%E5%AF%B9_v1.md#c0-check-ryz)

原件给出上述六条式子，`Rx` 和 `Ryx` 只有输入或通道说明。这组六式的修正针对已查明的符号、下标和增益。名义 FreeCAD 的部分混合光程响应在这 47 项之外，例如 Z 中的 `Y*Rx`。历史 C3 推导采用另一姿态约定，保留其独立的历史记录。 [混合工况证据](WS-IFM-C0-%E5%85%AC%E5%BC%8F%E7%AC%A6%E5%8F%B7%E4%B8%8E%E4%B8%8B%E6%A0%87%E6%A0%B8%E5%AF%B9_v1.md#c0-check-freecad) · [历史 C3 的模型约定](WS-IFM-C3%E6%A8%A1%E5%9E%8B%E4%B8%8E%E6%A0%87%E5%AE%9A%E6%A0%B8%E5%AF%B9_v1.md#c3-convention)
