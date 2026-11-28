# 2026-11-28 梳理 ELLA、ELGE 与测量侧四步基准链（BMAA → ELLA → WZTD → ELGE）审阅稿

> 产出方：Gemini ｜ 日期：2026-11-28 ｜ 版本：v1

## 变更摘要

1. **完成 ELLA 与 ELGE 的 Level 1–3 全量通读与独立汇整**：
   - 通读并检索本机只读资料区全部 103 份文档，重点核对 `L3-《07-TT-L3-LS-2v0.pdf》` 第 32–49 页、`L3-《12-TT-L3-L3-ME_book.pdf》` 第 15、37–45、53–61 页及 `L3-《TT-MA-ME_setupblock_1-5_1v3.ppt》` 第 62–83 张。
   - 渲染并核对原 PDF 页面（`LS_2v0` 第 35–38、46–49 页），补正 OCR 漏读的 `ELLA.21` 报表底部两行（`Trap 2` 因 `RESIDU_SLOPE_UP_OUT_OF_SPEC` 被剔除，最终由 `Trap 1` 与 `Trap 3` 平均得 `LS-AA (X/Y) = 545.161 / -77.440 µm`），并指明原书图 4.5 与 PPT 第 42 张将 `µm` 误印为 `mm`。
   - 新建 [ELLA-ELGE资料汇整_Gemini_v1.md](../outputs/reports/ELLA-ELGE资料汇整_Gemini_v1.md) 并完成全文回读。
2. **撰写第 8 章待审草稿并绘制 6 幅配图与排版公式图**：
   - 遵循「修改先提交草稿审阅」及公式显示规范（正文零原始 `$...$` 源码），新建 [MEtrology-ELLA-ELGE与测量侧Z一致性整理草稿_Gemini_v1.md](../outputs/reports/MEtrology-ELLA-ELGE与测量侧Z一致性整理草稿_Gemini_v1.md#ella-elge-chain)，暂未并入 [MEtrology.md](../outputs/reports/MEtrology.md)。
   - 完整梳理 `ELLA`（梯形工具片四方位交叉相减与 25%–75% 斜坡中点定位）与 `ELGE`（`±200 µrad` 倾转定 XY、`15×15` 十字同点测高定 Z 及全项残差复验），并以同机实机数据（Machine 3909，Rel 3.3.8：`19:43 ELLA.21 → WZTD → 21:16 ELGE.08`）闭环串联 `BMAA → ELLA → WZTD → ELGE` 四步基准链与 Block 2–4 中间铺垫（`WZIM/WGIM → CABF/WTAF → ELLN → BMWL`）。
   - 生成并视觉验收 3 幅原理/实机图与 3 幅排版公式图：
     - [图 8.1 ELLA 工具片与四方位标定原理](../outputs/images/ELLA-梯形工具片与四方位标定原理_Gemini_v1.png)
     - [图 8.2 ELGE 九光斑倾转标定与实机数据](../outputs/images/ELGE-九光斑倾转标定与实机数据_Gemini_v1.png)
     - [图 8.3 BMAA–ELLA–WZTD–ELGE 全链路逻辑](../outputs/images/测量侧Z一致性-BMAA-ELLA-WZTD-ELGE全链路逻辑_Gemini_v1.png)
     - [式 8.1 ELLA 交叉相减与梯形中点](../outputs/images/ELLA-公式8.1-交叉相减与梯形中点_Gemini_v1.png)
     - [式 8.2 ELGE 光斑倾转测位与同点定高](../outputs/images/ELGE-公式8.2-光斑倾转测位_Gemini_v1.png)
     - [式 8.3 测量侧全链路高度合成](../outputs/images/测量侧Z一致性-公式8.3-全链路高度合成_Gemini_v1.png)
3. **同步更新仓库首页与成果索引**：
   - 更新 [README.md](../README.md#更新历史) 与 [outputs/README.md](../outputs/README.md)，按规范标注产出方 `Gemini`。

## 相关链接

- 待审草稿：[MEtrology-ELLA-ELGE与测量侧Z一致性整理草稿_Gemini_v1.md](../outputs/reports/MEtrology-ELLA-ELGE与测量侧Z一致性整理草稿_Gemini_v1.md#ella-elge-chain)
- 资料汇整：[ELLA-ELGE资料汇整_Gemini_v1.md](../outputs/reports/ELLA-ELGE资料汇整_Gemini_v1.md)
- 前序相关草稿：[MEtrology-WZTD整理草稿_Gemini_v1.md](../outputs/reports/MEtrology-WZTD整理草稿_Gemini_v1.md#wztd)
- 成果索引：[outputs/README.md](../outputs/README.md)
- 首页更新历史：[README.md](../README.md#更新历史)
