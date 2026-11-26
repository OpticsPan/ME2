# 2026-11-26　WTAF 十个倾转系数的选择与验证

- 新增 WTAF 第 4 章审阅草稿 v2。按现行 IFM 两个 XY 解算方程逐列选出四条有效臂、四个有效入射偏角和两个跨轴响应。图 4.5 展示两块 TIS 的倾转斜率如何求出十个系数。[参数表](../outputs/reports/MEtrology-WTAF整理草稿_v2.md#wtaf-model-constants) · [两点解算图](../outputs/reports/MEtrology-WTAF整理草稿_v2.md#two-point-solution)
- 逐页对照 WTAF、WGTD 及相邻校准项目。说明归零、角尺、板位和焦高等独立参考的作用，以及不同机械误差投到同一模型列时的处置。[项目分工](../outputs/reports/MEtrology-WTAF整理草稿_v2.md#project-map) · [原页依据](../outputs/reports/WTAF-参数辨识与校准项目资料核查_v1.md#evidence)
- MATLAB R2024b 使用 v9 原始八路追迹与五轮解算，在未参与拟合的两处标记和新转角上比较八项、十项更新。另外按单因素追迹核对八个几何输入及侧镜倾角的符号。[复验与十项结果](../outputs/reports/MEtrology-WTAF整理草稿_v2.md#full-replay) · [MATLAB 脚本](../outputs/code/wtaf_ifm_replay_v1.m) · [逐项数值](../outputs/data/wtaf_ifm_replay_v1.json) · [单因素脚本](../outputs/code/wtaf_upper_beam_signs_v1.py)

[仓库首页](../README.md#更新历史) · [成果索引](../outputs/README.md)
