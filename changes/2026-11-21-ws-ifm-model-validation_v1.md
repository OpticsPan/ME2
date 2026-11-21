# WS-IFM 原式核查与几何修正

日期 2026-11-21

- 发布 [撤下记录](2026-11-21-ifm-model-consolidation_v1.md#retired-ifm)。依据原 FreeCAD 布局和约定的读数方向，建立 X/Y/Z 的一阶、差分和有限姿态反解，核对 Z 高度相关灵敏度与混合项。
- 原生 FreeCAD 复核几何与镜面命中，MATLAB 计算理想光路并按有限镜面口径检查单轴和 192 组组合位姿。实机控制器字段与系数按目标机型的数据另行核对。
- [ifm_raw 原始模型](../outputs/reports/ifm_raw.md) 保留作原式对照。更新 [成果索引](../outputs/README.md) 和 [首页更新历史](../README.md#更新历史)。
