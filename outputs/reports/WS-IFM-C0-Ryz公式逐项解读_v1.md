# WS-IFM C0 的 Ryz 原式逐项解读 v1

[原式](#c0-ryz-equation) · [逐项说明](#ryz-terms) · [共用量与校准](#ryz-shared-calibration) · [成果索引](../README.md)

C0 原件用 `Ryz` 表示 **Z1/Z2 光路对绕 Y 轴俯仰的读数**。同一物理角度还有 X-IFM 侧的 `Ryx`。原件第 4 页说明，生产以 `Ryx` 控制 Ry，`Ryz` 则提供给 Z 模型。当前 C0 原件列出了 `Ryz` 的方程，`Ryx` 的独立方程未附。 [C0 读数与控制通道](WS-IFM%E6%A8%A1%E5%9E%8B_v1.md#光路与输入输出)

<a name="c0-ryz-equation"></a>

## C0 原式

据《ifm模型.docx》第 4 页转录。乘法显示为 `*`，平方显示为 `^2`，保留原式的括号、系数和角度幂次。

```text
Ryz = sfryz * (
      mz2 * ((1 - 2*Z/kze)/kze)^2
    + (2/kze) * X * Rx^2
    + (4/kze) * X * Ry^2
    + srxa * X
    + srya * Y
    + srza * Z
    + erxa * Rx
    + erza * Rz
    + crxxa * X * Rx
    + crxya * X * Ry
    + crxza * X * Rz
    + drxxa * Rx^2
    + drxza * Rx * Rz
    + dryya * Ry
)
```

<a name="ryz-terms"></a>

## 逐项说明

C0 第 4–5 页描述的是对光束方向、反射镜安装、面形等多种误差的合成补偿。下表按各项乘的变量说明能补偿的误差形状。只有资料明确给出来源的项才归到具体校准。

| C0 项 | 对 Ryz 的作用 |
| --- | --- |
| `sfryz` | 乘整个括号的总比例系数。原件未注明其单位或实际数值。 |
| `mz2 * ((1 - 2*Z/kze)/kze)^2` | 测角主项。`mz2` 是 Z1/Z2 的光程差，`kze` 是两路 Z 测量的有效臂。括号表示原式让差分到角度的比例随高度 `Z` 变化。单位和倍率见下文。 |
| `(2/kze) * X * Rx^2` | X 位置与滚转平方的几何形式耦合。固定 X，正负同幅 Rx 的这一项相同。固定 Rx，其贡献随 X 线性变化。 |
| `(4/kze) * X * Ry^2` | X 位置与俯仰平方的耦合，表示 Ryz 对 Ry 的二阶响应随 X 位置改变。原件权重为 `4/kze`。 |
| `srxa * X` | 沿 X 扫描时的线性假俯仰。Level 3 的 TRIM 明确指出这是 X 对 Ryz 的贡献，图 2.12 示意计量框架 Z 镜不平行时的该现象。 |
| `srya * Y` | 沿 Y 扫描时的线性假俯仰，表示 Y 位置对 Ryz 的零姿态基准有贡献。 |
| `srza * Z` | 高度变化引起的附加线性假俯仰。即使 `mz2=0`，此项仍可存在。主项中的 `Z` 则改变光程差的换算比例。 |
| `erxa * Rx` | 一阶滚转串扰。施加 Rx 时，Z 两路差分可能读出额外的表观 Ry。该项随 Rx 反向。 |
| `erza * Rz` | 一阶偏航串扰。施加 Rz 时，Ryz 的偏差随 Rz 线性变化。 |
| `crxxa * X * Rx` | 滚转串扰的斜率随 X 改变。与 `erxa * Rx` 合看，零姿态附近对应的 Rx 线性系数为 `erxa + crxxa*X`。 |
| `crxya * X * Ry` | 俯仰线性校正随 X 改变，可看作位置相关的俯仰响应修正。 |
| `crxza * X * Rz` | 偏航串扰的斜率随 X 改变。与 `erza * Rz` 合看，对应的 Rz 线性系数为 `erza + crxza*X`。 |
| `drxxa * Rx^2` | 与 X 无关的滚转平方修正。与 `(2/kze)*X*Rx^2` 合看，整个 Rx 平方系数为 `drxxa + 2*X/kze`。 |
| `drxza * Rx * Rz` | 滚转和偏航的二阶交叉项。单独将任一角反号时该项反号，任一角为零时该项为零。 |
| `dryya * Ry` | 与 X 无关的 Ry 一阶修正。原件这里是一次 Ry。与 `crxya*X*Ry` 合看，对应系数为 `dryya + crxya*X`。 |

**首项的量纲需要单独核对。** C0 第 5 页只给了 `mz2` 和 `kze` 的物理定义。若两者都直接以 mm 代入，`Z=0` 时首项为 `mz2/kze^2`，量纲为 `1/mm`。它与式中 `(2*X/kze)*Rx^2` 的量纲无法直接相加。当前材料缺少机台内部的读数归一化、倍率和 `sfryz` 的定义，故原式照录。`mz2` 的相减顺序也须按对应机台通道定义核对。C3 使用 Z 差分光程及其对俯仰的局部灵敏度进行反解。 [C3 的 Z/Ryz 方程](WS-IFM-C3%E6%A8%A1%E5%9E%8B%E4%B8%8E%E6%A0%87%E5%AE%9A%E6%A0%B8%E5%AF%B9_v1.md#c3-equations)

<a name="ryz-shared-calibration"></a>

## 共用量与校准

- **整台模型共用的量**包括位置 `X、Y、Z` 和姿态 `Rx、Ry、Rz`。其中 `Ry` 在 C0 右边仍写作 `Ry`。原文说明生产中的主 Ry 来自 `Ryx`，但未给出这些右端项在软件中的具体输入和求解顺序。C3 的 Ryz 余项明确使用主角 `Ryx`，Z 部分保留使用 `Ryz` 的接口。 [C3 八个输出](WS-IFM-C3%E6%A8%A1%E5%9E%8B%E4%B8%8E%E6%A0%87%E5%AE%9A%E6%A0%B8%E5%AF%B9_v1.md#c3-equations)
- **Z 通道专用量**包括 `mz2、kze、sfryz` 和表中的 Ryz 校准系数。式中出现 `Rx` 表示用滚转姿态补偿 Z 通道里的串扰。C3 的 Rx 仍以 Y 三束的测角基线和 X/Y 镜面法向求解，用各自的通道参数。 [C3 的 Rx 推导](WS-IFM-C3%E6%A8%A1%E5%9E%8B%E4%B8%8E%E6%A0%87%E5%AE%9A%E6%A0%B8%E5%AF%B9_v1.md#rx-derivation)
- **WGIM / WS TRIM** 用 `Ryx` 作参考，拟合 `Ryz−Ryx` 随位置的一阶差异。图 2.12 的虚线标出不同 X 位置，下方斜线显示两固定镜不平行时的表观 Ryz。Level 3 第 57 页明确点名 `srxa`，其余各独立键名的写入项目和取值需要目标机台报表。图 2.13 还表明 TRIM 后仍可能有更高阶的 Z 残差。 [WGIM 校准条目](WS-IFM%E6%9C%BA%E5%99%A8%E5%B8%B8%E6%95%B0%E6%A0%A1%E5%87%86%E9%A1%B9%E7%9B%AE_v1.md#mc-wgim)

原页为《ifm模型.docx》第 4–5 页、《12-TT-L3-L3-ME_book.pdf》文件第 32 页（印刷第 24 页，图 2.12–2.13）、第 57 页（印刷第 49 页），以及《TT-L2-ME-3v0.pdf》文件第 58 页（印刷第 52 页）的 TRIM 测试说明。原件和原图保存在本机参考资料目录。
