# TWINSCAN 测校项目、机器常数与流程

资料范围为 ME2 本机 Level 1–3 培训资料。整机离线 Setup 以 rel.3.4 为主线，同时标出 rel.3.1/3.2 的不同项目及历史流程。子系统章节注明资料给出的机台、配置或版本。在线和生产内校正按各自的触发时机另列。

**快速跳转**  [整机 Setup](#整机-setup-顺序与图解) · [掩模台](#掩模台-rs) · [晶圆台](#晶圆台-ws) · [对准与光学](#高级对准图像传感器调平与照明投影) · [搬运与支撑](#晶圆搬运掩模搬运减振支撑与公用温控) · [系统集成](#系统集成成像平面和套刻) · [生产测校](#在线与生产内测校) · [维护](#维护辅助项目与适用范围) · [成果索引](../README.md)

## 阅读和引用

- 项目表中的 **MC** 表示校准会更新的机器常数。已知标识沿用原文拼写。资料只给出参数的物理含义或所属组件时，写明参数族或组件，具体键名标为资料未列。测试编号、工具、输入参考值及报告示例值均按其原用途标识。
- 照片、流程图和曲线用于核对实物位置、测试依赖与测量原理。引用按原文件名和从 1 开始的文件页码。PPT 引用为原幻灯片序号。原图定位是相对于 ME2 仓库根目录的本机路径，对应参考文献或 MinerU 提取图。
- Setup、生产补偿和资格验证的输出分别记录。培训资料能说明原理与流程，有些操作步骤、适用版本、验收阈值与故障分支需要查阅相应 Coach 或设备手册。
- 覆盖 Level 1 的术语、rel.3.2 流程和生产概念，Level 2 的模块原理、维护流程及生产参考，Level 3 的详细 Setup 工序、图表和分系统课件。检索范围覆盖 103 份索引文档。初筛命中的页段数为 Level 1 的 169、Level 2 的 478、Level 3 的 1,537，其中含版本、测试管理器与术语解释等背景。以综述、模块流程及图示交叉核对后整理条目。

## 整机 Setup 顺序与图解

rel.3.4 现场 Setup 定义为校准软件参数及所需硬件微调，在测量侧（M）和曝光侧（E）建立一致的测量与位置基准，并让设备具备进入验收的条件。测试覆盖 M/E 干涉仪、AA、LS、TIS、ILIAS，以及 WS/RS 的 fiducial 和坐标系。L3 把主线分为 WS、AA coarse、RS/RH、LS、IS/ILIAS coarse、Dynamics、AA/ILIAS/IS fine、ME fine 八块。分支内要按前后依赖执行，合流点要求输入分支完成。〔《TT-MA-ME-intro-1v2.ppt》第 6–13 张。《12-TT-L3-L3-ME_book.pdf》第 9–19 页〕

| 顺序 | 通过原图核对的依赖 | 出处 |
| --- | --- | --- |
| 上段 | Zero Sensor 后，一条支路做 BMAA coarse 与 fine，另一条做 WS M 侧初始高度与倾斜、TRIM 和 fiducial leveling。两路汇入 AA Beam Tilt & Focus，后续是 WS XY 干涉仪（M）与 BMAA fine。WS TRIM 后还分出照明 Spot Sensor Position、RS Rotation & Position Offset、RH Load Offset。 | 《TT-MA-ME-intro-1v2.ppt》第 11 张。《12-TT-L3-L3-ME_book.pdf》第 14–15 页 |
| 中段 | 左侧先得到曝光侧 WS 初始高度与倾斜，再走 RS scale map/scan tilt、RSIHT、ILIAS、BMAA fine、BMTIS fine。右侧从 WS TRIM 转进 LS 线性化、BMWL coarse/fine、LS–AA offset、M 侧 Z 干涉仪倾斜依赖、LS XY spot 和 TIS drift reference，两个支路在下段前合流。 | 《TT-MA-ME-intro-1v2.ppt》第 12 张。《TT-MA-ME_setupblock_1-5_1v3.ppt》第 62–97 张。《TT-MA-ME_setupblock_6-8_1v3.ppt》第 4–30 张 |
| 下段 | M 侧 WS XY、E 侧 WS XYZ、WS 绝对镜图、适用时的 RS 干涉仪镜图汇到 WS 非正交/尺度，随后是扫描方向依赖、绝对台体网格、SODOM、BMAA fine、BMTIS fine、Combined FOCAL、Final XY 和 Matching。 | 《TT-MA-ME-intro-1v2.ppt》第 13 张。《TT-MA-ME_setupblock_6-8_1v3.ppt》第 31–117 张 |
| rel.3.1/3.2 | Level 1 原图将旧流程分成 14 段，配套讲义共列 28 项校准测试，验收验证另计。它显式列出 airmount、WH、照明以及旧版系统集成步骤。Z mirror、chuck-to-chuck mapping、分开的 FOCAL 等沿其各自的版本章节查阅。 | 《13_AP-L1-ME_rel_3.2.pdf》第 19–29、46、61–82 页 |

rel.3.4 总顺序（本机原图 `参考文献/Markdown_v1/assets/22af802d5c3181fe/images/page_9_image_4_v1.jpg`）

*原图《TT-MA-ME-intro-1v2.ppt》第 10 张。框的并联与合流对应依赖关系。图中的 BMAA fine、BMTIS fine 或 M 侧 WS 干涉仪重测与前序参数更新有关，各复测的目的见子系统章节。*

## 掩模台 RS

### 部件级校准和调整

| 项目 | 用途 | 校准的机器常数或调整量 | 测量与校准步骤 | 原始资料 |
|---|---|---|---|---|
| **SRCA — 空气轴承控制器** | 建立长行程 LoS、平衡质量 BM 和重力补偿 GC 的正常气压 | LoS、BM 气动控制器物理设定，GC 压力在本项检查。课件未给 MC 写入字段 | 确认厂务和 PFU 供给，启动 SRCA，读各压力是否落在绿色范围，手调 LoS/BM 控制器后复查。气动 GC 由适用硬件的 SRGC 处理 | 《TT-MA-RS-Calibrations-3v1.ppt》第 41–49 页 |
| **SRDC — 差分传感器粗偏置** | 让粗零点落到短行程机械范围中心，供后续初始化 | X1、Y1、Y2、Z1、Z2、Z3 的 Initial Difference Sensor Offsets [bits] | 逐逻辑轴测正负端的差分传感器读数，求六自由度机械范围中心与偏置 | 《TT-MA-RS-Calibrations-3v1.ppt》第 50–53、58、62 页。《08-TT-L3-RSbook.pdf》第 77–79 页 |
| **SRDC — 差分传感器精偏置／可选 Z 电容偏置** | 把差分零点连接到镜头水平中心及电容测量 Z=0 | 六通道 Final Difference Sensor Offsets [bits]。可选 Z1–Z4 Capacitive Sensor offsets [m] | 将掩模卡盘移至镜头水平中心并令 Z 电容读数为零，记录六路偏置。选择附加子项时测四路 Z 电容初始偏置 | 《TT-MA-RS-Calibrations-3v1.ppt》第 50–53、58、63–64 页。C-spec 版本见第 282–299 页，另有气动 GC 开环前提 |
| **SRDC — 差分测量系统增益矩阵** | 把相对短／长行程的六路传感器读数换算成逻辑坐标 | 报表列名 Measurement System Gain Matrix **SS2LS**、**LS2SS**，以及校验用 Correction Matrix。Mechanical Short Stroke Range、Gain and Crosstalk 是检查项 | 短行程沿各逻辑轴步进，读取六路输出并求映射。按机械量程与串扰验收。SRZP、SRLP 可为自身流程临时建立增益 | 《TT-MA-RS-Calibrations-3v1.ppt》第 50–53、59、64–66、76、83、99、108 页 |
| **SRZP — 编码器零位** | 为 D2 及以上卡盘寻找参考标记并建立正常编码器归零的底座坐标起点 | RS 报表字段 Encoder Rz Rotation、Lenstop Rz offset、Refmark Scale Marker Set、Refmark Scale Position（X/Y/Rz/Z/Rx/Ry）。MI 报表字段 RS zero position X/Y/Rz、PA/PB overscan、Peak Offset Ref。报表含复现限值和有效标志，限值和默认 overscan 并非全都由本次拟合改变 | 空气支承稳定，初始化至 SS_ON_SCAN。利用有效 SRDC 矩阵或临时求矩阵，找编码器／镜头顶部 Rz，搜 A/B/C 标记组、求粗零位，再优化 6 DOF 底座位置和编码器标记参数，完整初始化复验。可指定标记组，或仅优化底座位置。改变完整零点会触发部分计量恢复 | 《TT-MA-RS-Calibrations-3v1.ppt》第 67–90 页。《08-TT-L3-RSbook.pdf》第 88–99 页 |
| **SRLP — 装载传感器增益与交换位** | 使装载传感器坐标追溯到 RS 位置基准，保证掩模交接在量程中心 | Exchange Position（差分传感器测得坐标、实际换版坐标），Load Sensor Gain matrix，报告另列零磁场电压与量程检查 | 初始化并测零磁场电压，必要时在本次临时校准差分增益。从 X/Y 有效线性区交集求中心位，沿 X/Y 运动拟合增益，再验证角点和锁定范围。编码器配置以编码器为基准，旧 IFM 版以 IFM 为基准且部分步骤不用 | 《TT-MA-RS-Calibrations-3v1.ppt》第 91–108、326–327 页。《08-TT-L3-RSbook.pdf》第 100–105 页 |
| **SRZC — 电容式 Z 传感器相对增益／偏置** | 使四个读头对同一 Z、Rx、Ry 动作给出一致响应 | Z1–Z4 相对增益 [nm/bit]、偏置 [µm 或 bits]。Z1 为增益基准，报告另列 Metrology Offsets | 按 Z1–Z4、Z2–Z3、Z4–Z2 连线依次倾转卡盘，各采 20 次求 Z2/Z4/Z3 相对增益。在已校准差分零平面定四路偏置，电容控制下移动 100 µm 复查 | 《TT-MA-RS-Calibrations-3v1.ppt》第 120–129 页。《08-TT-L3-RSbook.pdf》第 111–114 页 |
| **RS 高度换算因子／Z 绝对增益** | 使 RS Z 位移量纲与 WS 干涉仪 Z 标尺一致 | RS Z 绝对增益或高度换算因子。本资料未给字段和完整测试窗口 | 书中说明以 TIS 做 RS–WS 对准，用 WS 干涉仪 Z 增益传递 RS Z 标尺。课程仅给原则 | 《08-TT-L3-RSbook.pdf》第 111 页。《12-TT-L3-L3-ME_book.pdf》第 71 页 |
| **SRDS — 短／长行程耦合刚度和阻尼** | 减小长行程扰动传给短行程 | X/Y/Z/Rx 刚度补偿、Y 阻尼补偿，报表示例按逻辑轴及传感通道列出 | 关闭现有补偿且 GC 开环，对 X/Y/Z/Rx 做往返，追踪差分位置和短行程力计算刚度。使用新刚度，在 LoS Y 注入噪声并从位置与力的传递响应定 Y 阻尼 | 《TT-MA-RS-Calibrations-3v1.ppt》第 130–139 页。《08-TT-L3-RSbook.pdf》第 115–117 页 |
| **SRLM — 长行程电机增益平衡** | 让 Y1、Y2 执行器分别产生解耦的 Y 力和 Rz 力矩 | 长行程 Gain Balancing Matrix，报表行 Y1/Y2、列 Fy/Tz。Correction Matrix 用于验收 | 完成 SRDC，检查静稳，在编码器逻辑 Y 和 Rz 方向分别激励并测耦合，求矩阵后重新测补偿机械响应 | 《TT-MA-RS-Calibrations-3v1.ppt》第 140–150 页。《08-TT-L3-RSbook.pdf》第 118–121 页 |
| **SRLC — 长行程齿槽力补偿** | 降低 LoS 与 BM 相对位置引起的周期性磁力及位置误差 | Y1/Y2 随位置的 Cogging Table [N] | SRLM 完成后让 LoS/BM 正反向运动，采电机力相关电流及 LoS 编码器位置，逐轴生成查表并复跑，迭代至剩余力变化进限 | 《TT-MA-RS-Calibrations-3v1.ppt》第 151–160 页。《08-TT-L3-RSbook.pdf》第 122–124 页 |
| **SRSM — 短行程电机** | 解耦六轴，降低加速度前馈和电机寄生力误差 | 六轴 GB 矩阵。前馈报表列 Delay Corr. Y、Acceleration Y Pos./Neg.。CoG 报表列 Z offset to Rx/Ry、X offset to Rz、GS out Y to Rz。垂直／水平 Motor Force Compensation 有偏置、电机常数和力／力矩前馈系数 | 装掩模，SRDC/SRDS 完成且台面稳定，在基准位逐逻辑轴量执行器耦合得 GB 并复测，然后定加速度前馈、CoG 和 MFC 并逐项检查 | 《TT-MA-RS-Calibrations-3v1.ppt》第 161–177 页。《08-TT-L3-RSbook.pdf》第 125–129 页 |
| **SRLF — 投影镜头振动前馈** | 让 RS 追随镜头顶部振动，降低镜头本征频率处的位置跟随误差 | Phase Lead 与 Notch 1 滤波器参数，报告列 Proportional Gain、Zero/Pole Frequency、Notch1 Zero/Pole Damping 等。另列保留的 Notch 2 和稳定性陷波项 | SRSM 与加速度传感链通过后，测镜头加速度到位置误差的传递函数，迭代调相位超前和陷波，复查两个主峰的抑制量及 MA/MSD。A/B/C 仅检查，平台和机型决定 X/Y 或仅 X | 《TT-MA-RS-Calibrations-3v1.ppt》第 178–192 页。《08-TT-L3-RSbook.pdf》第 130–135 页 |
| **SRBF — 底座销调整／短行程 Z 止挡复核** | 让整个 RS 模块相对镜头处于正确高度姿态 | 底座销物理调整量。Z、Rx、Ry、扭转供验证。未见专用 MC 写入 | 用电容和 Z 差分传感器测下止挡及短行程 Z 中位，计算高度调整建议，按建议机械调整，再于 Y 中位和两端复测。队列模式只验证 | 《TT-MA-RS-Calibrations-3v1.ppt》第 193–222 页。《TT-Ma-RS-Construction-3v1.ppt》第 41、60 页 |
| **SRMC — 短行程外部磁扰动补偿** | 补偿磁式重力补偿器与周围金属相互作用，使扫描 MA/MSD 降低 | X、Y、Rz、Z、Rx、Ry 各一张按 Y 位置索引的 EMDC 力／力矩表，课件示例每表 150 点 | SRSM 后带掩模，以 25 mm/s 往返 10 次记录六轴控制力和 Y，合并正反向、低通和插值，再逐轴做双向 MA/MSD 验证。适用于磁补偿卡盘配置 | 《TT-MA-RS-Calibrations-3v1.ppt》第 224–234 页 |
| **SRRC — 高海拔夹持压力阈值** | 使现场大气压变化下的掩模真空异常判断仍适用 | 报表字段 **Clamping Pressure Threshold**。常规安装使用默认阈值 | 高海拔安装选择附加校准，读取 WS 区 MI 气压传感器，以相对海平面默认值的差计算阈值，实测吸放掩模的系统／卡盘真空，经确认保存 | 《TT-MA-RS-Calibrations-3v1.ppt》第 252–261 页 |
| **SRGC — 旧气动重力补偿因子／偏置** | 让气动补偿承托掩模卡盘重量，减小 Z 执行器持力 | 气动 Gravity Compensator actuator offset／setpoint。内部字段未列出 | 从默认设定和开环初始化开始，标定顶位，按 3 bits 递减 setpoint 至满足位移条件并求偏置。在 VERT_AND_GC_ON_DIFF 下追踪平均 Z 力并验证，必要时重复调偏。对 D2 磁式卡盘已淘汰 | 《TT-MA-RS-Calibrations-3v1.ppt》第 300–312 页。《08-TT-L3-RSbook.pdf》第 69–76 页 |
| **SRZS — 旧 Hall 零传感器增益与位置** | 在仍有零传感器的旧配置下让归零以少量小步迭代完成 | 报告字段 SS zero_one_position_baseframe.{x,y,rz}、SS zero_one_position_scan.{x,y,rz}、SS zero_to_init_angle。另有零磁场／位置偏置、各读头增益、home-to-zero 角 | 先测零磁场偏置，在 Zero1/Zero2 寻找近零点、核线性及 home-to-zero 角，再在 SCAN 控制下移动求增益，可选求 zero-to-init 角。D2 编码器归零用 SRZP | 《TT-MA-RS-Calibrations-3v1.ppt》第 313–324 页。《08-TT-L3-RSbook.pdf》第 84–87 页 |
| **旧 RS HP 干涉仪接收增益** | 使全工作范围内接收信号无丢失及削顶 | HPRR 接收器机箱增益物理设定，课件未给软件 MC | 台可完全初始化，经 ADT 将卡盘带到零位，用万用表接 HPRR 测点按 Coach 调整。教材适用至 B-spec | 《TT-MA-RS-Calibrations-3v1.ppt》第 325–334 页 |

### 整机计量里的 RS 校准

| 项目 | 用途 | 校准的机器常数或调整量 | 测量与校准步骤 | 原始资料 |
|---|---|---|---|---|
| **SSRS — RS 原点位置与旋转偏置** | 把 WS 已知的光轴移交给 RS，令两卡盘坐标扫描方向彼此平行 | RS x0、y0、Rz0，另一 WS 卡盘的 Rz0。选择参与设定的主卡盘 | 基于已标定 WS spot sensor，在狭缝内找 RS TIS 基准上的两个 spot targets，解投影位移并换算到 RS 更新 x0/y0。RS 相隔两个 Y 位置重复测量，用两位置 X 差求相对旋角，依主卡盘定 RS Rz0，再让另一卡盘跟随 | 《TT-MA-ME_setupblock_1-5_1v3.ppt》第 47–57 页。《12-TT-L3-L3-ME_book.pdf》第 47–52 页 |
| **GISM — 编码尺映射及扫描倾斜** | 校正随 RS Y 位置而变的水平标尺误差与垂直扫描倾斜 | MI 的 YTX、YTY、YRZ 查表，步长 1 mm。RS Z/Rx/Ry 模型的 **wl、wq、wr**。标尺表用于编码器，扫描倾斜用于编码器及 IFM | BA-ME-TIS-SETUP 掩模标记 Y 间距 2 mm，RS 按同一节距步进，WS TIS1 读狭缝内各标记 XYZ，多相对位置拟合分离掩模标记误差、镜头／WS 误差和 RS 误差。工作测区插值，外端按课件线性外推。rel.3.2 独立 RS Scan Tilt 方案将标记行保持在狭缝中心，TIS 对各行作对角扫描，拟合一阶／二阶掩模楔形 | 《TT-MA-ME_setupblock_6-8_1v3.ppt》第 5–13 页。《12-TT-L3-L3-ME_book.pdf》第 69–74 页。《13_AP-L1-ME_rel_3.2.pdf》第 53–54 页 |
| **EMRS／RSIHT — RS 初始高度和倾斜** | 在 ILIAS 之前建立最佳物面附近粗姿态，压低 D3 和场曲，并由 D2 粗定 Ry | 报表列 **Reticle Stage Height / Tilt Rx / Tilt Ry、Lens Element 1–5 Height**（按镜头适用性）、**Wavelength Shift**。课件亦列两 WS 像面高度／倾斜、TIS T1–T5 位置。历史版本另列旧 Coarse XYZ 的 KI、KU、MI 参数，L3 回顾还指出 rel.3.2 的初始 RS 高度曾作为 TAMIS 子选项 | 在 BA-ME-TIS-SETUP 或 BA-Z-MAP 中心线标记，对默认三个狭缝 Y 位置作 TIS Fine 扫描，重复采样，最小二乘拟合、更新关联参数。后续 ILIAS/SODOM 再细调 Ry 等。rel.3.2 的 Coarse XYZ 例用中心行 9 标记、5 个 RS Y 位，以 TIS 对角扫描测已成像位置 | 《TT-MA-ME_setupblock_6-8_1v3.ppt》第 14–17 页。《12-TT-L3-L3-ME_book.pdf》第 75–78 页。《13_AP-L1-ME_rel_3.2.pdf》第 55–59 页 |
| **RS 干涉仪镜面图** | 校正 IFM 配置的掩模台沿 Y 运动引起的 X 误差 | **YTX** 镜面图。该配置 Rz 采用 Rzy | 最佳物面确定后沿 Y 扫描，采用与 WS 镜面图相同的冗余干涉仪策略重建横向位移。本页未给独立测试码 | 《TT-MA-ME_setupblock_6-8_1v3.ppt》第 39、45–49 页 |

RS 诊断链还有 SRAD（控制及读数界面）、SRED（编码器板卡、纤路、信号校验、方向和量程检查）、SRSA（短行程传感器与执行器检查）、SRCD（Z 电容通道诊断）及模块移出／移入。RS 端止挡可调，构造课件说明详细调整超出该课程覆盖。SRRC 的常规用途也为验证，阈值写入只出现在专用高海拔选项。来源为《TT-MA-RS-Calibrations-3v1.ppt》第 7–40、109–119、236–251、252–278 页及《TT-Ma-RS-Construction-3v1.ppt》第 60 页。


## 晶圆台 WS

相关模型　[ifm_model 的读数](ifm_model.md#ifm-readout) · [ifm_raw 的 XY 原式](ifm_raw.md#xy-ifm-原式) · [ifm_raw 的 Z 原式](ifm_raw.md#z-ifm-原式) · [ifm_model 参数与标定](ifm_model.md#ifm-constants)

### 部件级校准和调整

| 项目 | 用途 | 校准的机器常数或调整量 | 测量与校准步骤 | 原始资料 |
|---|---|---|---|---|
| **AOM 光纤耦合／激光强度** | 最大化 WS 位置干涉仪测量光源的传输功率 | 两路光纤耦合位置。验收为每路及合计光功率，课件未列 MC 写入 | 在 ROC 后放功率计，交替遮断一条光路、调另一条的发射耦合，监视输出并查单路和总功率。旧 B-spec 双激光在 RU 后检测，单激光半 RU 因分光须分别测位置 A/B 再相加 | 《TT-MA-WS-Calibrations-3v1.ppt》第 8–17、175–185 页。《09-TT-L3-WSbook.pdf》第 77–78 页 |
| **AOM 双频光强再平衡** | 令送入 ROC 的正交偏振频率 f1/f2 光强接近并保持总输出 | AOM 单元内的光强平衡。无课件公开 MC | AOM 稳定、光纤耦合完成后接回 ROC/AOM 电缆，以 ROC 采样器的交替偏振强度作反馈，AOM 自动平衡。状态码 14 停止闪烁为结束信号 | 《TT-MA-WS-Calibrations-3v1.ppt》第 18–23 页。《09-TT-L3-WSbook.pdf》第 79–80 页 |
| **SWCA — 空气轴承气压与真空** | 使长、短行程在指定气浮／预载条件下运行 | 手调各限制器或调节器。报告目标压力是 Test Constants，课件未显示依本测试生成 MC | 用手持表量系统供气与真空，WS 初始化至 SS GC on Feed Forward。SWCA 对各传感器取 200 样本，按监控值调相应气路并复测。Type-1 有独立 X–Z、X–Y 气路读数及流量，Type-2 部分共用 | 《TT-MA-WS-Calibrations-3v1.ppt》第 24–33、203–204 页。《09-TT-L3-WSbook.pdf》第 81–83 页 |
| **SWDC — 差分传感器偏置** | 使镜块位于卡盘载体机械中心时六轴读零 | 各卡盘 H1/H2/H3/Z1/Z2/Z3 的 Offset SS MC [bit] | WS 移出，先确认镜块落在 Z 下止挡，将 4 个竖直工具和 2 个水平销装入定位，记录六路原始输出作为偏置，去除工具移回，SWCR 可复核行程对称性 | 《TT-MA-WS-Calibrations-3v1.ppt》第 34–42 页。《09-TT-L3-WSbook.pdf》第 84–87 页 |
| **SWGA — 被动气动重力补偿** | 以规定剩余载荷确保短行程电机关断后镜块确实落到下止挡 | 气动阀手调压力。课件目标是 Z 执行器合计约 4 N，对应约 0.4 kg 剩余质量。阈值是验收用量 | 台上有所有传感板与 wafer table、无晶圆，粗调气压至约 4.5 bar 或临近浮起。用 SWGA 的 Z 力反馈细调，最后在电机关断时检查镜块落下传感器 | 《TT-MA-WS-Calibrations-3v1.ppt》第 43–52 页。《09-TT-L3-WSbook.pdf》第 88–92 页 |
| **SISO-2 — Stop Sensor／左于中心传感器** | 确保台车重新移入时对准固定 U 形导轨 | Stop sensor 的安装位置／开关边缘，未见软件 MC | 以悬挂销定位于 X 方向中心，再仅下降到地面。以右后部 U 形导轨边缘为基准，将开关状态调至刚好转换 | 《TT-MA-WS-Calibrations-3v1.ppt》第 53–56 页。《09-TT-L3-WSbook.pdf》第 94–96 页 |
| **SWMS／SWBC — 底座坐标测量系统** | 建立相对于底座的长行程测量，使其尽量独立于 BM 运动 | 已知参数族包括 LoS 编码器角度及增益、BM 零位、BM 编码器角度及增益。内部字段与 SWMS 完整流程未列出 | MK1/MK2 用 SWMS，MK3 起用 SWBC。SWBC 以干涉仪为基准求 LoS 角度及编码器增益，测 BM 初次回零／静休位置，借 LoS 激励 BM 求编码器角度和增益 | 《TT-MA-WS-Calibrations-3v1.ppt》第 57–58 页。《09-TT-L3-WSbook.pdf》第 76 页 |
| **SWSW — 卡盘交换轨道和停放位置** | 补偿装配公差，保证卡盘跨 M/E 交换时的导入与锁定 | 各卡盘、各侧 Entry、Sync、CPL 位置 X/Y/Rz。报告字段例 sw_chuck_id_1_entry_pos_expose.x／.y／.a，同样列出 sync_pos 和 cpl_pos 及 measure 端 | 在入口和同步区中点分别探触导轨取 X，由两点求 Rz。到交换位置释放夹钳、以 Chuck ID 传感器中点定 X 偏移，回修入口和同步区。两卡盘两侧共四组 | 《TT-MA-WS-Calibrations-3v1.ppt》第 59–69 页。《09-TT-L3-WSbook.pdf》第 97–100 页 |
| **SWDC — 差分传感器增益** | 使六路相对传感器对应干涉仪的六个逻辑轴 | 六轴 SS Diff Gain 矩阵 36 项，LoS 的 X/Y/Rz 映射 18 项 | 偏置完成且气浮稳定，按所处一侧在 IFM 控制下沿六轴逐步移动，同步量 IFM 与六路差分读数，从位移比拟合矩阵。以新矩阵复测同轴误差及串扰 | 《TT-MA-WS-Calibrations-3v1.ppt》第 70–77 页。《09-TT-L3-WSbook.pdf》第 101–103 页 |
| **SWLC — 长行程齿槽力** | 补偿线性电机随位置变化的磁齿槽力 | X、Y1/Y2 的 LoS 编码器位置—力补偿查表，M/E 分测 | 低速恒速正反向移动 X、Y1、Y2，记录控制器输出，平均分离齿槽力。加载新表复跑验收剩余力纹波 | 《TT-MA-WS-Calibrations-3v1.ppt》第 81–88、90–92 页。《09-TT-L3-WSbook.pdf》第 104–109 页 |
| **SWLC — 长行程执行器系统** | 减少交换时的控制误差及稳定时间，支撑较高加速度／速度 | Y1/Y2 和 X 的重心／线性系数，报告列 COG_X、Ly0 [m]、X/Y1/Y2 Motor Constant [N/A]。按卡盘配置和侧别报告 | 适用 PEP-C、D-spec 起配置，按量产质量装片，作不同重心设定／偏移的长行程动作，分别解 Y1/Y2 与 X 系数，再比对多组轨迹控制误差 | 《TT-MA-WS-Calibrations-3v1.ppt》第 81、83–89、93–94 页。《09-TT-L3-WSbook.pdf》第 104–110 页 |
| <a name="swzs"></a>**SWZS — IFM 对准、PSD 零传感器和快归零** | 找干涉仪有效归零及六自由度零传感器基准，完成后工位可复现初始化 | 两卡盘 × M/E 四组合。Rx0/Ry0/Rz0 初始化倾角。Zero Sensor Gain Matrix、SZP、ZSO、FZP、MISZP。报表含三只 PSD 各 u0/v0、du/dX 等电压增益及位置 [ifm_model 的读数](ifm_model.md#ifm-readout) | 倾转找 IFM 质量峰，记录基准姿态。全 PSD 校准须选择 IFM align，先找 PSD 中心和粗增益并查光强、量程等，计算 OZP 后再求精增益、偏置、FZP、传感器位置及 MISZP。单跑 IFM-align 是检查。独立 Update FZP 按 BF 偏置修正快归零，恢复范围和完整 PSD 校准不同 | 《TT-MA-WS-Calibrations-3v1.ppt》第 97–108 页。《TT-MA-ME_setupblock_1-5_1v3.ppt》第 7–9 页。《09-TT-L3-WSbook.pdf》第 111–116 页 |
| **SWEM — E-pin 位置传感器与电机** | 准确读出并驱动顶针，保证晶圆接放 | E-pin 位置传感器增益、偏置，E-pin 电机常数 | 校准顺序为位置传感器增益、偏置、电机常数。课件只列子步和输入界面，未给各量的基准与拟合方法 | 《TT-MA-WS-Calibrations-3v1.ppt》第 121–123 页 |
| **SWEX — WS 晶圆交换位** | 让卡盘对齐装／卸载基准，为 WH 机器人位置校准提供基准 | 两卡盘分别的装／卸载 X/Y 中心坐标，传感器量程检查。MC 内部字段未列出 | WS Type-3 移至名义加载位，在 X/Y 扫描随卡盘气足运动的交换传感器对石基目标的响应，求目标中心，重复卸载位及另一卡盘 | 《TT-MA-WS-Calibrations-3v1.ppt》第 124–126 页 |
| **SWLF — 镜头前馈及 MI 参考光路滤波** | 降低 WS 短行程位置的镜头本征振动和参考镜支架影响 | 两个镜头前馈滤波器和两个 MI 滤波器的系数。课程示例有新旧 MC，软件内部字段未列出 | 追踪每束参考光的响应，求两主峰并拟合 MI 滤波，再根据镜头加速度—位置误差传递函数迭代前馈系数，并复查 MA/MSD。MI 需 IFSR 架构。pepC／D-spec 镜头前馈仅检查，pepD／E-spec 起支持校准 | 《TT-MA-WS-Calibrations-3v1.ppt》第 127–134 页。《09-TT-L3-WSbook.pdf》第 122–125 页 |
| **SWDS — 短／长行程刚度、阻尼与迟滞** | 补偿线缆、气管与电磁效应造成的寄生耦合 | SS–LoS 的 stiffness、damping、hysteresis 参数族，MC 字段未列出 | 慢速线性移动，以力对位移的斜率算刚度。向 LoS 或 SS 注入噪声，从传递函数求阻尼。课件未给迟滞单独的取数算法 | 《TT-MA-WS-Calibrations-3v1.ppt》第 135–137 页 |
| **SWSM — 短行程电机（PEP-C 起）** | 六轴解耦并改善加速、稳定和扫描位置 | ① Gain Balancing 矩阵，② Motor Force 补偿系数，③ 各水平驱动的 Z、Z² 抛物线增益，④ Fine Tune Feedforward 的方向相关质量、jerk/snap 及过程匹配延时 | 装片到量产质量、台稳定且零位已校准。① 在零位测传递函数并验矩阵。② 在不同 Z/加速度做 X/Y 往返，采 Z 差分量与六轴控制力。③ 不同 Z 作 XY 运动，由控制力和执行器力求抛物线。④ 测四方向前馈前输出求等效质量，注力提取 jerk/snap，并由高低延迟误差拟合延时 | 《TT-MA-WS-Calibrations-3v1.ppt》第 138–152 页。《09-TT-L3-WSbook.pdf》第 126–130 页 |
| **SWSM — 旧 A/B/C 短行程电机** | 在旧控制结构中解耦短行程执行器并校准加速度前馈 | Gain Balancing Matrix 和 Feed Forward 参数。示例未执行 Motor Force、Parabolic Gain、Fine Tune Feedforward | 稳态检查通过、卡盘在零位，联测机械传递函数与增益平衡、加速度前馈。用新矩阵复测，合格后保存 | 《TT-MA-WS-Calibrations-3v1.ppt》第 208–215 页。《09-TT-L3-WSbook.pdf》第 141–143 页 |
| **WS Type-2 — Inflate Sensor** | 让移台装置正确感知四点悬挂销与底座支承板的高度到位 | 四个 Inflate Sensor 的物理触发位置。整台 stone-to-metroframe 高度由支承板与底座间的垫片定，本项按止挡重新定传感器 | 让气囊充气将模块推至支承板机械止挡，用该位置设四个传感器。安装、传感器／支承板更换或整台高度改变后执行 | 《TT-MA-WS-Calibrations-3v1.ppt》第 169–173 页。《09-TT-L3-WSbook.pdf》第 93–94 页 |
| **SWHP — 旧 HP 干涉仪收信增益与调整诊断** | 让 WS 接收信号处于增益范围内，验证 IFM 信号链 | 至 B-spec HPRR 的接收器实体增益，未见 MC。书中也把 IFM 调整／诊断 SWHP 列为 SWZS 前置 | WS 可完全初始化，启动 IFM align，把弹出的增益监控窗作为反馈，手调接收器再检查。C-spec 起采用 IFSR。旧机箱手调流程详见 B 附录 | 《TT-MA-WS-Calibrations-3v1.ppt》第 186–195 页。《09-TT-L3-WSbook.pdf》第 111 页 |
| **旧 SISO-1 — 倾角传感器居中** | 将 WS 短行程框架 Rx/Ry 倾角传感器置于其测量量程中心 | 倾角传感器机械零位／居中姿态。MC 未列出 | WS 以悬挂销定位，借专用工具及两只万用表确定量程，再机械调 Rx/Ry 中点。SISO-2 在移出／移入后自动校准 | 《TT-MA-WS-Calibrations-3v1.ppt》第 196–201 页。《09-TT-L3-WSbook.pdf》第 135–136 页 |
| **SWGC — 旧 Type-1 主动气动重力补偿** | 用气动阀承担镜块及晶圆重量，让镜块浮起 | 每卡盘 Actuator factor [bits/N] 和 Actuator setpoint [bits] | 卡盘装晶圆，选择卡盘运行，识别力—阀设定换算并求临界浮起阀设定。资料只给原则和选项，主动／被动配置对应 SWGC／SWGA | 《TT-MA-WS-Calibrations-3v1.ppt》第 205–207 页。《09-TT-L3-WSbook.pdf》第 139–140 页 |

WS 的 SWCR（行程／IFM 范围）、SWBD（BM 机械迟滞、衰减、刚度验收）、SWTH（短行程电机冷却）、SWSP（换台性能）、SWLA/SWSA（长短行程传感器和驱动诊断）、TSPE（台性能）、SWMB（机械行为）以及镜面质量等检查为校准前置或验收。SWBD 用激励后的静休位、对数衰减及恒力位移求性能，测试定位为 qualification。来源为《TT-MA-WS-Calibrations-3v1.ppt》第 5–6、78–80、95、109–120、144、153–165 页及《09-TT-L3-WSbook.pdf》第 76 页。

### 整机计量里的 WS 校准

| 项目 | 用途 | 校准的机器常数或调整量 | 测量与校准步骤 | 原始资料 |
|---|---|---|---|---|
| <a name="wzim"></a>**WZIM — 测量侧初始高度和倾斜** | 消除随 XY 行走的一阶 Z 串扰，让名义厚度晶圆在归零后对应 LS-M4，统一两卡盘初始化 Ry | 各卡盘 **Z0、Ry0、szxa、szya**，模型推导中亦写作 szx0/szy0。第 29 页说明 szya 为卡盘相关、M/E 共用 [ifm_raw 原始模型](ifm_raw.md) | 两卡盘各用裸片，以 LS M0/M4/M8 为高度／倾角参考在网格测 IFM Z。晶圆在原卡盘旋转 180° 重测以抵消楔角，拟合 XTZ/YTZ 线性项、求 Z0/Ry0。以书的测量侧限定与后续 BMWZ 的分工为准 | 《TT-MA-ME_setupblock_1-5_1v3.ppt》第 10–18 页。《12-TT-L3-L3-ME_book.pdf》第 27–29 页 |
| <a name="wgim"></a>**WGIM — WS TRIM** | 消除 Rz 对 Rx/Ry 和 XY 的耦合，令 Ryz 的一阶分量与 Ryx 一致 | 两卡盘、双侧的干涉仪模型系数，含 Rz 倾角项、Rz 的 X/Y 线性项及 Ryz–Ryx 随 X 的一阶项。课件未列软件字段 [ifm_raw 原始模型](ifm_raw.md) | 比对冗余 X、Y 干涉仪测的 Rz，施加倾转定上束高低差所致项，再作 XY 运动定束线不平行项。用 X-IFM 的 Ryx 当参考对比 Z-IFM 的 Ryz。L2 记载每卡盘跑覆盖全片的 5×5 网格，每点设 17 种 Rz/Rx/Ry/Z 组合，量 X/Y/Z/Rx/Ryx/Ryz/Rzx/Rzy 后联合拟合 | 《TT-MA-ME_setupblock_1-5_1v3.ppt》第 19–26 页。《12-TT-L3-L3-ME_book.pdf》第 30–33 页。《TT-L2-ME-3v0.pdf》第 58–60 页 |
| **CLPL — WS 基准板调平** | 让测量与曝光侧共用高度参考，并将基准标记置于 AA 焦平面 | 两卡盘 TIS1/TIS2 Reference Heights、Grating Heights。TIS、ILIAS 板的 Z/Rx/Ry 参数族 | 仅在 M 侧用 LS-M4 作零基准，Z-IFM 在板上指定基准点、光栅点、平面拟合点采高。分别定参考／光栅高度和基准板平面。生产中以两参考点分解 Z/Ry 归零复现误差 | 《TT-MA-ME_setupblock_1-5_1v3.ppt》第 27–31 页。《12-TT-L3-L3-ME_book.pdf》第 33–35 页 |
| <a name="wtaf"></a>**WTAF — 测量侧 XY 干涉仪参数** | 使 AA 测出的 XY 对 Rx/Ry/Rz 调姿不敏感，旋转中心与 AA 有效位置一致 | 每卡盘 10 项 XY-IFM 模型参数，包括阿贝臂 **ax、ay**。课件未给完整十项名称 [ifm_raw 原始模型](ifm_raw.md) | 已知 AA 粗焦，借 AA 读 TIS1-I0/TIS2-I0，分别施加正负 Rx/Ry/Rz，按读取的 XY 位移拟合。BMAA fine 更新后在精设定块复做，以整台工作范围重新校准阿贝臂 | 《TT-MA-ME_setupblock_1-5_1v3.ppt》第 44–46 页。《TT-MA-ME_setupblock_6-8_1v3.ppt》第 31–32 页。《12-TT-L3-L3-ME_book.pdf》第 43–45、89 页 |
| <a name="wztd"></a>**WZTD — 测量侧 Z 干涉仪倾斜依赖** | 使 LS 与 Z-IFM 的有效枢轴重合，并把相同高度对齐到同一 Z 基准 | 测量侧 Z-IFM tilt point／阿贝臂和 Z 倾角模型参数，课件未逐项列字段 [ifm_raw 原始模型](ifm_raw.md) | 在多个 XY 采点，以 LS 固定高度，变换 Rx/Ry/Rz，求 IFM Z／晶圆表观厚度随姿态的差，用两卡盘数据拟合更新 | 《TT-MA-ME_setupblock_1-5_1v3.ppt》第 81–82 页。《12-TT-L3-L3-ME_book.pdf》第 60 页 |
| **BMWZ — 曝光侧 WS 初始高度和倾斜** | 无 CS 架构下以掩模标记的 TIS 像面作为曝光侧高度基准 | 曝光侧 **Z0、szxa**。完整模式连同 BMTIS 相关参数，含 TIS Ratio／并行传感器光栅高度和位置，并对 spot sensor 高度／XY 做前馈。Lz/Lry 置零，由后续细化 | 用 ME-TIS-SETUP 掩模和 RS TIS 基准，由两 WS TIS 作粗 Set-up 与精 Ratio/CHV/MHV/FHV 扫描。只能识别 Z0+Lz、szxa+Lry 组合，szya 沿用 M 侧。Capture 恢复模式只更新 WS 零点／扫描倾斜，且课件列有大改动后的相关复校 | 《TT-MA-ME_setupblock_1-5_1v3.ppt》第 89–94 页。《12-TT-L3-L3-ME_book.pdf》第 63–66 页。使用 CS spot A 的旧粗测路径见《13_AP-L1-ME_rel_3.2.pdf》第 24 页 |
| <a name="wgtd"></a>**WGTD — 曝光侧 XYZ 干涉仪倾斜依赖** | 抑制曝光工位 X/Y/Z 随 Rx/Ry/Rz 的位置误差 | 报表组例 **wse_chuck1_if_model_parameters**，列 23 项。光束几何 **K、L、ax、ay、cx、cy、dd、ee**，误差角 **Ryix0、Rzix0、Rxiy0、Rziy0**，Z 与倾角一／二阶及交叉项 **ezxa、ezya、ezza、czxxa、czxya、czxza、czyya、dzxxa、dzyya、dzzza、dzxza** [ifm_raw 原始模型](ifm_raw.md) | BMTIS 后用普通 TIS1/TIS2 分别测 RS TIS 基准 T1/T2，通过 2×2 组合及多个姿态分离各标记、镜面图和镜头固有误差，拟合两个卡盘的模型。旧 Overlay versus Rotation and Tilt 只用 XY 数据、耗时更长 | 《TT-MA-ME_setupblock_6-8_1v3.ppt》第 33–38 页。《12-TT-L3-L3-ME_book.pdf》第 89–92 页 |
| **GIWS — 绝对 XY/Rz 镜面图** | 纠正镜面面形对 XY 与偏摆测量的影响 | 每工位／卡盘的 **XRZ、YRZ、XTY、YTX** 表，书载 1 mm 存表网格 | 在正反扫中互换哪束固定、哪束读取，以成对束差求绝对 Rz。沿束间固定距离把 Rz 数据分组，各组平滑并求相对偏置后重建平移图，运行时插值 | 《TT-MA-ME_setupblock_6-8_1v3.ppt》第 39、45–48 页。《12-TT-L3-L3-ME_book.pdf》第 93–95 页 |
| **GIWS 段 — XRY/YRY 附加镜面图** | 校正沿 X 或 Y 移动时由镜面造成的 Ry 读数误差 | **XRY**、**YRY** 查表 | X 扫时 X-IFM 落在同一 X 镜位置，Ryz 与 Ryx 的差用作 XRY。Y 扫时借 WGIM 同一冗余，以单个 X 镜误差小于 Z 系统总镜面误差为模型假定，把差值主要归至 Ryz 拟合 YRY | 《TT-MA-ME_setupblock_6-8_1v3.ppt》第 43–44 页 |
| **旧相对 Z-IFM 镜面图（CS）及后续补偿** | 校正 M 侧高度地图向 E 侧回放时两处镜面的 Z 差 | 旧相对 **XTZ、YTZ、YXTZ** 图加到曝光侧绝对图内。rel.3.2 测量侧绝对表初置零。rel.3.4 课程用 Combined FOCAL 标定相对 XTZ 抛物线项，YTZ/YXTZ 由同一随卡盘移动的 45° 镜主导 | 旧版用超平裸片，CS 在 M/E 侧的同一 XY 网格／TIS 板取高，通过换台和两张图相减抵消晶圆面形，算曝光侧修正。新版由显影焦距测试拟合剩余 X 项 | 《13_AP-L1-ME_rel_3.2.pdf》第 62–68 页。《TT-MA-ME_setupblock_6-8_1v3.ppt》第 40–42、77–95 页 |
| **GRMO — 非正交性和 Y/X 比例** | 校正 XY 轴不垂直和网格间距比例差，补绝对镜面图的一阶不可辨识项 | 两卡盘双侧非正交和 Y/X scaling，课件注明比例可通过 TIS1/TIS2 基准位置调整。未列软件字段 | 两卡盘各曝光正交标记十字，每组有四向标记，两层在每个卡盘用 0°、90° 重装读取，用转向分离 M/E 贡献，剔除离群后拟合。坐标改变需重做或变换恢复 BMAA/BMTIS | 《TT-MA-ME_setupblock_6-8_1v3.ppt》第 50–58 页。《12-TT-L3-L3-ME_book.pdf》第 96–98 页 |
| **XYVO — 扫描方向依赖／RS–WS 数据延迟** | 改善不同扫描方向和速度下层间套刻 | MI 报表 **Data Delay Ty** [nm/(m/s)]，单位等价于 ns，分别对应两卡盘 | 用 BA-XY 掩模在同一晶圆的各场动态曝光两组位置标记，扫描方向相反，第二图偏移 640 µm。显影后读标记，由场内 Y 差和扫描速度求时延，跨场平均并按选项更新卡盘 | 《TT-MA-ME_setupblock_6-8_1v3.ppt》第 59–63 页。《12-TT-L3-L3-ME_book.pdf》第 99 页 |
| **WTAM — 绝对晶圆台网格 ASG** | 消除绝对镜面图仍遗留的下束位置误差和两卡盘相对差，提高本机跨卡盘套刻 | 两卡盘 × 双侧的 **XTY、YTX** 共八张 MI 表，按卡盘间差分摊校正 | 用 BA-ASG (4022.455.63061) 在同一片用两卡盘曝光约 2 mm 网格的行列标记，第二卡盘偏移 640 µm，显影后在两卡盘读取。利用零层对准消掉晶圆线性项、共用掩模抵消掩模项，将剩余套刻差归到图 | 《TT-MA-ME_setupblock_6-8_1v3.ppt》第 64–73 页。《12-TT-L3-L3-ME_book.pdf》第 100–102 页 |
| **旧 Chuck-to-Chuck Mapping** | 细调双卡盘双侧相对横向位置，使 X/Y 镜面残差不劣化同机套刻 | 更新两卡盘双侧 **XTY、YTX**，保留已有相对关系。课件报告注明超规格时保存 | 两片分别作 X/Y 残差，约 1 mm 标记节距。在两卡盘交错曝光行或列，显影后两卡盘在 M 侧 AA 扫读，平均同一标记坐标求相对理想坐标的残差，再分配到图 | 《13_AP-L1-ME_rel_3.2.pdf》第 72–80 页 |


### 图像核查

《TT-MA-ME_setupblock_1-5_1v3.ppt》第 16 页的两个原始图表对应 WZIM 的同一类晶圆高度条带。左图色条和 Z 刻度为 10⁻⁴ m 量级，随 X 由一端向另一端单调下降，课程以约 30 µm 的线性变化示例说明 XTZ。右图使用 10⁻⁶ m 刻度，X 两端高、中央低，仍看得到弯曲。两张图的轴倍率相差 100 倍，这个倍率对应坐标标度。图上实际峰谷差需分别结合各自刻度计算。后图说明 WZIM 去除了主导一阶倾斜，后续仍有高阶镜面或高度残差要处理。

| WZIM 前 | WZIM 后 |
|---|---|
| WZIM前的晶圆高度条带（本机原图 `参考文献/Markdown_v1/assets/c9af45c9eb25c12e/images/page_15_image_4_v1.jpg`） | WZIM后仍有弯曲残差的晶圆高度条带（本机原图 `参考文献/Markdown_v1/assets/c9af45c9eb25c12e/images/page_15_image_5_v1.jpg`） |

- 《TT-MA-WS-Calibrations-3v1.ppt》第 102 页的 SWZS 界面显示 Chuck 1/2 × Measure/Expose 四个可选校准组合。在图示的 PSD Calibration 模式，IFM Align 已勾选且灰显，Update FZP 未勾选。第 103 页说明这是全 PSD 校准自带对准并重新求 FZP 的逻辑。右侧有 Save MCs，截图当时进度为 0%，因此图示是输入配置。 原图（本机原图 `参考文献/Markdown_v1/assets/56ea2737208dfc3a/images/page_101_image_4_v1.jpg`）
- 《TT-MA-RS-Calibrations-3v1.ppt》第 127 页的实物照显示镜头顶部中央开孔的周边布置着多个传感器组件，第 126–127 页的动作与位置标注说明用多条读头连线作为倾转枢轴，依据其余读头的位移响应求相对增益。实物图描述的是传感器布置，增益绝对比例另由 TIS 与 WS Z 标尺比较。 原图（本机原图 `参考文献/Markdown_v1/assets/37f2bdeb89c9d67b/images/page_126_image_1_v1.jpg`）
- 《TT-MA-ME_setupblock_6-8_1v3.ppt》第 63 页的 XYVO 原始报告图显示 Data Delay Ty 的参考值、校正和新值三列。示例卡盘 1 为 −3.766、+1.570、−2.196 nm/(m/s)，卡盘 2 只列参考值。报表同时列场内 Y 平移统计和扫描速度，能把时延常数与套刻观测量对应起来。 原图（本机原图 `参考文献/Markdown_v1/assets/24158f8b5bfd8ba2/images/page_62_image_1_v1.jpg`）

## 高级对准、图像传感器、调平与照明投影

下列文件页均按原 PDF 第一页或原 PPT 第一张起算。方括号内的 BMAA、BMIS、ELLA 等为测试记号，Coach 编号是程序编号。只有源文明确标为机器常数或报告字段的量才照录名称。TRM 表示平移、旋转、倍率坐标变换。表内的“字段名待查”指资料已描述所校准的量，但没有足以确认的 MC 编辑器键名。

### 高级对准（ATHENA AA）

| 项目 | 类型与目的 | 校准的机器常数或输出 | 主要流程 | 原文件及文件页 |
| --- | --- | --- | --- | --- |
| 相位调制器灵敏度录入 | 换件设定。使红绿相位调制器的电压到相位换算正确。 | PM phase sensitivity（rad/V），分别录入红、绿参数。 | 从激光模块盖板标签抄录灵敏度至 MC，打开调制器并重新初始化，待稳定后再检验谐振。 | 《04-TT-L3-ATS-AA-2v0.pdf》61（印刷 55）、73（印刷 67）。 |
| 相位调制器谐振频率 | 换件校准／验证。确认晶体及 RF 驱动的谐振点。 | Phase Modulator resonance frequency。反射功率和 3 dB 带宽为检查量。 | 分别扫红／绿 RF 频率，取反射功率最低处为谐振频率。可用监控模式复查 RF 电子给出的值。 | 《04-TT-L3-ATS-AA-2v0.pdf》62–64（印刷 56–58）、73（印刷 67）。 |
| 对准激光输出监测二极管灵敏度（csal056.adj） | 校准。用监测二极管换算实际红绿激光功率。 | 测试报告字段 `Initial Laser Power`、`Sensitivity`、`Dark current`、`Laser Calibrated`，按红／绿配置。 | 录入标签或独立功率计测得的初始功率。闭快门测暗输出，开快门测光输出，计算灵敏度。检查结果再保存。 | 《04-TT-L3-ATS-AA-2v0.pdf》65–68（印刷 59–62），《TT-L2-ATS-3v0.pdf》48–49。 |
| AGC 通道偏置与增益 | 电子校准。把信号映射到 ADC 有效量程并建立 WQ 增益换算。 | ODB/ADB 各通道增益曲线斜率、截距。报告字段 `Close AGC Output [Bits]`、`Test AGC Output [Bits]`。存储键名待查。 | 光路关闭时读两点中的暗端，再向 ODB 输入已知 2.5 V 测第二端。从两点求斜率、截距并按通道验收、保存。 | 《04-TT-L3-ATS-AA-2v0.pdf》69–72（印刷 63–66），图 5.13–5.16。 |
| 光纤连接板激光输出检查与光路调整 | FAT／故障诊断及机械调整。确认红绿光功率和耦合。 | 直接输出为光功率和机械调整量。PM 灵敏度、谐振频率是前置 MC。 | 功率计按波长分别测 FCP。功率不足时区分激光源、衰减轮位置、光纤耦合。按 Venturi 光斑和功率优化 X/Y/Rx/Ry，必要时调整 PM 的 XY。 | 《04-TT-L3-ATS-AA-2v0.pdf》73–75（印刷 67–69）、146（印刷 140），图 5.17–5.20、7.1。 |
| BMAA 粗校 | 校准。建立测量侧平台／基准板坐标，使 AA、TIS 和后续对准能捕获标记。 | WS 测量侧零位 X₀、Y₀，各板粗 TRM。Rel.3.4 明示 TIS2、ILIAS 的平移。Rel.3.2 报告另有 WS TIS1、TIS2、Abbe、CS 基准板的 Translation X/Y、Rotation Rz、Magnification M。 | 自动版用螺旋搜索捕获，再以 X 段 WQ 横切曲线定位 Y、Y 段定位 X。对照理论重叠曲线求相关函数导数零点并检查 WQ、相关系数和拟合质量。早期版先用相机找 3×3 CMXPA 中心、确认 I／AC／CS 标记，再用 AA 扫描测定。 | 《TT-MA-ME_setupblock_1-5_1v3.ppt》33–39，《12-TT-L3-L3-ME_book.pdf》37–42，《13_AP-L1-ME_rel_3.2.pdf》30–38。 |
| BMAA 精校 | 校准。以正式对准位置细化平台零位与基准板坐标，并在上游坐标或读出条件变化后重测。 | 双 chuck 的 TIS1／TIS2 基准板 TRM、WS X₀、Y₀。带 ILIAS 的版本包括 ILIAS，带 ACM／CSCM 的旧版包括 Abbe／CS TRM。 | 已能自动捕获后，在每块板已知位置扫描 fiducial，测值与板局部名义值比对，更新平移、转角和倍率。旧版精校省去 CMXPA 粗找。 | 《TT-MA-ME_setupblock_1-5_1v3.ppt》40–41、46，《TT-MA-ME_setupblock_6-8_1v3.ppt》29、58，《04-TT-L3-ATS-AA-2v0.pdf》122（印刷 116），《13_AP-L1-ME_rel_3.2.pdf》39。 |
| 载波相位 | 电子校准。让 Hinds 板载波参考和 ODB 的调制信号同相。 | 每块 ODB 的 carrier phase。按板写入，编辑器全键名待查。 | BMAA 粗校后，将 AO 标记放到 OM 下。比较各 ODB 第 0 通道的光电信号和参考，电子式调相。必要时微移平台避开信号低谷，再保存。 | 《04-TT-L3-ATS-AA-2v0.pdf》82–85（印刷 76–79），图 5.26。 |
| 晶圆质量信号归一化 | 校准。统一各颜色、方向、衍射级次的信号强度量尺。 | 各级次 WQ `Normalization Factor`（NF）。课件以理想标记的一阶红光 WQ=100% 为基准。 | AGC、载波相位和 BMAA 粗校后，对 Abbe chuck 的 TIS1/FTBU1 取对准扫描。按已知线空比、刻蚀深度和反射率计算理论 WQ，比较实测与理论，更新每级次 NF。 | 《04-TT-L3-ATS-AA-2v0.pdf》86–95（印刷 80–89），图 5.28–5.30。 |
| 衍射级次间偏置（粗校、精校） | 校准。压低改变对准 recipe 所用级次带来的标记位置差。 | 各颜色／方向／级次的 Shift Between Orders。绿色三阶为位置参考。 | 扫描 FTBU 得各级次位置，选择最接近预期位置的绿色三阶峰作参考。先单次粗校预防选错周期，再多次精校。初校与复测依 AA setup 顺序安排。 | 《04-TT-L3-ATS-AA-2v0.pdf》96–102（印刷 90–96）、120（印刷 114），图 5.32–5.33。 |
| 对准触发延迟（粗校、精校） | 校准。使运动位置样本和经电子滤波的强度样本同步。 | 按颜色／方向／级次的 `Trigger Delay`（µs）。低通截止频率为既有只读 MC。 | 正、反向等速扫同标记，由表观位置差换算延迟。选最接近期望的周期峰，粗扫写入合格通道后重复精扫。超差通道保留原值。 | 《04-TT-L3-ATS-AA-2v0.pdf》112–119（印刷 106–113），图 5.48–5.50。 |
| CABF 对准光束倾角和焦点 | 校准。分离 AA 光学离焦的倾斜敏感性与平台 XY 干涉测量的 Abbe 项。 | AA 最佳焦高、对准光束倾角。交点斜率还给出绿色七阶对应的 Abbe 臂观测量。WS 干涉仪模型由 WTAF 更新。 | 对专用七阶 mark 扫 Z，拟合 WQ 对焦曲线峰值为粗焦。对长和短 mark 在不同 Z 下施加平台倾斜，拟合“对准位置—倾角”斜率随 Z 的两条曲线，交点横坐标给最佳焦。随后做 WTAF，再复验 CABF。TIS2 V3 标记或专用 LS/AA 工具晶圆。 | 《04-TT-L3-ATS-AA-2v0.pdf》103–111（印刷 97–105），《TT-MA-ME_setupblock_1-5_1v3.ppt》42–43，《12-TT-L3-L3-ME_book.pdf》43。 |
| 最佳 ATM 标记位置 | 旧版含 CS／ACM 的校准。让 ATM 透过的光在 AA 探测器上达到可用最大值。 | ATM 最佳位置，MC 键名待查。 | 确认 ATM 光可到达 OM 探测器，寻找最大强度的标记位置，再进入 Abbe 臂校准。Rel.3.3.7/3.3.8/3.4 的去 CS 流程使用 CABF。 | 《13_AP-L1-ME_rel_3.2.pdf》29，《04-TT-L3-ATS-AA-2v0.pdf》57、103–106（印刷 51、97–100）。 |
| 配合 ATM 的 Abbe 臂 | 旧版校准。用独立 Abbe Calibration Module 分离平台转动造成的表观 XY。 | XY IFM 模型的 Abbe 臂（X/Y 对台面倾转的耦合系数）。 | 用 ACM 的 ATM 作为独立于 AA 成像焦面的标记，已知高度下改变平台姿态并测对准位置，确定 Abbe 耦合，供 AA 焦点测试使用。 | 《04-TT-L3-ATS-AA-2v0.pdf》103–106（印刷 97–100），《13_AP-L1-ME_rel_3.2.pdf》29。 |
| 对准焦点粗／精校 | 旧版校准。在 Abbe 臂已知时使 AA 光学模块焦点及倾角合适。 | AA 最佳焦面及光束倾角，字段名待查。 | 先做 ATM 和 Abbe 臂，再改变对准高度和平台倾角分粗、精阶段定位光学焦面。相关的 Verify Alignment Focus & Tilt 使用同类扫描，仅检查各级次带宽。 | 《04-TT-L3-ATS-AA-2v0.pdf》57、103–106、121（印刷 51、97–100、115），《13_AP-L1-ME_rel_3.2.pdf》29。 |
| MTOC 标记类型相关级次偏置 | 标记校准。统一不同 wafer mark、颜色和级次相对于参考 mark 在参考级次的读出位置。 | 各 mark type × 色 × 级 × X/Y 的 Mark Type Offsets。窄标记扩展对应项。 | 双 chuck 加载与机型、OM 类型相符的 200/300 mm 校准晶圆和 recipe，扫 XPA 及其他标记并与参考比较，检查双 chuck 报告后保存换型偏置。通常在出厂或更换 OM、TIS 板或 ILIAS 后进行。 | 《04-TT-L3-ATS-AA-2v0.pdf》124–125（印刷 118–119），《TT-L2-ATS-3v0.pdf》12–16。 |
| 对准复现性、首扫效应、衰减与焦高／倾角检验 | 资格验证／诊断。 | 各级次的对准 3SD、WQ、MCC、偏移与通过状态。Verify Alignment Focus & Tilt 明示不保存 MC。 | csal052.per 在 FTBU1、FTBU2 和 wafer mark 重复扫描并比较第一次与随后读数。衰减用 FTBU1 逐级降低激光强度，检查噪声与动态范围。焦高／倾角检验使用标记扫描查各级次是否在带宽内。 | 《04-TT-L3-ATS-AA-2v0.pdf》121、126–136（印刷 115、120–130），《TT-L2-ATS-3v0.pdf》50。 |

XPA 是一种标记结构。常规 8.0 µm 和 8.8 µm 光栅用于粗精捕获和位置解算。具体校准由 BMAA、WQ、SBO、MTOC、AA 触发或曝光成像测试执行。来源《TT-L2-ATS-3v0.pdf》12–16。

### TIS、曝光侧光轴与漂移参考

| 项目 | 类型与目的 | 校准的机器常数或输出 | 主要流程 | 原文件及文件页 |
| --- | --- | --- | --- | --- |
| 模式及缺省增益检查 | 设置／前置检查。确认 TIS 真实硬件和扫描参数生效。 | ID、IF 的 Simulation mode 与缺省 `coarse PGA gain`。MC 编辑器中其他接受阈值依测试和版本核对。 | 设 ID/IF 为 real，核对 IF/ID MC，按机型设置缺省增益，再运行硬件检查。 | 《05-TT-L3-TIS-2v0.pdf》36–40（印刷 30–34），《TT-MA-TIS-3V1.ppt》33–36。 |
| 硬件检查（csis006.per） | 验证。确认各 TIS 光栅／ratio 探测器和信号链工作。 | 探测器暗／照明信号。`General.Minimum signal strength grating sensor` 与 `General.Minimum signal strength ratio sensor` 是已设验收 MC。 | 在 open-field 条件对各探测器比较暗输出和照明输出，按探测器类别检查有效信号与差别。 | 《05-TT-L3-TIS-2v0.pdf》41–43（印刷 35–37），《TT-MA-TIS-3V1.ppt》38–41，《TT-L2-ATS-3v0.pdf》52。 |
| 可编程增益（粗、精） | 校准。提高图像信号信噪比并避免削顶。 | `Sensor intensity.PGA Gain Tis{1,2} Chuck{1,2}`，各板 `Sensor intensity.Calibrated maximum intensity Tr/Trp/Tra …` 等 ratio 信号常数。精校还确定 ratio 目标信号。 | 各探测器扫 PGA 档位测暗电流。以 Setup scans 粗估，再用多个标记的 FineHorVert 精测。扣除暗输出后选择增益，进行新增益验证和 ratio 标定。 | 《05-TT-L3-TIS-2v0.pdf》44–46（印刷 38–40），《TT-MA-TIS-3V1.ppt》43–50。 |
| DUV 采样触发延迟 | 校准。使激光脉冲后的强度采样处于前放信号峰值。 | `TIS trigger delay Tis1 Chuck1`、`TIS trigger delay Tis2 Chuck1`、`TIS trigger delay Tis1 Chuck2`、`TIS trigger delay Tis2 Chuck2`（µs）。接受门限为单独测试常数。 | Open field、PGA 0 dB 时扫不同 delay。找各探测器响应峰，按每板六个探测器求平均，复查各强度及延迟差。 | 《05-TT-L3-TIS-2v0.pdf》47–51（印刷 41–45），《TT-MA-TIS-3V1.ppt》52–60。 |
| TIS FineHorVert 复现性（csis007.per） | 验证。低 NA 供 BMIS 前资格检查，高 NA／多照明设置供 ATP。 | XYZ 平均与 3SD。验收 MC 名 `FHV repro spec x`、`FHV repro spec y`、`FHV repro spec z`。 | 在不同标记、照明设置和各 TIS 板重复 25 次精扫。计算每次对准位置并判定散布。低 NA 先检查，高 NA 在像差设定后检查。 | 《05-TT-L3-TIS-2v0.pdf》52–53（印刷 46–47），《TT-MA-TIS-3V1.ppt》62–64，《TT-L2-ATS-3v0.pdf》51。 |
| Spot Sensor 位置、光学高度和有效直径 | 照明校准及曝光侧起始光轴参考。RS 零偏和照明顶部精调依赖此参考。 | WS 坐标下的 SS XYZ、有效光学直径（早期课件明示），正式 MC 键名待查。此阶段使用已有 WS 零偏，之后 BMIS 用新零位改算 SS 位置。 | 装 Lens Top Tool，以投影镜头机械基准建立中心孔。用 DUV 找中心孔像的最大强度和最佳高度。保存 SS 几何位置。直径校准的详细边缘拟合步骤在引用页未展开。 | 《10-TT_L3_IP_2v1.pdf》67–68（印刷 59–60），图 2.23–2.25，《TT-MA-ME_setupblock_1-5_1v3.ppt》48–49，《13_AP-L1-ME_rel_3.2.pdf》26，《12-TT-L3-L3-ME_book.pdf》20、47。 |
| BMIS 粗校（BMTIS Coarse） | 校准。把 reticle align 与 RS fiducial align 带入细标记捕获区。 | RS-TIS 与 RS-ZERO／适用机型 RS-ILIAS 的粗 TRM。内容以 XY 定位、转角和倍率为主。 | 两台用 `BA-ME-TIS-setup` 的 RH1/RH2、RS-TIS 的 TH1/TH2 及适用 ZH1/ZH2 等长 hook 标记扫描。求初始 TRM。课件的 hook 长约 4 mm，XY 捕获约 ±2 mm，Z 捕获约 300 µm。捕获范围与精校的高度输出是两个概念。 | 《12-TT-L3-L3-ME_book.pdf》67–68，图 2.52–2.53，《TT-MA-ME_setupblock_1-5_1v3.ppt》95–97，《13_AP-L1-ME_rel_3.2.pdf》47–52。 |
| BMIS 精校（BMTIS Fine） | 校准。将曝光侧平台坐标、对准基准板和成像参考精确关联。光焦面改变后需重做。 | 接受焦面基准的曝光侧 WS X₀、Y₀、SS 位置、RS-TIS 及 RS-ZERO／RS-ILIAS TRM、适用 影像传感器光栅高度以及 fiducial 高度／Ry 倾斜。 | 扫标定掩模 R1–R4、RS-TIS T1/T2、适用 Z1/Z2。将 TIS 参考板平移归入 WS 零偏，转角与倍率归入板 TRM。用各影像传感器测标记像更新高度。BMWZ 里有调用，独立 BMIS 仍存在。 | 《12-TT-L3-L3-ME_book.pdf》63–68、87、104，《TT-MA-ME_setupblock_1-5_1v3.ppt》95–97，《TT-MA-TIS-3V1.ppt》66–68。 |
| BMIS Capture 模式 | 恢复模式。缩小 BMIS 写入范围，保持原有成像精校参考。 | 仅写 WS 零位、SS 位置。课件注明 RS 相关 MC、TIS 光栅高度和平行传感器位置不更新，BAO/BFO 保持原值。 | 使用同类 BMIS 扫描并选择 Capture。只提交可恢复捕获的零位和 SS 校正。 | 《TT-MA-ME_setupblock_1-5_1v3.ppt》96，《12-TT-L3-L3-ME_book.pdf》65。 |
| XVSA 建立 TIS 漂移参考 | 参考值校准。建立每台 TIS 板的初始形貌／倾斜，供批次开始及日常 stage align 跟踪漂移。 | TIS1/TIS2 的高度与倾角参考、LS 倾斜及相关 Zero Sensor 参考更新。正式键名待查。 | 在 WS Fiducial Leveling 的附加流程，九个 LS 光斑沿 X 扫过 TIS mark，保存板面曲线，计算参考。每批前两片分别做双 chuck XVSA，后续用九光斑静态测量与最新参考比对，修正曝光侧 reticle align。 | 《12-TT-L3-L3-ME_book.pdf》61–62，图 2.46，《TT-MA-ME_setupblock_1-5_1v3.ppt》84–87。 |

### Level Sensor（LS）与旧式 Confidence Sensor（CS）

| 项目 | 类型与目的 | 校准的机器常数或输出 | 主要流程 | 原文件及文件页 |
| --- | --- | --- | --- | --- |
| PEMM–DAM 延迟 | 调平电子校准。补偿 PEMM（光弹调制模块）与 DAM（采集模块）链路的群延迟，使采样落在正确相位。 | 报告 MC id `PEMM DAM delay [M]`，ns。报告还给有效捕获／测量光斑数及准确度。 | 用静止的裸超平晶圆，在给定延迟步进读取各 C／M spot 的 AC/DC，做相位回绕换算，合成有效 spot 的平均延迟，检查偏差与准确度后保存。 | 《07-TT-L3-LS-2v0.pdf》26–29（印刷 20–23），图 3.1–3.2，《TT-L3-LS-3v0.ppt》31–34。 |
| ELLA（LS–AA 中央光斑偏置） | 校准。无 CS 流程在测量侧把 LS 中央 M4 光斑水平位置连至 AA。 | `LS-AA (X)`、`LS-AA (Y)`（µm）。 | 先用 Orthobox 建立工具晶圆的 AA 坐标，用 M4 测参考区与梯形斜坡，按 0°/180° 和 90°/270° 重装反转，减除参考区、拟合半高交点并组合两组结果。以反转减少晶圆及镜面形貌误差。 | 《07-TT-L3-LS-2v0.pdf》34–38（印刷 28–32），图 4.2–4.5，《TT-L3-LS-3v0.ppt》39–42，《TT-MA-ME_setupblock_1-5_1v3.ppt》77–80。 |
| ELLN（LS Linearity） | 校准。给 LS 高度信号的测量、伺服与捕获通路提供换算。 | 测量光斑 M0–M8 的 measure coefficients a₁ … a₅、servo coefficients a₁ … a₃、capture spot Gain。相对于 M4 的各光斑 Z 零值也在该步骤产生。 | 双 chuck 各装裸超平晶圆，校好 PEMM–DAM 后用捕获 spot/M4 定初始位置并垂直扫描，以 Z 干涉仪为参考获取原始 LS 数据。拟合各通路并检查残差、增益符号、单调性和范围后保存。培训例的测量、repair、servo/capture 范围分别是约 ±1.25、±2、±2.5 µm。 | 《07-TT-L3-LS-2v0.pdf》39–45（印刷 33–39），《TT-L3-LS-3v0.ppt》43–45，《TT-MA-ME_setupblock_1-5_1v3.ppt》17、71。 |
| ELGE（LS 光斑三维位置） | 校准。确定八个非中央光斑相对 M4 的有效位置，降低高度读数随台面倾斜而变。 | 报告 `X-Calib`、`Y-Calib`、`Z-Calib` 下 `SPOT[0..8]`，M4 为基准。 | ELLA 与测量侧 WZTD 完成后，在超平裸晶圆上保持 XY，分别改变 Rx/Ry，根据各 spot 的高度—倾斜斜率求 Y/X。读取相对 Z、复扫验证 XY 及 Z，核查 3σ 后保存。 | 《07-TT-L3-LS-2v0.pdf》46–49（印刷 40–43），图 4.7，《TT-L3-LS-3v0.ppt》46–52，《12-TT-L3-L3-ME_book.pdf》61。 |
| 旧式 CS 线性化 | 旧版传感器校准。允许 Z 干涉模型等测量使用 CS 零点之外的高度读数。 | 高度信号线性化量。资料未给出可确认的键名或拟合系数。 | 旧流程先用 CS 零输出做粗定高，较晚在线性化后再用于 Z 残差映射。课件未给可独立复现的步骤细节。 | 《13_AP-L1-ME_rel_3.2.pdf》17、24、62–63。版本界线见《TT-L2-LS-3v0.pdf》10、30。 |
| 旧式 CS spot position／CSCM | 旧版传感器空间校准。把 CS 测量位置连到测量侧 AA、曝光侧透镜，从而给 Z 干涉模型提供共同参考。 | 测量侧 CSCM 相对 AA 的位置、曝光侧 CS 相对镜头的 XY，以及 CS 的倾斜不变参考。键名待查。 | 先 BMAA/BMIS 确定所在基准板，再用 Abbe/CSCM 的 CSCM 模块建立 CS spot 位置及倾斜参考。之后用两侧 CS 定高度、测不同 Rx/Ry/Rz 的高度差以校干涉模型。3.3.7/3.3.8/3.4 的去 CS 流程换成 ELLA→WZTD 和曝光侧 WGTD 链。 | 《07-TT-L3-LS-2v0.pdf》32–34（印刷 26–28），图 4.1，《13_AP-L1-ME_rel_3.2.pdf》17、30–31，《TT-L2-LS-3v0.pdf》10、30。 |
| Level Sensor Performance Qualification（csls008.per） | 验证。检查调平链的稳定、响应及既有校准。 | 资格流程明示不保存 MC。报告示例 `Acquisition Delay` 有既有固定 MC 与正反扫测得的新值，新值只供查看。 | 核查模拟偏置、适用 AT 上的 PEMM 自动校准、PEMM–DAM、采集延迟、捕获/M4 偏置、AC/DC、光斑符号、位置与倾斜、线性与重复性等。版本不同，个别子测试不适用或未实现。 | 《07-TT-L3-LS-2v0.pdf》50–61（印刷 44–55），《TT-L2-LS-3v0.pdf》27，《TT-PM-LS-3v1.pdf》39–40，《10-TT-L2-LS-module.pdf》28。 |

### ILIAS、镜头像差与热像差设定

| 项目 | 类型与目的 | 校准的机器常数或输出 | 主要流程 | 原文件及文件页 |
| --- | --- | --- | --- | --- |
| SZPI 像素校准（csis011.adj） | 传感器校准。建立像素灵敏度、暗电流／坏像素图，并选择优先 ROI。 | 每像素校正量、坏像素清单及 preferred ROI，有效键名待查。资料证实坏像素和像素灵敏度值存为 MC。 | 两个曝光积分时间下在无光时测暗电流。改变衰减档测响应，以 fiducial mark 将光点投到相机不同位置得到相对灵敏度。检查线性、坏像素簇和可用 ROI，整体 OK 后保存。 | 《TT-L2-ILIAS-3v0.pdf》26–28，图 2.1–2.3，《13-TT-L2-ILIAS-module.pdf》20，《06-TT-L3-ILIAS.pdf》22–23、28，《10-TT_L3_IP_2v1.pdf》86。 |
| ILIAS Dose & Region of Interest（csis012.adj） | 传感器校准。达到高信噪比且避开削顶／缺陷像素。 | SoMo 标记的最佳衰减档与积分时间，RS fiducial 源标记的一个绝对、其他 27 个相对剂量，各 ROI 尺寸与坐标。 | 像素校准和 BMIS 后，用已登记的校准掩模改变脉冲强度（衰减）与数量（积分时间），找到相机目标信号，再确定靠近 preferred ROI 中心的各 ROI。较新 L2 版本要求整体 OK 后保存。 | 《TT-L2-ILIAS-3v0.pdf》29，《TT-PM-ILIAS-3V1.pdf》37–38，《13-TT-L2-ILIAS-module.pdf》21。旧 L2 讲义的保存指示有文本矛盾，以对应机型 Coach 为准。 |
| ILIAS 扫描重复性（csis041.per） | 验证。确认 SeMo 给出的 Zernike 读数可复现。 | 按 Z₅–Z₃₇ 输出 OK/NOK。规格来自既有 MC。 | 剂量和 ROI 校好后装 SoMo，按机型执行重复扫描和结果验收。 | 《TT-L2-ILIAS-3v0.pdf》30，《13-TT-L2-ILIAS-module.pdf》22。 |
| SZFO 基准板 Zernike 偏置 | 转移校准。把 fast ILIAS 的 fiducial 结果连到 SoMo reticle 标准。 | 七个 fast field points（1、3、5、7、9、11、13）× Z₅–Z₂₅ 的偏置表，MC 键名待查。 | 同一场点以 SoMo II 两行（R2/R3）各多次读出并平均。基准板做快扫平均。按场点与项计算两者差，复核 reticle ID 与结果。书中示例为每行每点 5 次，fiducial 每点 25 次。 | 《06-TT-L3-ILIAS.pdf》8–10（印刷 2–4），图 1.2–1.4，《TT-MA-ILIAS-3V1.ppt》27–32。 |
| EMZC ILIAS Lens Setup 与镜头像差资格检查 | 成像校准和资格。用现机波前与镜片灵敏度决定 NEXZ/SAXY 可校部分，压低球差及彗差等。 | 各狭缝位置的波前/Zernike 及镜元修正量，报告分别给 Current、After Correction 和 Deltas 的 NEXZ／+SAXY／Both。BIF 是来源数据，MC 编辑器键名待查。AT:1200 的 SAXY 专用模型需四片镜元各自的 X、Y 共八个可调量。 | RS 初始高度合适后，以 SoMo+SeMo 的侧向剪切干涉做帧扫描、在狭缝 13 位置拟合波前。比较调 NEXZ 与加 SAXY 的残差降幅，选择实施校正并复查。焦面改变后重做 BMIS fine。 | 《TT-MA-ME_setupblock_6-8_1v3.ppt》19–29，《12-TT-L3-L3-ME_book.pdf》75、79–87，图 2.67–2.81，《TT-MA-ILIAS-3V1.ppt》17–26，《08_AP_L2_LAB_1v0.pdf》85（印刷幻灯片 84）。 |
| TAMIS Coarse XY／Fine XY（Me5BaTaXyFin.ADJ 为精校 Coach 名） | 旧式离线成像校准，在机用 TIS。用于无 ILIAS 的适用机型降低彗差。 | 测 Z7_0、Z8_0、Z7_1。按机型，XY offset 由 MMU/PMU 镜元机械修正，X coma tilt 以 “Save MCs” 应用透镜模型修正。 | 在 BA-ME-TIS-SETUP 上扫不同照明下的标记像 X/Y。由相对位移求两向彗差，先 Coarse XY 捕获，再 Fine XY 求 offset 与 tilt，按报告实施并复测。 | 《08_AP_L2_LAB_1v0.pdf》89–97、99–112、121–122（印刷幻灯片 88–96、98–111、120–121），《11_AP-L1-IQC.pdf》28–30，《12-TT-L3-L3-ME_book.pdf》79。 |
| TAMIS Fine Z（Me5BaTaZFin.ADJ） | 旧式离线成像校准，在机用 TIS。以焦高变化测球差。 | Z9_0 偏置用于适用机型的 “Save MCs”。另读 Z12 横纵像散。报告实例列 KI 的 Reticle Stage Height、Lens Element 1、Lens Element 2、Lens Element 3、Wavelength Shift，以及 MI 的 Reticle Stage Height。不同机型和选项影响写入内容。 | 在不同照明下测标记最佳 Z，用焦高差推球差、横纵焦差推像散。应用镜头模型得各设定点修正。Rel.3.2 及以前的 TAMIS 可选 “Perform RS Height Correction”，Rel.3.3 将 RS 初始高度移至独立测试，并用另行加载的 PMI 数据修正高阶像差影响。 | 《08_AP_L2_LAB_1v0.pdf》97、101–112、121–122（印刷幻灯片 96、100–111、120–121），《11_AP-L1-IQC.pdf》28–30，《12-TT-L3-L3-ME_book.pdf》75、79、112。 |
| Lens Heating in Resist | 镜头热漂移模型校准。通过抗蚀剂图形读取 F、FC、M，以及配 ALE 机型的 astigmatism offset。 | 每个可校成像参数的一或两指数模型时间常数 （τ₁、τ₂）（不随照明设定变化）和比例 （μ₁、μ₂）（随照明设定）。报告字段示例见该课件。 | 预置默认或已标定热模型。用 LH reticle 在两片上交替曝光 16 个 FOCAL 图形与 15 个 dummy。显影后 FOCAL/DISTO 读位置，模型阶段使用曝光 testlog。默认三照明设定，先用第 1 设置拟合时间常数和比例，其他设置只更新比例。 | 《17_AP_L2_LH_v1.pdf》6–13、17–24、44–49。 |
| Lens Heating using TIS（csme119a.adj） | 不用显影的镜头热漂移模型校准。按机型可覆盖 `F`、`FC`、`M`、`D3`、`Z7_1`、`Z9_0`、`A`、`AC`。 | KI 热模型的 `Tau1`、`Tau2`（s）和 `Mu1`、`Mu2`。用机型决定每项一／两指数。recipe 的 wafer reflectivity correction factor C_f 独立于前两类参数。 | 热负荷用同类 LH reticle 在裸晶圆多次曝 dummy，在每组前用 TIS 取像。AT:400/750 以 FHV 扫 RS-TIS 基准，AT:850/11x0 以 HapVap 类扫描取更完整像差。保存 testlog，在三个标准设置先整体拟合再固定时间常数求其他比例。TIS 曝光阶段可从无既有热模型开始。第 37 页 90 mJ/cm² 是 HEAT_1 recipe 示例。 | 《17_AP_L2_LH_v1.pdf》7–13、25–49，尤其 30、33–34、37、41–46。 |

### 照明、剂量与投影执行器

| 项目 | 类型与目的 | 校准的机器常数或输出 | 主要流程 | 原文件及文件页 |
| --- | --- | --- | --- | --- |
| Beam Delivery／Beam Expander 粗调 | 光机设定。让发散和束径符合底部模块入口要求，供精调捕获。 | 各折转镜和扩束镜位置。培训页给机械调整和实测束形／束径。 | 沿各转折点对准下一靶心。通过 Beam Qualification Tube 的栅格窗观察束形和束径，移动扩束镜片以满足入口束径。 | 《13_AP-L1-ME_rel_3.2.pdf》26，《10-TT_L3_IP_2v1.pdf》56–64、130。 |
| Top Module／Bottom Module 相对光机设定 | 粗／精机械调整。把照明狭缝与投影镜头光轴和远心状态对齐。 | 顶部模块相对透镜的 X/Y/Z/Rx/Ry/Rz 与底部模块校位、间隙。软件报告给调整量。 | 透镜机械基准下调整顶、底。精调以已标定机械 Z sensor 测间距，以 Spot Sensor 测位置与转角，以远心性测倾角。按 TESA 读数调顶、再对底到顶。旧工具以 Gap Tool 校 TESA 零位。 | 《13_AP-L1-ME_rel_3.2.pdf》26，《10-TT_L3_IP_2v1.pdf》58–60、69–74、128（印刷 50–52、61–66、120），图 2.27–2.32、3.22–3.23。 |
| Automatic Beam Positioning | 粗校。定激光束在 Zoom Axicon 入口方向与位置。 | Position/Pointing mirrors 设置及对应 BMU 四路读数，MC 键名待查。 | 改变可调镜并发射 DUV，读 Energy Sensor 和 BMU 的 PSD，使 BMU 读数趋于 (0,0,0,0)，将镜设置存为机器常数。 | 《10-TT_L3_IP_2v1.pdf》20–21、62（印刷 12–13、54），图 2.15，《13_AP-L1-ME_rel_3.2.pdf》26。 |
| Variable Attenuator（VA） | 剂量控制校准。建立衰减器角度到透过率的转换。 | 衰减片转角—透过率查找表。 | 扫描衰减器位置并测相对光能形成标定表。也可在 ADT 检查手动校准功能。 | 《13_AP-L1-ME_rel_3.2.pdf》26，《10-TT_L3_IP_2v1.pdf》21–24（印刷 13–16）。 |
| Spot Sensor 剂量换算／matching | 传感器标定。将晶圆侧探测器的 ADC 计数换算为剂量。 | DO 的主探测器 `Spot Sensor Conversion Factor (SSCF)`。非主探测器换算值从 lookup table 取得。 | 主 SS 换件后与外部参考传感器对测标定。非主 SS 换件后走 ADT 匹配，校换算和两传感器一致性。 | 《10-TT_L3_IP_2v1.pdf》28–30、151（印刷 20–22、143）。 |
| Energy Sensor 剂量校准 | 剂量校准。把上游每脉冲信号转换为对应实际晶圆面剂量。 | `Energy Sensor Conversion Factor (ESCF)` 随 NA、ZA、DOE 组合的表和时间戳。`ESCF Calibration Validity Period` 是控制重标时间的既有 MC（资料示例 6 h）。 | ES 与已标 SS 对测，按 pupil shape 定换算以吸收各照明光路的透射差，ES 换件再校并验证 ratio。有效期届满可由软件自动重校。 | 《TT-L2-IP-3v0.pdf》23，《10-TT_L3_IP_2v1.pdf》28–30、140（印刷 20–22、132）。 |
| ES/SS ratio 稳定性及脱水稳定 | 前置验证／准备。避免传输不稳成为照明校准误差。 | 固定场点上 ES/SS 比值稳定度和透射稳定指标。相关校准的前置结果。 | SS 固定镜心，用 REMA 围近减少杂光，在 0×0 场重复发脉冲并评估 ratio。不稳定时使用脱水队列与对称均匀性重复性判据。 | 《10-TT_L3_IP_2v1.pdf》65–66、96（印刷 57–58、88），图 2.20–2.22，《13_AP-L1-ME_rel_3.2.pdf》26。 |
| THFFC（Transmission Hysteresis Feed Forward Correction） | 剂量补偿模型校准。补偿 193 nm 曝光后可恢复的光学透过率变化。 | Spot／Energy Sensor、Integrator Rod、REMA Lens、Projection Lens 各自的透射滞后激发和恢复模型参数。键名待查。 | 初装标定各件，换件时只重测相应件。等待旧滞后衰减后按脉冲能量、重复频率、照明模式和空闲时间构建激发／恢复关系，供剂量前馈使用。 | 《10-TT_L3_IP_2v1.pdf》94–95、140、150（印刷 86–87、132、142），图 2.69。 |
| REMA offset | 几何校准。定义各挡光叶片零点与光轴的对应。 | REMA blade offsets。课件以结果屏展示，各机型编辑器键名待查。 | SS 放在场中心，移动叶片扫光暗跃迁，找照度 50% 位置并设相应叶片偏置。更换或移动 REMA 后复做。 | 《10-TT_L3_IP_2v1.pdf》75、144（印刷 67、136），图 2.33–2.34，《13_AP-L1-ME_rel_3.2.pdf》26。 |
| REMA gain | 几何校准。建立编码器计数与晶圆面叶片阴影位移的比例。 | 每片叶片的 REMA gain。 | 叶片分别到 A、B，SS 扫各边缘得到晶圆面位移，以位移除对应编码器步数，逐片求增益并保存。 | 《10-TT_L3_IP_2v1.pdf》81（印刷 73），图 2.46–2.47，《13_AP-L1-ME_rel_3.2.pdf》26。 |
| REMA 半影与 Z 调整 | 光机校准及验证。找到遮挡刃口的最佳像面，同时确保 integrator rod 到叶片的机械安全间隔。 | Penumbra 宽度与 REMA Z 调整处方。输出以机械高度调整和复测为主，未确认独立写入键名。 | SS 找到 25%/75% 两点量半影。超差或更换时在边缘附近扫 Z 找强度峰定位叶片最佳像，再扫／外推 rod 半影定位 rod，计算间距及 Z 处方并复测。 | 《10-TT_L3_IP_2v1.pdf》76–79、117（印刷 68–71、109），图 2.35–2.43，《04-TT-L2-IP-module.pdf》77。 |
| REMA Spring Force | 伺服校准。补偿 Y 叶片位置相关驱动力与摩擦。 | 两 Y 叶片驱动力—位置表，保存在 internal REMA MC，初始化下载控制器。 | 按给定速度正反全程驱动叶片，记录电机力随位置的关系，双向合成减轻方向差。有／无弹簧配置均见课件。 | 《10-TT_L3_IP_2v1.pdf》80（印刷 72），图 2.44–2.45。 |
| REMA condenser lens tilt | 机械定位。降低晶圆面曝光 slit uniformity 的 X 倾斜。 | 聚光镜倾角调整量与调整后的照明均匀性。 | 先测 Slit Uniformity，按报告对投影侧聚光镜施加规定方向的机械修正，再验收。 | 《10-TT_L3_IP_2v1.pdf》82（印刷 74），图 2.48，《13_AP-L1-ME_rel_3.2.pdf》26。 |
| Slit Profile（狭缝轮廓） | 剂量校准。用实际轮廓得曝光控制有效宽度。 | `Effective Slit Width`。Rel.3.2 另提 `profile uniformity correction factor`。 | 在狭缝中部沿扫描方向线扫，取与实际曲线面积相同的等高矩形宽度，供剂量控制。更换匀光棒后重做。 | 《10-TT_L3_IP_2v1.pdf》83、112（印刷 75、104），图 2.49–2.50，《TT-L2-IP-3v0.pdf》30，《13_AP-L1-ME_rel_3.2.pdf》26。 |
| Beam Fine Adjustment／Best Beam Per DOE | 光束精校。降低晶圆面均匀性倾斜随光瞳设定变化。 | 各适用 DOE 的 Position/Pointing mirror 设置（`BBPD` 表在 UIP 章节出现）。 | 改变可调镜及光瞳设定，测 slit uniformity，选让不同设定总体差异最小的镜位置／方向并保存。DOE 路径不同，按适用 DOE 分别校。 | 《10-TT_L3_IP_2v1.pdf》96、106–107（印刷 88、98–99），图 2.70，《13_AP-L1-ME_rel_3.2.pdf》26。 |
| UNICOM 校准与 blade／gradient filter determination | 照明均匀性校准。按设定用滤光片补偿狭缝 X 向对称分量。 | DOE/σ 对应 UNICOM blade 位置表。若现有片能力不足，可依据测试确定 blade／gradient filter 系数供订件。 | 一组固定瞳形改变 blade 位置测 X profile，得到相对 profile 矩阵。再按 DOE 改 σ 测实际 profile，选择预计均匀性最优的位置并保存及验证。老机型无适用 UNICOM 时用梯度滤片。 | 《10-TT_L3_IP_2v1.pdf》44、96–102、129、150（印刷 36、88–94、121、142），图 2.71–2.78，《13_AP-L1-ME_rel_3.2.pdf》26。 |
| PUPICOM 校准（1250 ILIAS。早期机型 dipole blades/SS） | 光瞳校准。降低椭圆率及水平、垂直成像差。 | 各照明模式的 Pupicom angle 设定表、可校范围与残差。 | ILIAS 测多种光瞳和数个 blade angle，通过拟合／查表选使椭圆率最小的角度。早期流程用 REMA lens 的横／竖 dipole blades 和固定 SS 点读出相对强度并求椭圆率。 | 《10-TT_L3_IP_2v1.pdf》102–106、115–123（印刷 94–98、107–115），图 2.79–2.84，《13_AP-L1-ME_rel_3.2.pdf》26。 |
| LUUP（Uniformity Improvement Package） | 联合校准。协同 beam pointing、UNICOM 和 PUPICOM 优化照明均匀性。 | `BBUP` 表，按光瞳存 beam position/pointing、UNICOM position、PUPICOM angle 等。MC 编辑器 `Modify/UL/Uniformity Improvement Package`。 | 从 UNICOM 表起步，改变 pointing 测 slit uniformity，提取最佳 pointing 后写组合表，在该 pointing 下重标 PUPICOM，并检查不同瞳形是否都在许可范围。 | 《10-TT_L3_IP_2v1.pdf》106–111（印刷 98–103），图 2.85–2.92。 |
| Slit Uniformity、Dose System Performance、Dosemapper | 各为资格验证。在相同名义剂量或不同校正模式下确认曝光均匀性／剂量误差。 | Integrated Slit Uniformity/Intensity、剂量准确及复现性、修正前后剂量轮廓。上述项输出性能结果。 | SS 在晶圆面按网格取样并用 ES 归一，沿扫描方向积分。ODAR 做常规扫描曝光并比对标称剂量。Dosemapper 用开／关校正两幅全场剂量轮廓比理论。 | 《TT-L2-IP-3v0.pdf》81–85、105–112、136，《TT-PM-IP-3v1.pdf》81–82、101–109，《10-TT_L3_IP_2v1.pdf》112、126–127。 |
| Pupil shape／ellipticity | 瞳形资格及 PUPICOM 的上游测量。 | 光瞳填充、内外 σ、圆度／椭圆率、适用模式的光极方向。取决于 pupil mode。 | 用掩模 pinhole，在晶圆面离焦使瞳图展开。TIS 步进组图（csil121.per），ILIAS 相机直接采样（csil153.per）。旧版用 dipole blades＋SS。 | 《TT-L2-IP-3v0.pdf》74–75、86–91，《TT-PM-IP-3v1.pdf》83–88，《10-TT_L3_IP_2v1.pdf》84–93、117–124、133。 |
| Firefly／SAMOS／Kirk 杂散光 | 设定验收与监测。测小尺度或长程非预期曝光。 | 杂散光百分比／分布。三种测法各自的读出及基准条件需随原报告。 | L1 将 Firefly 作为初始和月度测量列出。SAMOS 用 TIS ratio 读多尺寸遮光方块下强度。Kirk 方法用两片抗蚀剂上的高低剂量图形和清胶剂量判定。 | 《13_AP-L1-ME_rel_3.2.pdf》26，《TT-L2-IP-3v0.pdf》99–104，《TT-PM-IP-3v1.pdf》95–100，《04-TT-L2-IP-module.pdf》78–81。 |
| AT:400 汞灯 XYZ 与强度（csil037.adj。旧讲义号码不同） | 适用 UV 机型的光源位置校准。最大化 SS 量到的光强。 | 灯的 X/Y/Z 最佳位置，存 MC，重新初始化 DO。 | 等灯稳定后，以 SS 记录 Z 粗扫、X、Y、Z 精扫强度，逐轴拟合峰值并写入。较旧 Level 2 的抬头写 csil027.adj，后版写 csil037.adj。 | 《04-TT-L2-IP-module.pdf》89，《TT-L2-IP-3v0.pdf》133–134，《TT-PM-IP-3v1.pdf》131–132。 |
| AT:400 汞灯温度及冷却量（csil038.adj、csil039.adj） | 适用 UV 机型的光源运行点调整。稳定温度和效率。 | 热电偶目标温度、冷却水／空气温度压力流量及调节量。无证据显示这些量作为成像 MC 保存。 | 已调到最佳灯位后热稳态，按热电偶反馈调阳极冷却气。冷态流程用 PTI 读温、压、流量确认冷却回路，再回到灯温校验。 | 《04-TT-L2-IP-module.pdf》90–91，《TT-L2-IP-3v0.pdf》134–136，《TT-PM-IP-3v1.pdf》132–134。 |
| 旧式 Z-manipulator 执行器低位（cspir001.adj） | 换件后的执行器机械初设。进入有效闭环范围。 | 对应镜元机械最低位和预抬位。课件给机械调整与传感读数，MC 键名待查。 | 用连续 Z 读数定位。旧／新马达分别以微调机构或螺帽抬至指定低位附近并锁紧，做位置误差／servo 性能复验。 | 《10-TT_L3_IP_2v1.pdf》155–160（印刷 147–152），图 5.4–5.9，《TT-MA_IP_projection_actions_3V1.ppt》13–19。 |
| XY 镜元操控器利用 TAMIS／FOCAL/DISTO 调校 | 成像机械调整。以镜元位移补偿指定像差。 | 旧版主要为 Z7_0、Z8_0 修正量。850D 多镜元还使用 Z2_2、Z3_2、Z5_1、Z6_1 等目标，并记录 induced Z9_1。 | TAMIS 先测像差。适用单镜元机用 PMU 调 LE3 并 TAMIS 复测。850D 结合 FOCAL/DISTO 推导系数，按限值选择 LE3 或 LE1–3，以 PMU 调整并重测。 | 《10-TT_L3_IP_2v1.pdf》166、169–171（印刷 158、161–163），图 5.28–5.30，《TT-MA_IP_projection_actions_3V1.ppt》22、33–43。 |
| NEXZ/SAXY/ALE 换镜后载入标定（cspr017.adj） | 换镜设定。使镜头专属执行器数据生效。 | 新镜头的 NEXZ、SAXY 和 ALE settings。 | 更换镜头后按 Coach 载入对应镜头的设置，再执行后续压电标定和动作检查。训练页仅列出依赖步骤。 | 《04-TT-L2-IP-module.pdf》83。 |
| PIPC 压电功放容量（cspr022.adj，早期材料抬头另记 csil022.adj） | 执行器校准。让 NEXZ/SAXY 压电驱动与各压电组电容匹配。 | 压电功放各 clamp/transducer 组的容量及上下限参数，报告保存新 MC。 | 对 NEXZ、SAXY 分别运行 Piezo Capacity Calibration，逐组测 Clamp/Trans 结果，核对对应区间后保存。早期 L2 第 83 页抬头与同书第 85 页引用号不一致。 | 《04-TT-L2-IP-module.pdf》83–85，《TT-L2-IP-3v0.pdf》95，《TT-PM-IP-3v1.pdf》91。 |
| NEXZ Index Pulse Amplitude（cspr023.adj） | 执行器回零链校准。为 shuffle-to-zero 验证提供正确索引脉冲振幅。 | NEXZ lens elements 的 index-pulse amplitude，键名待查。 | 资料把其列在 PINZ 的前置校准。具体操作未展开。 | 《04-TT-L2-IP-module.pdf》85，《TT-L2-IP-3v0.pdf》95，《TT-PM-IP-3v1.pdf》91。 |
| PISS SAXY Sensor Functionality & Range | 诊断及可选范围校准，适用于换镜等需要重定机械工作区时。 | 报告字段 `X_max Y_centre`、`Y_max X_centre`、`X_centre`、`Y_centre`（µm）。只做功能项给传感器比值。 | 单动 X，检查因 X/Y 夹角非正交产生的 dY/dX。选 Determine Range 后扫至工作区边界，得到中心和最大行程，按需要存 MC 并回到原位置。 | 《10-TT_L3_IP_2v1.pdf》191–193（印刷 183–185），《TT-MA_IP_projection_actions_3V1.ppt》82–89。 |
| 投影执行器资格（PINZ／PIPD／PINS，及旧式 Z/ALE 位置误差） | 验证。分别查回零残差、运动精度／滞后和传感器噪声。 | 剩余压电驱动电压、位置／压力误差、波形及噪声等结果指标。 | PINZ 多个 Z 高度 shuffle-to-zero 后读残余电压。PIPD 以阶跃／波形比实际位置。PINS 检查各传感通道稳定性及换步响应。旧件 cspir003.per 检测位置／压力误差。 | 《10-TT_L3_IP_2v1.pdf》159–160、172–173、177–193，《TT-L2-IP-3v0.pdf》92–98，《TT-MA_IP_projection_actions_3V1.ppt》47、54–80。 |

### 核对的原图

ELLA 工具晶圆布局（本机原图 `参考文献/Markdown_v1/assets/f4bceaf9c8a8c568/images/page_34_image_4_v1.jpg`）

- ELLA 图画出了同片上的参考条带、带梯形坡的轮廓条带、Orthobox 和 notch。可由此区分 AA 用的坐标标记和 LS M4 实际扫描的形貌，理解 180° 反转后为什么仍能以同片参考区扣除背景。来源《07-TT-L3-LS-2v0.pdf》，文件第 35 页（印刷第 29 页），图 4.2。

BA-ME-TIS-SETUP 标定掩模（本机原图 `参考文献/Markdown_v1/assets/37317c0531c59e0e/images/page_67_image_11_v1.jpg`）

- BMIS 掩模图的 RH hook 由顶侧箭头标出，R1–R4 位于掩模两侧的四个角区。图本身区分出两套空间标记。粗校用 hook 扩大捕获范围，精校再用 R1–R4 测位置及像高。来源《12-TT-L3-L3-ME_book.pdf》，文件第 68 页（印刷第 60 页），图 2.53。
- CABF 图先画绿色七阶在不同 Ry 下的对准位置拟合斜率  c，再画 Mark 74 与 Mark 74N 的斜率随高度的交点。后图由横轴读焦高、纵轴读绿色七阶 Abbe 臂观测量。来源《04-TT-L3-ATS-AA-2v0.pdf》，文件第 108 页（印刷第 102 页）。倾斜拟合图（本机原图 `参考文献/Markdown_v1/assets/220652e52c1294b9/images/page_107_chart_10_v1.jpg`） · 长短标记交点图（本机原图 `参考文献/Markdown_v1/assets/220652e52c1294b9/images/page_107_chart_17_v1.jpg`）
- XVSA 图在 TIS1 version 1 板上画出 LS 扫描线及 M0/M4 等标志。它说明各 spot 在共同区域建立实际板面轨迹，为后续倾角漂移比较提供基准。来源《12-TT-L3-L3-ME_book.pdf》，文件第 61 页（印刷第 53 页），图 2.46。扫描位置图（本机原图 `参考文献/Markdown_v1/assets/37317c0531c59e0e/images/page_60_image_16_v1.jpg`）
- ILIAS 原图依次画 SoMo、投影镜头、SeMo 和相机芯片，也区分了物面、瞳面和晶圆面，说明镜头像差由完整光学链的干涉数据求出。来源《12-TT-L3-L3-ME_book.pdf》，文件第 81 页（印刷第 73 页），图 2.69。光路图（本机原图 `参考文献/Markdown_v1/assets/37317c0531c59e0e/images/page_80_image_5_v1.jpg`）
- 装 Lens Top Tool 的原照片可辨认标有垂直安装方向的 Spot Sensor 定位孔径件，说明 SS 位置先用镜头上的实体基准转移到晶圆侧。REMA gain 图画出光轴两侧的 A/B 与各自扫描小窗，解释为何计算对两位置差取比例。来源《10-TT_L3_IP_2v1.pdf》，文件第 67、81 页（印刷第 59、73 页），图 2.23、2.46。镜头顶部工具照片（本机原图 `参考文献/Markdown_v1/assets/486ca54167488ec6/images/page_66_image_7_v1.jpg`） · 叶片位置图（本机原图 `参考文献/Markdown_v1/assets/486ca54167488ec6/images/page_80_image_7_v1.jpg`）

- TAMIS 的 XY 和 Z 测量结构在课件同图中分别标出。另一张 Z7 图把中心 offset、跨狭缝 tilt 和校准后的残余形状画在同一坐标中，说明镜元偏置修正与跨场模型修正针对的是两个量。来源《08_AP_L2_LAB_1v0.pdf》，文件第 95、101 页（印刷幻灯片第 94、100 张）。三组 Z7 迹线（本机原图 `参考文献/Markdown_v1/assets/9f27ebdec60c9f03/images/page_94_image_1_v1.jpg`） · XY、Z 标记图（本机原图 `参考文献/Markdown_v1/assets/9f27ebdec60c9f03/images/page_100_image_1_v1.jpg`）
- Lens Heating reticle 原图示出透光区及 FOCAL/OV 在同一掩模左侧 F–F–OV、右侧 OV–F–F 的排布，用来说明抗蚀剂方式的两类读出来自不同测量标记。来源《17_AP_L2_LH_v1.pdf》，文件第 20 页。热漂移标定掩模（本机原图 `参考文献/Markdown_v1/assets/431054a5ab571a8c/images/page_19_chart_0_v1.jpg`）

在当前资料全文未辨认出独立的 FADU、Confocal Sensor 或题名为 baseline calibration 的 TWINSCAN 测校流程。文档明确写有旧式 **Confidence Sensor**。涉及曝光侧坐标建立或漂移的已证实步骤为 Spot Sensor 位置、BMIS 和 XVSA 等，具体适用版本见对应行。

## 晶圆搬运、掩模搬运、减振支撑与公用温控

本节页码为原 PDF 文件页码或原 PPT 幻灯片序号，从 1 开始。表中保留资料使用的代码和报表字段。未见具体机器常数键名时，列出来源证实的校准量。涉及机型、选件或发布版本的条件随条目注明。

### 晶圆搬运 WH

PU 为预对准单元，DU 为卸料单元，CH 为载具搬运单元，WS 为晶圆台。主流程是 HWZQ →（有 Track 时 HWTS）→ HWPP → HWDR → HWPB → HWPR →（有 CH 时 HWCI → HWCR → HWCZ）→ HWPU → HWDZ → HWPZ → HWWZ → HWWR（Load Robot）→ HWWE → HWWR（Unload Robot）→（有 Mark Sensor 时 HWMG → HWMX → HWMC）。早期教材在 HWZQ 前还列 HWZV。外部校准在 WH 重新与底座耦合后执行。左右配置决定 CH 侧使用哪只机器人。见《03-TT-l3-WH.book.pdf》第 94–97 页、《03-TT-l3-WH.book II.pdf》第 104–107 页、《TT-MA-WH_cleanroom-procs.ppt》第 12 张、《TT-PM-WH-3v1.pdf》第 42–56 页。

| 项目 | 目的 | 校准的机器常数或量 | 流程 | 原文件与页码 |
|---|---|---|---|---|
| HWZV 真空零点（旧版） | 消除 WH 真空读数基线误差，保证夹持判定 | WHPU 真空传感器零压偏置，键名未列 | 不施加真空，用 WHPU 真空传感器读残余正负压，将读数作生产真空值偏置。2004 版已注明将淘汰，2005 版主流程移除此框。 | 《03-TT-l3-WH.book II.pdf》第 105、108 页。《03-TT-l3-WH.book.pdf》第 95–96 页 |
| HWZQ 腕部四象限传感器 X 零位 | 定义机器人腕部的相对位移零点，供触探及对接校准 | 四段暗/亮读数（bit）用于计算 `Quad-cell X` 零位（mm）及有效位，分别适用于选中的上下片机器人 | WH 初始化。LED 关闭读取暗值，再在照明下读四象限，软件计算并报告各腕部 X 零位，确认后保存。 | 《03-TT-l3-WH.book.pdf》第 98–100 页。《TT-MA-WH_cleanroom-procs.ppt》第 14–19 张 |
| HWTS Track 接片 | 建立外部 Track 到 WH 的交接点 | WT 交接 X/Y。键名未列 | 有 Track 才在 HWZQ 后执行 Track Take-over 校准，再进入 HWPP。给定资料只列顺序与量，触发和测量细节未载。 | 《03-TT-l3-WH.book.pdf》第 95、97 页。《03-TT-l3-WH.book II.pdf》第 105、107 页。《TT-MA-WH_cleanroom-procs.ppt》第 12 张 |
| HWPP PU 未对接 R/φ | 让上下片夹具都对准 P-chuck 中心 | 各机器人的 PU undocked `R`（mm）、`Phi`（mrad）及有效位 | WH 初始化，已知四象限零点。沿径向和方位方向多次轻触 P-chuck 的边，腕部四象限检测触碰，约 5 轮接触拟合中心，报告、确认保存。 | 《03-TT-l3-WH.book.pdf》第 100–102 页。《TT-MA-WH_cleanroom-procs.ppt》第 20–26 张 |
| HWDR DU 未对接 R/φ | 让上下片夹具都对准 DU 中心 | 各机器人的 DU undocked `R`、`Phi` 及有效位 | 两只机器人分别用腕部四象限检测沿径向/方位对 DU 边缘的轻触，多轮取点求 DU 中心并保存。 | 《03-TT-l3-WH.book.pdf》第 102–104 页。《TT-MA-WH_cleanroom-procs.ppt》第 27–33 张 |
| HWPB PU 对接下方 Z（仅上片） | 让腕部钩与 docking interface 轴承正确搭接，确定 Below_P 基准 | 上片机器人 `Below_P` docking Z（mm）及有效位 | 夹具置于对接接口上方，向下微步移动，直至腕底 VSO（Vane Switch Oscillator）检测到对接板，存 Z 并出报告。 | 《03-TT-l3-WH.book.pdf》第 104–106 页。《TT-MA-WH_cleanroom-procs.ppt》第 34–39 张 |
| HWPR PU 已对接 R/φ（仅上片） | 确定夹具在接片低位的对接坐标，保持预对准结果 | 上片机器人 PU docked `R`、`Phi` 及有效位 | 完成 HWPB，把对接单元放在 Below_P。夹具从名义位置靠近接口，在多个位置小步接触并看腕部四象限响应，求 R/φ。 | 《03-TT-l3-WH.book.pdf》第 106–108 页。《TT-MA-WH_cleanroom-procs.ppt》第 40–44 张 |
| HWCI CH 库存传感器 | 确认晶圆槽位高度，使 CH 可以准确报片和估计交接 Z | `Distance D`（传感器 1↔2）、`Distance A`（2↔3，仅 200 mm）、`Slot 1 Position`、`Wafer Pitch` 及有效位 | 2005 版用 FOUP 第 1–12 槽装 12 片，升降时用库存传感器激光反射逐片扫描，求槽与传感器几何量。2004 版列第 1、25 槽，随所用机型流程执行。 | 《03-TT-l3-WH.book.pdf》第 108–110 页。《03-TT-l3-WH.book II.pdf》第 111–112 页。《TT-MA-WH_cleanroom-procs.ppt》第 45–51 张 |
| HWCR CH 交接 R/φ | 找出机器人夹具相对 CH 晶圆中心的平面位置 | CH 交接 `R`、`Phi` 及有效位 | Indexer 移到空校准槽。夹具扫描孔移动到 CH robot-detect 光束下，径向与顺/逆方位扫孔边，算中心并保存。WH 左配置适用 Load Robot，右配置适用 Unload Robot。 | 《03-TT-l3-WH.book.pdf》第 110–113 页。《TT-MA-WH_cleanroom-procs.ppt》第 52–57 张 |
| HWCZ CH 交接 Z | 确定夹具在 CH 的取放片高度 | CH 交接 `Z`（mm）及有效位 | Indexer 移到校准槽，选侧机器人将夹具侧面特征与库存传感器 1 对齐，上下扫描光束通断，保存交接 Z。 | 《03-TT-l3-WH.book.pdf》第 113–115 页。《TT-MA-WH_cleanroom-procs.ppt》第 58–64 张 |
| HWPU PU 未对接 Z | 定义 PU 与上下片机器人的交接高度 | 两只机器人 PU undocked `At_P Z`（mm）及有效位 | 带晶圆下行，PU 真空达到夹持阈值时记 Z1。切换真空，机器人带片上行，机器人真空达到阈值时记 Z2。以 (Z1+Z2)/2 写值。旧版用 PAPU 读真空，MK2 用 WH-PU MK2。 | 《03-TT-l3-WH.book.pdf》第 116–117 页。《TT-MA-WH_cleanroom-procs.ppt》第 65–70 张 |
| HWDZ（部分标题写 HWDU）DU 未对接 Z | 定义 DU 与上下片机器人真空交接高度 | 两只机器人 DU undocked `At_DU Z`（mm）及有效位 | 机器人取片至 DU。下降并切换 DU 真空，以 DU 夹持阈值得 Z1。上升并恢复机器人真空，以机器人夹持阈值得 Z2。保存 (Z1+Z2)/2。 | 《03-TT-l3-WH.book.pdf》第 118–119 页。《03-TT-l3-WH.book II.pdf》第 113 页。《TT-MA-WH_cleanroom-procs.ppt》第 71–75 张 |
| HWPZ PU 已对接 Z（仅上片） | 使对接状态下上片机器人与 P-chuck 在正确高度交片 | 上片机器人 PU docked `At_P Z`（mm）及有效位 | 先做 HWPB 和 HWPR。抬对接单元并带片对接，监视四象限，分别以 PU 和机器人真空夹持事件记 Z1、Z2。保存 (Z1+Z2)/2 + 0.2 mm。部分标题沿用 Below_P 字样，正文和报告校的是最终交接 Z。 | 《03-TT-l3-WH.book.pdf》第 120–121 页。《TT-MA-WH_cleanroom-procs.ppt》第 76–81 张 |
| HWWZ WS 外部对接 Z | 获取每只机器人相对每个 WS chuck 对接板的高度 | Load/Unload × chuck 1/2 的 `Z`（mm）及有效位 | 初始化 WH、WS。选择机器人和 chuck。相应机器人移至装/卸位置后向下，用腕底 VSO 找到 WS 对接板高度。报告核查并保存。 | 《TT-PM-WH-3v1.pdf》第 42–45 页。《05-TT-L2-WH-module.pdf》第 42 页 |
| HWWR WS 外部对接 R/φ，上片变体 | 找到带对接轮的 Load Robot 对两个 chuck 的对接平面位置 | Load Robot × chuck 1/2 的 `R`（mm）、`Phi`（mrad）及有效位 | 完成 HWWZ，第一次单选 Load Robot。在已校准 Z 空夹到 WS，用对接轮接触 docking plate，腕部四象限检测相对位移，储存 R/φ。 | 《TT-PM-WH-3v1.pdf》第 46–50 页，图 8.6 |
| HWWE WS 顶针交接 Z | 校准 E-pins 与两只机器人、与晶圆台 E-table 的交片高度 | chuck 1/2 的 Load Robot、Unload Robot 及 E-table 的 E-pins Load/Unload heights（mm）和有效位 | 完成 HWWZ 及上片 HWWR。选择 chuck、机器人、测试片源和去向。E-pins 升到带片夹具附近，真空事件确定交接高度，读取并保存报告。完成后做下片 HWWR。 | 《TT-PM-WH-3v1.pdf》第 48、53–56 页。《03-TT-l3-WH.book II.pdf》第 114 页 |
| HWWR WS 外部对接 R/φ，下片变体 | 找到没有对接轮的 Unload Robot 对两个 chuck 的交接平面位置 | Unload Robot × chuck 1/2 的 `R`、`Phi` 及有效位 | 完成上片 HWWR 和 HWWE，第二次仅选 Unload Robot。从 CH/Track 取片到 PU 测偏心作粗调，再用已校准上片机器人把片放 WS。WS 就位后下片机器人取回 PU 测偏心作细调。多循环验证并保存。 | 《TT-PM-WH-3v1.pdf》第 46–52 页，图 8.7。《TT-MA-WH_cleanroom-procs.ppt》第 12 张 |
| HWMG 预对准标记传感器网格 | 校正 Mark Sensor 镜头/CCD 成像，使图像坐标能恢复为实际标记坐标 | SBIP `Px, Py grid` 多项式（报表含 `Px0…Px6`、`Py0…Py6` 示例）、X/Y FOV、阵列有效标志 | 使用校准晶圆，边缘传感器对心后转网格入视场作粗网格拟合。再用 Mark Sensor 建 WCS 并与 MSCS 对齐，转回网格作精拟合，保存系数和 FOV。 | 《03-TT-l3-WH.book.pdf》第 122–124 页。《TT-MA-WH_cleanroom-procs.ppt》第 82–92 张 |
| HWMX 预对准标记传感器 X 导轨 | 在全径向测量范围校正 X 导轨的曲折和角偏差 | X-guide table（`MSCS(x)` → `MSXGCS(x)` 与 angle）、有效位 | 校准片经边缘预对准，旋转并使其相对中心偏置 5 mm，利用名义 C6 将径向标记行转入视场。走 X 导轨逐点测标记，缺测点线性插值，存位置与角查表。 | 《03-TT-l3-WH.book.pdf》第 125–128 页。《TT-MA-WH_cleanroom-procs.ppt》第 93–97 张 |
| HWMC 预对准标记传感器 C6 | 求 Edge Sensor 与 Mark Sensor 坐标系相对转角，使边缘预对准能预测标记位置 | `C6 offset`、`C6 total`（mrad）及有效位 | 用校准晶圆对心，在两传感器分别量 notch。把 ES 的 notch 角换到 MS 坐标，比较角差，以 C6 nominal − C6 offset 得 C6。 | 《03-TT-l3-WH.book.pdf》第 128–130 页。《TT-MA-WH_cleanroom-procs.ppt》第 98–101 张 |
| BMWL 粗校（BM-WL coarse，双 chuck，csme102.adj） | 使预对准后的晶圆标记进入 AA 捕获范围，避免扫描周期选错 | 各 chuck 静态晶圆装载偏置 X/Y 平移、Rz 旋转。校准片自身的 GWCS→WCS 偏置是已知输入 | 装载有两个已知 XPA 标记的校准片，按片盒录入标记坐标和 GWCS→WCS 偏置。依次用 AA 相机和摇杆将 W1、W2 居中确认，此阶段只用相机。比较真实与名义位置，算两只 chuck 的 X/Y/Rz，保存 MC。 | 《13_AP-L1-ME_rel_3.2.pdf》第 40–42 页。《TT-L2-ME-3v0.pdf》第 60–61 页 |
| BMWL 精校（BM-WL fine，双 chuck，csme102.adj） | 测量并消除晶圆重装平均偏心及转角，验证装载重复性 | 每个 chuck 的 `Static wafer load offset` X/Y（µm）、Rz（µrad），报告列旧/新值和 3SD | 在 BMAA fine、BMWL coarse 后，录入同一校准片标记坐标和 GWCS→WCS 偏置，应用已有装载常数，反复卸片、装片、自动扫描对准。对实际值与现有静态及动态偏置预测的残差取均值来更新双 chuck 常数，检查 3SD。示例输入 `Nr of Fine Wafer Swaps` 为 5。 | 《13_AP-L1-ME_rel_3.2.pdf》第 43–45 页。《TT-L2-ME-3v0.pdf》第 60–61 页 |

WH 的 Edge Sensor 在 setup 资料中视为已校好。常规现场 setup 直接沿用该原有边缘传感器校准。原资料未列该校准的独立代码、MC 或采样步骤。BMWL 是 WH 与 WS 装载接口的计量 setup。见《13_AP-L1-ME_rel_3.2.pdf》第 23 页、《12-TT-L3-L3-ME_book.pdf》第 21–22 页。

已核对原图：

- 《03-TT-l3-WH.book.pdf》第 95 页图 9.2 给出 Track、CH、Mark Sensor 的选件分支。它能区分 HWPB 的 Below_P 位与 HWPZ 的带片交接高度，后者在分支合流后执行。流程图（本机原图 `参考文献/Markdown_v1/assets/3b6bbd2eb5560447/images/page_94_image_4_v1.jpg`）
- 《03-TT-l3-WH.book.pdf》第 108 页 CH 剖示图给出两只 Inventory Sensor 在载具通道的分布，红箭头示意扫描光路。解释 HWCI 为何由纵向扫片导出相对偏置 D 与槽位节距。CH 库存传感器图（本机原图 `参考文献/Markdown_v1/assets/3b6bbd2eb5560447/images/page_107_image_13_v1.jpg`）
- 《TT-PM-WH-3v1.pdf》第 47 页图 8.6 给出上片夹具两接触轮与 WS docking plate，第 48 页图 8.7 给出双机器人与 PA、DU、CH、WS 的搬运关系，对应两套 HWWR 原理。上片直接对接（本机原图 `参考文献/Markdown_v1/assets/954e3ea2d3237b6a/images/page_46_image_8_v1.jpg`） · 下片往返验证路径（本机原图 `参考文献/Markdown_v1/assets/954e3ea2d3237b6a/images/page_47_image_7_v1.jpg`）
- 《03-TT-l3-WH.book.pdf》第 123 页图 9.32 的 HWMG 界面明确列 Coarse Grid Measure、Fine Grid Measure 和 Save MCs。两段网格拟合界面（本机原图 `参考文献/Markdown_v1/assets/3b6bbd2eb5560447/images/page_122_image_6_v1.jpg`）


WH 校准流程与 Track、CH、Mark Sensor 选件分支。原图见《03-TT-l3-WH.book.pdf》第 95 页图 9.2。（本机原图 `参考文献/Markdown_v1/assets/3b6bbd2eb5560447/images/page_94_image_4_v1.jpg`）

### 掩模搬运 RH 与 RH–RS 接口

IPA 为机内预对准位置，ISL 为交换过程的中间高度位，LPA 为靠近掩模台的装载预对准侧，CCM0/1 为两个升降夹具。洁净室流程的顺序为 YRCO → YRLP（两个 Library 各自校）→ YRIP →（选件 YRPI、YRIR）→ RACE → ZTRI/ZTRL → ZTTU → YRIE 粗校 → ZTLE → YRIE 精校 → RS SSRZ → ZTLR → ZTTO。早期 MKI 还作 ZTTR。教材第 105 页的箭头区分必需流程和优先先做流程。SSRZ 校准 RH–RS 装载几何，在 RH 流程中是后续接口校准的前置条件。见《TT-MA-RH-cleanroom-procs.ppt》第 3、38、101、120 张及《02-TT-L3-RH-up.pdf》第 104–107 页。

| 项目 | 目的 | 校准的机器常数或量 | 流程 | 原文件与页码 |
|---|---|---|---|---|
| YRCO（旧资料 HRCO）机器人坐标系 | 建立机器人与 RH 框架的刚体关系及夹具 roll | RH/机器人 offset vector X/Y/Z（mm）、坐标系 Rz 和 gripper roll offset（mrad） | RH 初始化，T/F 传感器设触碰模式。夹具相对标尺正反旋转 ±2°，两保护条分别轻触平面，三轮取平均求 roll。触探标尺定位销 A/B 的 X/Y 和参考 Z 平面，求 X/Y/Z/Rz，报告后保存。 | 《TT-MA-RH-cleanroom-procs.ppt》第 5–16 张。《02-TT-L3-RH-up.pdf》第 5、105 页，图 7.1（csrh021a.adj） |
| YRLP（旧资料 HRLP）Library 位置 | 求 Library 前面板、链轮开口及 E-slot 对 RH 机器人的交接位置 | 每个 Library 的 X/Y/Z/Rz（上下交接和平移入口），报表项如 `YRLPAP_LIB1`，测量项如 `LIB0_RZ`、`LIB0_X`、`L0_S_Z` | 安装 Library reference tool、Cover present tool。升降机到第一载具交接位。机器人触探前板求角、链轮两侧/底部求开口中心与 Z、E-slot 上下和后端止挡求上下入口与交接点，两个库各作一次。 | 《TT-MA-RH-cleanroom-procs.ppt》第 17–29 张。《02-TT-L3-RH-up.pdf》第 5、124 页（csrh011a.adj） |
| YRIP（亦见 HRIP。PPT 第 30 张标题 IRIP）Turret port 位置 | 求名义 IPA 装载位置处转塔入口到机器人的几何关系 | 报表 `IPA robot position` 及 `Turret entry position` 中 X/Y/Z（mm）。入口 Rz 使用既定值 | RH 初始化，确认无掩模，T/F 触探。夹具先到 `TURPRTENT`，抬高 10 mm 触入口前面，随后伸入轻触上缘与左侧，计算并存储对应位置。 | 《TT-MA-RH-cleanroom-procs.ppt》第 30–37 张。《02-TT-L3-RH-up.pdf》第 5、105、124 页（csrh010a.adj） |
| YRPI IRL 位置（仅有选件） | 建立机器人访问 IRL 的位置 | IRL 目标站位置。分量与键名未载 | 在 YRCO 后执行 IRL Position Calibration。来源流程图给出顺序，未载该项触探顺序和计算方法。 | 《TT-MA-RH-cleanroom-procs.ppt》第 3、16 张。《02-TT-L3-RH-up.pdf》第 27、42、100、105 页 |
| YRIR IRIS 位置（仅有选件） | 建立机器人访问 IRIS 的位置 | IRIS 目标站位置。分量和键名未载 | 在 YRCO 后执行 IRIS Position Calibration。教材说明自动校目标站（包括 IRIS）时使用 T/F 传感器。站内触探顺序和计算方法未载。 | 《TT-MA-RH-cleanroom-procs.ppt》第 3、16 张。《02-TT-L3-RH-up.pdf》第 27、42、100、105 页 |
| RACE Library 载具交换高度 | 设置 Library 进行载具交换的 Z 高度 | 载具交换高度。键名与允差未载 | 洁净室流程把它列在机器人定位之后、转塔组之前。教材对更换 Library 零位传感器给出 Library Box Exchange Position Adjustment Workaround，未说明它与 RACE 的一一对应。 | 《TT-MA-RH-cleanroom-procs.ppt》第 3 张。《02-TT-L3-RH-up.pdf》第 105 页 |
| ZTTR 转塔锁止角（MKI） | 找到两个转塔工位能可靠落锁的编码器位置 | `CCM1_lock_at_IPA`、`CCM1_lock_at_LPA`、`Lock_calibrated` | 回零，转至首个约 +90° 工位，释放伺服后试锁，逐次小改角度直到无需再运动即可锁止，记录编码器。另一个工位重复。确认写入，初始化时 RH driver 下发转塔控制器。资料明确 MKI 适用，MK3 不用。 | 《02-TT-L3-RH-up.pdf》第 106–109 页。《TT-MA-RH-cleanroom-procs.ppt》第 38–45 张（csrh019a.adj） |
| ZTRI IPA LED 与四象限灵敏度 | 对 IPA 预对准照明及四象限响应作偏置/增益归一化 | IPA 两路 LED 电流、各四象限暗信号与相对灵敏度。IPA 键名未载 | 初始化 RH，选择 IPA、需要的 LED/校准项。第 70 张与 ZTRL 共用标题和功能，后续详细步骤用 LPA 示例讲 LED 扫流、暗读数及灵敏度归一化。 | 《TT-MA-RH-cleanroom-procs.ppt》第 3、70–81 张。《02-TT-L3-RH-up.pdf》第 105 页（csrh014a.adj） |
| ZTRL LPA LED 与四象限灵敏度 | 对 LPA 预对准照明及四象限响应作偏置/增益归一化 | `ALDQDC0`、`ALDQDC1` LED 电流（mA），`ALDQDC0_A…D`、`ALDQDC1_A…D` 各通道暗电流和归一灵敏度（同名报告项分两栏） | 初始化 RH、RS，RS 到 load position，确认四象限位置，选左/右 LED 从 0 mA 增流至上限或通道削顶。灭灯读各象限暗值，再点亮，以最强通道相对灵敏度 1.0 算其余通道，报告并保存。 | 《02-TT-L3-RH-up.pdf》第 115–120 页。《TT-MA-RH-cleanroom-procs.ppt》第 70–81 张 |
| ZTTU IPA/ISL 高度 | 使机器人和两个 CCM 在 IPA 交换掩模及转移到 ISL 时高度匹配 | `ipa_exchange_height[CCM0.CCM1]`、`isl_exchange_height[CCM0.CCM1]`（mm） | 校准掩模送 IPA 并预对准，CCM 先粗步下降触发柔顺传感器，再小步寻找三路均触发的高度，检查接触窗口。按编码器高度 +2.5 mm − 掩模厚度计算 IPA，ISL 同法，两个 CCM 分别存值。 | 《02-TT-L3-RH-up.pdf》第 109–112 页。《TT-MA-RH-cleanroom-procs.ppt》第 46–59 张（csrh015a.adj） |
| YRIE IPA 交接偏置粗校 | 由机器人预先补偿掩模在 CCM 旋转/搬运后到 LPA1 的 XY/Rz 残差，使其进入 RS 装载捕获范围 | 每个 CCM 的 IPA Exchange Offset 向量 X/Y（µm）、Rz（mrad） | 完成 YRLP、YRIP、ZTRI/ZTRL。带校准掩模至 IPA 对准并用旧向量放置。转到 LPA1（RS 上 7 mm）测残差并返回。迭代至 `abs(X), abs(Y) < 20 µm`、`abs(Rz) < 0.2 mrad`，默认 5 次验证取平均微调后存值。 | 《02-TT-L3-RH-up.pdf》第 121–124 页。《TT-MA-RH-cleanroom-procs.ppt》第 82–101 张（csrh012a.adj） |
| ZTLE LPA 交接高度 | 校准两个 CCM 在 LPA 侧将掩模交给 RS 的高度 | CCM0、CCM1 `LPA Exchange Height`（mm） | 初始化 RH、RS，RS 放到交换位，校准掩模送 LPA1。粗步 1 mm 下降碰触，再退 1 mm 小步 0.1 mm 探索。三柔顺传感器触发高度跨度应在 0.5 mm 内，确认接触掩模面，再以编码器值 +2.5 mm − 掩模厚度计算，每个 CCM 分别保存。 | 《02-TT-L3-RH-up.pdf》第 112–115 页。《TT-MA-RH-cleanroom-procs.ppt》第 60–69 张（csrh016a.adj） |
| YRIE IPA 交接偏置精校 | 使放到距 RS 更近的 LPA2 的实际掩模保持在精装载范围内 | 每个 CCM 的 IPA Exchange Offset 向量 X/Y/Rz，更新粗校同一组量 | 完成 YRIE 粗校及 ZTLE。IPA 对准按已有偏置交片，LPA1 由 RS 对准后降到 LPA2（RS 上 0.5 mm），用 LPA 测残差再返回。每个 CCM 重复 10 次取平均求新值，报告并保存。 | 《02-TT-L3-RH-up.pdf》第 124–128 页。《TT-MA-RH-cleanroom-procs.ppt》第 102–120 张（csrh012a.adj） |
| SSRZ RH Load Offsets / Fine RS Rotation Offset | 使掩模装载时相对掩模台平行、原点重合，并使镜头中心处的掩模像进入 TIS 捕获范围 | 掩模装载 X、Y、Rz 偏置及相关 RS 旋转偏置。以课件表述为准，后续 BM-TIS 可覆写 | 装载四个 spot-sensor targets 的校准掩模。移动晶圆台测左右 target 求掩模相对 WS 的角，再移动掩模台测前后 target 求掩模相对 RS chuck 的角。由 spot sensor 位置确认原点及角度，按差值更新装载平移与转角。 | 《TT-MA-ME_setupblock_1-5_1v3.ppt》第 58–60 张。《TT-MA-RH-cleanroom-procs.ppt》第 3、101、120 张 |
| ZTLR LPA–RS 坐标系 | 联结 LPA 预对准测量与 RS 坐标 | LPA 到 RS 的坐标系对应量，来源未列参数向量/键名 | RH–RS 接口在 SSRZ 后、ZTTO 前执行。原流程图将接口正式步骤标为 csrh018a.adj。当前资料未载拟合测点或运算次序。 | 《TT-MA-RH-cleanroom-procs.ppt》第 3、101、120 张。《02-TT-L3-RH-up.pdf》第 105 页 |
| ZTTO RH–RS 交接偏置 | 补偿掩模台最终接片前相对搬运系统的位置差 | RH–RS take-over offset。分量、键名未载 | 在 ZTLR 完成后作接口偏置校准（csrh020a.adj）。正常加载由 RS 完成 LPA2 的测量矢量差修正后再移此偏置。Level 1 资料也说明交接点校准关系到 RS chuck 真空接管和转塔释放，资料未载偏置求解。 | 《TT-MA-RH-cleanroom-procs.ppt》第 3、101、120 张。《02-TT-L3-RH-up.pdf》第 68、105 页。《13_AP-L1-ME_rel_3.2.pdf》第 28 页 |
| Robot Theta 2 Offset（服务，图示列名） | 在更换 T2 电机/编码器后重新建立肘轴基准 | Theta 2 offset。键名、形式和允差未载 | 原图绘有 T2 Motor & Enc. → Theta 2 Offset Calibration → Robot Initial Homing → Gripper Tilt → YRCO。具体采样与写入步骤未载。 | 《02-TT-L3-RH-up.pdf》第 28、105 页 |

已核对原图：

- 《02-TT-L3-RH-up.pdf》第 105 页图 7.1 显示 YRCO 后接 IRL/IRIS 和 Library/转塔流程，亦显示 YRIE 精校向 RS Reticle Load Offsets → ZTLR → ZTTO 的接口依赖。图中还有更换 T2 电机/编码器后的 Theta 2 偏置及其初始回零前置关系。RH 校准依赖图（本机原图 `参考文献/Markdown_v1/assets/88a7459534fa89d2/images/page_104_image_2_v1.jpg`）
- 《02-TT-L3-RH-up.pdf》第 116 页图 7.8 将 Q-cell 分为 A/B/C/D。报告按各段列暗电流与灵敏度，符合 ZTRL 同侧 LED 有四组响应修正。四象限分段（本机原图 `参考文献/Markdown_v1/assets/88a7459534fa89d2/images/page_115_image_5_v1.jpg`）


### 减振支撑 AM 与公用温控 C&T

| 项目 | 目的 | 校准的机器常数或量 | 流程 | 原文件与页码 |
|---|---|---|---|---|
| MART / csam003.adj Metro Frame 行程与工作点 | 以机械限位为基准，为计量框架保留水平及垂直可控行程 | AM1/2/3 各一个水平和一个垂直 setpoint，共六个（µm）。报告区分旧工作点、新工作点、差值、总行程。MC 键名未列 | 安装/总装时跑范围扫描，逐渐给 Lorentz 电机加驱动并记录 proximity sensor 至限位，采三处水平等高轮廓及 Z 上下限。水平按轮廓求最佳点并映射到三 AM，垂直按课件取下限上方约 200 µm。例规 Z 为 400–600 µm、X/Y 为 800–1400 µm。验收/维护对比旧点，差值 <20 µm 保持原值。无更换而变化 >20 µm 排查干涉或刚性短接，超过水平 100 µm 或垂直 50 µm 的教材情形需更新并重做受影响 WS/计量 setup。 | 《11-TT-L3-AM.book.pdf》第 46–52 页。《TT-MA-AM-PRO-3v1.ppt》第 12–18 张 |
| 水总管传感器偏置 | 将 MCW 主回路、MFCW 计量框架回路的总管测温与 LCW 镜头水参考对齐，供下一步温差比较 | `Sensor Offset CtMcwTempMs`、`Sensor Offset CtMfcwTempMs`（K），MC 文件也显示 LCW 参考 `Sensor Offset CtLcwTempMs` | 把 MCW/MFCW 总管温度传感器装入 LCW 总管，同温稳定后对比三个示值。按 LCW 传感器参考修正 MCW/MFCW 探头偏置并装回各自总管。测试菜单把 LCW、MCW、MFCW 都列作对象。温控原理中 LCW 是零基准、其柜体及探头偏置定义为零。 | 《01-TT_Lay_L3-2v0.pdf》第 18–19、30–31 页。《TT-MA-LAY-PRES-3v1.ppt》第 45、49–51、58 张 |
| 水柜温度设定偏置 | 补偿运输与换热差，使曝光单元端 MCW、MFCW 与 LCW 实际温度一致 | `Setpoint Offset MCWC`、`Setpoint Offset MFCWC`（K）。`Setpoint Offset LCWC` 为参考，镜头温控外环调节 LCW | 完成总管温度传感器比对后将探头放回。等水温稳定，以 LCW 总管为参考读取各回路实际温差，更新两个水柜 offset 并初始化 C&T 载入。自动测试显示进度、新值，成功后可确认保存。 | 《01-TT_Lay_L3-2v0.pdf》第 13–14、18–19、30–31 页。《TT-MA-LAY-PRES-3v1.ppt》第 45–51、58 张 |
| Clean Air Temperature Calibration，CAM 自动法 | 使洁净空气温度追随 LCW，而镜头外环继续决定 LCW 温度 | `Setpoint Offset ACC`（K）。洁净空气总管探头误差合并到该柜体偏置 | 稳定后用右 CAM 的 Temp-tune 传感器测 LCW 出水。暂停 ACC，再测出水温差以识别空气与水的换热。计算并用新偏置复启 ACC，稳定后复测微调，完成时确认保存。教材给约 1.5–9 h。Temp-tune 振动/机械缺陷导致的历史替代方案为 TSU。 | 《01-TT_Lay_L3-2v0.pdf》第 18–19、24–25 页。《TT-MA-LAY-PRES-3v1.ppt》第 52–58 张 |
| Clean Air Temperature Calibration，TSU 手动法 | 用独立传感器将晶圆入口处洁净空气与 LCW 经 TSU 形成的温度匹配 | 同一个 `Setpoint Offset ACC`（K） | 在稳定系统上，把同一 NTC 先贴 TSU 台侧测电阻，再置靠上片机器人上方 air shower 的洁净气流中，稳定后测第二个电阻。用 COACH 公式把差转换为 ACC 偏置，录入 MC。教材给出公式用途和测点，未刊公式系数。 | 《01-TT_Lay_L3-2v0.pdf》第 24–27 页。《TT-MA-LAY-PRES-3v1.ppt》第 52、56–58 张 |

已核对原图：

- 《11-TT-L3-AM.book.pdf》第 50 页图 2.12 的横纵轴为 X/Y 量程（µm）。青色 Limiter 2 近圆，黑色和紫色曲线在另一限位方向有截直边。因此水平最佳点依赖各限位组合，不能把三条轮廓当作三个同形圆分别取心。三限位器行程图（本机原图 `参考文献/Markdown_v1/assets/6e903d85e6858b9d/images/page_49_image_4_v1.jpg`）
- 《01-TT_Lay_L3-2v0.pdf》第 25 页图 3.3 显示 Temp-tune 在右 CAM 的 LCW OUT。ACC 开/关引起的 LCW 出水变化反映空气与水在换热器里的温差。CAM 换热与测温原理（本机原图 `参考文献/Markdown_v1/assets/63d5dd09d70a24d7/images/page_24_image_6_v1.jpg`）
- 《01-TT_Lay_L3-2v0.pdf》第 26 页图 3.4/3.5 是 TSU 台侧与 air shower 洁净气流的两处实物测点。它们用同一 NTC 先后比较。TSU 测点实物（本机原图 `参考文献/Markdown_v1/assets/63d5dd09d70a24d7/images/page_25_image_3_v1.jpg`） · Air shower 测点实物（本机原图 `参考文献/Markdown_v1/assets/63d5dd09d70a24d7/images/page_25_image_9_v1.jpg`）
- 《TT-MA-LAY-PRES-3v1.ppt》第 58 张原机软件画面为 `CT/CT_machine.const`，可以核对传感器偏置、柜体 offset 各行的名称和单位 K。截图中的 0.000 是该例显示值。温控常数界面（本机原图 `参考文献/Markdown_v1/assets/7a4ab8ae804a9c84/images/page_57_image_1_v1.jpg`）

CAM 洁净空气自动校准中，Temp-tune 传感器位于 LCW 出水端。原图见《01-TT_Lay_L3-2v0.pdf》第 25 页图 3.3。（本机原图 `参考文献/Markdown_v1/assets/63d5dd09d70a24d7/images/page_24_image_6_v1.jpg`）

### 相关机械调整、设定与验收

| 项目 | 目标 | 调整或验收量 | 流程 | 原文件与页码 |
|---|---|---|---|---|
| WH Rx 调平（cswh024a.adj） | 将 WH 对底座调平，以便与 WS E-pins 稳定交片 | WH 耦合状态 Rx 倾斜，机械调节 | 水平仪放指示面，解锁丝杠后以曲柄调整、锁紧，重新充分耦合检查。 | 《03-TT-l3-WH.book.pdf》第 131 页。《TT-MA-WH_cleanroom-procs.ppt》第 11 张 |
| TSU 高度/倾斜（cswh039a.adj）与 TESA 测具置零 | 使 TSU 相对 P-chuck 的盘面高度和倾斜在规格范围 | 三支柱处高差。TESA 工装零点。调整目标 22 ± 2 µm，锁紧后复验 22 ± 3 µm | TSU 抬起并定位。在 TSU ZERO PLATE 预先将 TESA 置零，再将探头定位到 P-chuck，真空夹紧，测三点，松夹、逐柱调螺钉，锁紧复量。 | 《03-TT-l3-WH.book.pdf》第 131–133 页。《TT-MA-WH_cleanroom-procs.ppt》第 7–10 张 |
| CH 载具 KCM 调整 | 确保 FOUP 在载具搬运机构上的安装位置及姿态 | KCM 高度 Z、倾角 Rx/Ry、X/Rz。机械调整 | 以半载 FOUP 等效的 KCM 工装作负载和参考面，气泡水平仪测倾斜，以相对迷宫板定位销检查高度及平面位置，按流程图调整。 | 《03-TT-l3-WH.book II.pdf》第 116–118 页 |
| RH Library Store Tilt / 载具交换位置 | 在搬运机械坐标求解前把 Library 和 Store Frame 调到可交换范围 | Library Ry、Storeframe Rx/Ry/Rz 与载具交接位。流程图单列更换零位传感器及顶层交换位置的 workaround | 先作 Library Store Tilt Adjustment（csrh003a.adj），再作 YRLP。YRLP 报告同时显示框架倾斜、链轮开口和前板到后挡差的机械验收。两个交换位置 workaround 的步骤未载。 | 《02-TT-L3-RH-up.pdf》第 105 页图 7.1。《TT-MA-RH-cleanroom-procs.ppt》第 25–29 张 |
| RH Robot/CCM 夹具倾角及转塔 X | 先建立机械装配，再使 YRCO/YRIP 具备稳定的接触面与入口几何 | 机器人夹具 Rx/Ry、CCM 夹具倾角、转塔 X。机械调整 | 机器人夹具用参考平面检查 Rx/Ry，如需调整用下方两螺钉并锁紧（图 7.1 标 csrh002a.adj）。CCM 倾角作为单独调节项列出。转塔 X 调整 csrh005a.adj 是 turret port/RH–RS 几何校准的前置。 | 《02-TT-L3-RH-up.pdf》第 4、12、37–38、105 页。《TT-PM-RH-3v1.pdf》第 64–65 页。《13_AP-L1-ME_rel_3.2.pdf》第 28 页 |
| RH 掩模检测光纤头与碰撞传感器 | 调整交换位置与突出检测的透射光束，以及夹具过载检测触发 | 光纤发/收头对准（Ry）。夹具碰撞 VSO 与触发螺钉位置 | 用 Ry 专用工装对准两套检测光路。碰撞 VSO 更换后以红 LED 状态检查弹簧板螺钉触发位置。 | 《02-TT-L3-RH-up.pdf》第 22–23、37 页 |
| RH HRPT 预对准重复性和时序 | 测量搬运链路重复性、阶段耗时和搬运周期 | 位置、迭代数与时间统计。性能验收 | 选择掩模、是否只测 IPA 或使用预装载。重复库到 RS 装/卸循环，比较 IPA/LPA1/2/3 等位置、迭代和时间。 | 《02-TT-L3-RH-up.pdf》第 128–133 页。《TT-MA-RH-cleanroom-procs.ppt》第 121–131 张 |
| AM Z-stroke（csam004.adj） | 让 Metro Frame 垂直机械行程回到要求 | 限位螺母到 Metro Frame 的间隙。机械调整 | MART 行程异常时使用塞尺测限位螺母与框架间隙，旋转螺母改变 Z 限位，再测 MART。 | 《11-TT-L3-AM.book.pdf》第 52–54 页。《TT-MA-AM-PRO-3v1.ppt》第 19 张 |
| AM 气源、传感器、电机与污染检查 | 验收独立部件，排查刚性短接或传感器链故障 | AM 气源（csam020.per）、气浮轴承（csam015.per）、proximity（csam038.per）、geophone（csam039.per）、motor DAC（csam006.per）。诊断量 | 气源检查临时调高 Dither gain，听阀口声并恢复原 MC。气浮检旋转阻力。手推框架并观察接近传感器或 geophone trace。用 Command Handler 看电机 DAC。 | 《11-TT-L3-AM.book.pdf》第 44–45、54–58 页。《TT-MA-AM-PRO-3v1.ppt》第 11、20–23 张 |
| AM MASA / MALF / MASP 与 PALM | 核验 AM 的响应、低频短接、静态位置与速度误差，以及主动减振/电子传递函数 | 传感器/执行器响应、位置误差与速度、振动抑制、PCAB 传递计算。性能验收 | MASA 分部件和框架动态检查，MALF 对低频响应和基准 fingerprint，MASP 记录位置速度并统计，PALM Performance 读镜头加速度计，PALM Transfer Function 用 PCAB 内建诊断。 | 《11-TT-L3-AM.book.pdf》第 59–66 页。《TT-MA-AM-PRO-3v1.ppt》第 24–34、36–37 张 |
| C&T 水柜安装维护、吹扫流量和供压检查 | 恢复正常水流/水温及吹扫气流 | 现场流量/压差/阀设定与柜体检查值 | 水柜测试可选柜与动作，依屏幕计算值做现场调节。洁净吹扫按总流量和分配阀调节。ACC 泵压差开关更换后检查设定。新版 REMA-C 的 NPU 调到供压要求。Filter Monitoring 工具录入配置与换件履历。 | 《01-TT_Lay_L3-2v0.pdf》第 28–34、43–45、50 页。《TT-MA-LAY-PRES-3v1.ppt》第 59–66 张。《03-TT-L2-LO-module.pdf》第 81 页 |

## 系统集成、成像平面和套刻

| 测校项目 | 目的 | 校准机器常数或结果 | 测校流程 | 资料出处 |
| --- | --- | --- | --- | --- |
| SODOM（XYSO，rel.3.4） | 粗调二阶畸变 D2，使后续 Final XY 能进行细调。 | 报告更新 Z2_2、Z3_2。SAXY 镜组 X/Y 调整量和 RS Ry 参与建模。其机器常数底层键名按配置查阅。 | 以光刻胶上的动态畸变测试测两 chuck，沿用 Final XY 的曝光、读标与建模骨架。SODOM 额外将 SAXY 纳入模型，并保持 RS Ry 参与。查看镜组调整量与新的二阶参数。 | 《TT-MA-ME_setupblock_6-8_1v3.ppt》第 74–75 张。《12-TT-L3-L3-ME_book.pdf》第 103 页。 |
| FOCAL Best Energy（FODBE，旧流程） | 找到适用于 FOCAL 图案和光刻胶响应的曝光能量。 | 最佳能量为后续测试输入。资料未列持久 MC。 | 在旧版 Image Plane 菜单先确定最佳能量，再进入 Single Energy Interfield / Intrafield，源页给出顺序与日志前缀，未给能量搜索的完整设置。 | 《13_AP-L1-ME_rel_3.2.pdf》第 82、116 页。《17_AP_L2_LH_v1.pdf》第 14 页。 |
| Small Field FOCAL（Single Energy Interfield，rel.3.2） | 从多个晶圆 X 位置的最佳焦点建模，校准场间焦面斜率及相关焦点偏差。 | 主要为 KU 的 BFO 焦点、像面 Ry、晶圆 Ry 等项目，启用的项取决于选项。源报告还列 KI/MI 光学/台体参数和 Lot Correction reference，按报告的 Correction 列核对实际修改。 | 在超平 wafer 上以 BA-COMBI 的中心行，在多个 X 列分别曝光离焦序列。同一 wafer 换另一 chuck 曝光并错开图案。读标，把横向位移转换为 Z，比较各列焦点与拟合斜率，再选择建模项和更新 MC。 | 《13_AP-L1-ME_rel_3.2.pdf》第 81–90 页。《11_AP-L1-IQC.pdf》第 32–33 页。 |
| Dynamic FOCAL（Single Energy Intrafield，rel.3.2） | 从扫描曝光的场内离焦数据标定光刻胶最佳像面，细化 Small Field FOCAL 与 RS Scan Tilt 的结果。 | KU：BFO 中像面 Z/Ry 等。MI：RS 高度及线性/二次楔等。KI：镜组/波长及 TIS 参考标记的场曲相关位置，用于后续 LOCO。焦点残差作为诊断输出。 | 使用超平 wafer 与 BA-COMBI，两个 chuck 分别曝光错开的多焦点矩阵。处理后测标，拟合离焦曲线，转换 XY→Z，建模并审阅更新报告。 | 《13_AP-L1-ME_rel_3.2.pdf》第 91–96 页。《11_AP-L1-IQC.pdf》第 34–35 页。 |
| Combined FOCAL（FPCM，rel.3.4。维护流程 csme103.adj） | 在一次测试里校准场内最佳像面/场曲和像散曲率相关项、场间晶圆倾斜及 BFO。 | KI：适用的镜组设定、波长、Lot Correction reference 的 Txh_z/Tyh_z。MI：RS 高度、线性/二次楔等，报告可列线性 roll。KU：两 chuck 的 Image Height、Image Ry Tilt、Wafer Ry Tilt（BFO）及明确列名的 Blue Focus Offset Z mirror X-curvature。可调参数取决于配置、建模选项和报告。 | 先用 TIS 让焦面进入 FOCAL 捕获范围。曝光时同时布置多焦点的重叠场和跨晶圆 X 的单标记列。显影、AA 读相邻对称标记的相对位移。将 XY shift vs. defocus 曲线拟合为焦点，再分别建模场内/场间，审阅两个 chuck 及校准前后残差后更新 MC。场间 Z 镜曲率由 M/E 相对差异得到。 | 《TT-MA-ME_setupblock_6-8_1v3.ppt》第 77–95 张。《TT-L2-ME-3v0.pdf》第 62–69 页。 |
| 特定分辨率的 FOCAL 变体（80 nm / 70 nm） | 让焦面模型更贴近对应机型的分辨率需求。 | 1200/1250 用测试常数切换敏感度文件。结果由既有 FOCAL/ILIAS 数据预测。文档未给底层键名。 | 已有 Combined FOCAL 和 ILIAS 数据时，按机型选择敏感度文件并计算对应分辨率结果。 | 《TT-MA-ME_setupblock_6-8_1v3.ppt》第 77 张。《12-TT-L3-L3-ME_book.pdf》第 111–112 页。 |
| Final XY / Dynamic Distortion（XYDO） | 优化扫描方向的成像畸变，求两 chuck 的蓝光对准偏置（BAO）并改善 M/E 横向一致性。 | KC 的 chuck-dependent BAO，包括 BAO_Tx、BAO_Ty、BAO_Rzs、BAO_Rza、BAO_Ms、BAO_Ma、BAO_Rz_inter、BAO_Rz_x_inter、BAO_M_x_inter、BAO_M_y_inter（Level 1 IQC 原图拼写）。根据版本和选项更新 WS 尺度、KI 的 T1_x–T5_x 参考位置与 D3 相关调节，旧报告另列 KI 镜组/波长、MI reticle 高度/Ry 与 KU 像面高度/Ry 等。 | Combined FOCAL 完成后，以校准策略选 4/6 参数模型，围绕参考层让两个 chuck 曝光错开的动态叠对层。使用高精度对准，处理 wafer 并读标。分离场内/场间残差，拟合并写入对应策略的 MC。3.4 Combined Final XY + Matching 变体曝光时启用 Matching，模型考虑其偏置。 | 《TT-MA-ME_setupblock_6-8_1v3.ppt》第 96–110 张。《11_AP-L1-IQC.pdf》第 36–38 页（第 37 页原图）。《13_AP-L1-ME_rel_3.2.pdf》第 97–108 页。《TT-L2-ME-3v0.pdf》第 70–75 页。 |
| TWINSCAN Matching / Combined Final XY and Matching（维护流程 csme105.adj） | 用同一参考机 A 的晶圆压低多台机之间的套刻差。场内匹配改变成像形状，场间匹配改变衬底上各曝光位置。 | KI 场内 D3。KC 场内 X/Y 平移、对称/非对称倍率、对称/非对称转角。KC 场间 X/Y 尺度、晶圆转角和非正交。每台匹配机对相应匹配策略保存匹配偏置。 | 基础网格、畸变、焦面完成校准。选参考机和参考 wafer。其他机台以高精度在参考层上曝错开的 overlay layer，读标，分别拟合 Lens/Intrafield Matching 和 Interfield/Grid Matching 两组偏置，保存并做 matching verification。 | 《TT-MA-ME_setupblock_6-8_1v3.ppt》第 111–117 张。《TT-L2-ME-3v0.pdf》第 70–75 页。《13_AP-L1-ME_rel_3.2.pdf》第 110–114 页。 |
| Leveling Verification Test（LVT） | 验证全片离焦及双 chuck 的焦点稳定性。 | 结果为离焦均值、标准差及图。校准 die 只用于建立本次验证的换算曲线。 | 用带玻璃楔的 Prefoc reticle，双 chuck 分别曝光已知离焦的校准 die 与测量 die。处理、读标、由参考标和焦点标的相对位移还原离焦，再比较统计量。 | 《TT-MA-ME_setupblock_6-8_1v3.ppt》第 119–125 张。 |
| Single Machine Overlay / 其他验收和复现性检查 | 验证单机全局套刻、CS/LS/AA/WA/RA 的复现性及 wafer map 重放。 | 统计量与验收判定。资料未说明对 MC 写入。 | 套刻按 three-day overlay 的多层计划曝光、读标并比较 99.7% 误差。wafer map 可用 M 侧 LS 测图、E 侧 CS 重放比对。其他复现性测试按各项仪器重复测量。 | 《TT-MA-ME_setupblock_6-8_1v3.ppt》第 126–127 张。《13_AP-L1-ME_rel_3.2.pdf》第 115 页。 |

FOCAL 的横向偏移与离焦（本机原图 `参考文献/Markdown_v1/assets/24158f8b5bfd8ba2/images/page_86_image_5_v1.jpg`）

*原图《TT-MA-ME_setupblock_6-8_1v3.ppt》第 87 张。横轴是离焦，纵轴是 AA 读到的横向位置。左右图分别是 X、Y 测量。用二次拟合峰的位置找最佳焦点，远离焦时标记细结构失去分辨率，曲线两端的散点说明为什么先要靠 TIS 找到焦面的捕获范围。*

AB 机间匹配（本机原图 `参考文献/Markdown_v1/assets/4542989d5f133071/slides/images/page_112_image_5_v1.jpg`）

*原图《13_AP-L1-ME_rel_3.2.pdf》第 113 页。B 和 C 都以 A 为参考标定。B–C 连线是要检查的实际套刻表现，这解释了为什么先建共同参考再验证机群。*

## 在线与生产内测校

| 项目和触发 | 目的 | 输出或更新项 | 流程 | 资料出处 |
| --- | --- | --- | --- | --- |
| System Correction（SYCO，在线） | 定期监控投影像面位置、方向、形状及漂移，更新 E 侧 WS 与像面的 Rx 关系。 | 写入 E 侧 WS-Rx initialization offset。其余拟合量主要用于 FastTools 趋势。TIS fiducial 名义位置及传感器栅格坐标为输入。 | MX/Calibration Manager 在批次间依设定触发（典型每日）。以 TIS1 normal 静态量测 RS fiducial 的空间像并拟合。Level 1 说明 T1/T3/T4/T5/T2 于狭缝中心、T4 另取四个离中心位置。Level 2 以三组 Y 位置示例描述 T1–T5。两课件写的取样模式应结合软件版本核对。 | 《10_AP-L1-On-line_calibrations.pdf》第 5–12、15–19 页。《TT-L2-ME-3v0.pdf》第 26 页图 1.26。 |
| Interferometer Zeroing（生产内 M/E） | 离开干涉仪控制后重建 chuck 位置和姿态参考。 | 生产内装载相应侧已校准的零位关系。E 侧此步也设 Rx。离线零位更新与在线 Rx 更新另见对应项目。 | encoder 引导回捕获区，触发零位传感器后初始化干涉仪六自由度状态。M 侧上片后，E 侧换台后。 | 《TT-L2-ME-3v0.pdf》第 10–11、19 页。《09_AP-L1-Production_Metrology_in-line.pdf》第 13、24 页。 |
| Stage Align（SA，生产内） | 把 M 侧晶圆测量转到 chuck 参考，便于 E 侧找回，接续对准和 leveling。 | 每片求 TIS1/2 之间的相对位移、全局 Z/Ry 和尺度相关结果。零误差可用于趋势。 | 在 TIS1、TIS2 上先测高再对准，以各自的标记估计零位偏差与两板相对几何，再把参考传给后续动作。 | 《TT-L2-ME-3v0.pdf》第 11–14 页。《09_AP-L1-Production_Metrology_in-line.pdf》第 14、20 页。 |
| Extended Horizontal Stage Align（生产内） | 使阶段对准适应 TIS1/2 板横向漂移及尺度/转角变化。 | 每个 chuck 首片的板旋转/倍率，每片的板间平移。作为生产对准量。 | AA 传感器在两板用外侧 I1、I2 给倍率与转角，用中央 I0 比对平移。首片做全测量，后续每片保留 I0。 | 《TT-L2-ME-3v0.pdf》第 26–27 页及图 1.27。 |
| Extended Vertical Stage Align（XVSA，生产内） | 避免 TIS 板姿态、横向曲率或 LS 倾斜的漂移影响 lot。 | 利用离线 TIS drift reference 算本次 TIS1/2 Ry、LS Ry 与板曲率差。给后续 RA Ry 修正并产生日志/判定。 | 批次每个 chuck 的首片在 Stage Align 时加测，建模并与参考比较，超限时按适用版本处理。此处生产测量和离线建参考是两步。 | 《TT-L2-ME-3v0.pdf》第 28 页。《TT-MA-ME_setupblock_1-5_1v3.ppt》第 83–87 张。 |
| Lot Correction（LOCO，生产内批次/照明设置） | 用狭缝中的 fiducial aerial image 修正镜头高阶畸变和场曲。 | 对应照明条件的 D3、FC 前馈值。IQC 还列 D5、S2、T2 的测量/存储。镜组及 RS 高度的运行偏置按模型应用。 | 在触发条件下，以 TIS1 normal 扫描五个 RS fiducial 标记并求像点 XYZ。对比名义点拟合畸变/曲率，生成相应照明模式的曝光补偿，在 Reticle Align 之前调用。 | 《09_AP-L1-Production_Metrology_in-line.pdf》第 25–26、44 页。《11_AP-L1-IQC.pdf》第 22 页。《TT-L2-ME-3v0.pdf》第 19–20、29 页。 |
| Reticle Align（RA，生产内） | 求当前 reticle 的空间像相对 exposure chuck 的位置、旋转、倍率及焦面 Z/Ry。 | 本次像点 X/Y、旋转与倍率（对称/非对称）、干涉仪尺度、像面高度及 Ry，使用离线 BAO 等作修正。 | 将 R1/R2、R3/R4 依次移入狭缝，以 TIS normal/parallel 找空间像，并测另一 TIS 上的焦点。Level 2 图 1.21 确认两组先由 TIS2 量测，再换 WS 到 TIS1。Level 1 第 27 页说明以 TIS1 起测，两份资料的起测传感器次序不同。 | 《09_AP-L1-Production_Metrology_in-line.pdf》第 23–27 页。《TT-L2-ME-3v0.pdf》第 21–22、29 页，图 1.21。 |
| Extended Reticle Align（rel.3.3 起的生产内 Rx） | 估计晶圆零位坐标系与镜头坐标系间的 Rx。 | 批次内的独立 Rx 拟合。在线 SYCO 对 E 侧 WS-Rx 初始化偏置的输出另列。 | 批首对一个照明设置，在两个 reticle 位置用 parallel TIS 测 T1/T2，独立于其余 RA 测量建模。 | 《TT-L2-ME-3v0.pdf》第 28–29 页及图 1.28。《10_AP-L1-On-line_calibrations.pdf》第 12、19 页为较早课程口径。 |
| Energy Sensor（生产内条件触发） | 确保当前照明模式下的能量标定有效。 | 生成该照明设置的能量校准状态/结果。固定 MC 与详细步骤见照明分系统。 | 批首检查本次使用的 illumination settings。缺有效校准或预计批中到期时执行，再进入对应的 LOCO 与 RA。 | 《09_AP-L1-Production_Metrology_in-line.pdf》第 42–44 页。 |
| 每片的 Global Level、Wafer Align、Z-Map 和曝光前前馈 | 获取当前 wafer 的几何与高度图，补偿趋势性的焦面、镜头热和气压影响。 | 本片高度图、对准量和曝光设定值。这些动作与离线 MC 校准配合。 | M 侧绕边测高、粗对准、LS 蛇形测图、精对准，换台后把 M 的晶圆几何接上 E 侧参考。RA/LOCO 及图像模型计算曝光设定值，曝光间继续补偿镜头热和气压。 | 《09_AP-L1-Production_Metrology_in-line.pdf》第 14–29、40–50 页。《TT-L2-ME-3v0.pdf》第 14–23 页。《11_AP-L1-IQC.pdf》第 23–25 页。 |

Extended Horizontal Stage Align 的 XPA 标记（本机原图 `参考文献/Markdown_v1/assets/e9dff352e800b276/images/page_26_image_24_v1.jpg`）

*原图《TT-L2-ME-3v0.pdf》第 27 页，图 1.27。图中 I1/I2 分布在 TIS 参考板两端，给转角与倍率更长的测量基线。中央 I0 能提供每片所需的两板平移量，因此首片和后续片测量集合不同。*

## 维护辅助项目与适用范围

| 项目 | 目的 | 校准量或结果 | 流程 | 资料出处 |
| --- | --- | --- | --- | --- |
| DHMI Touch Screen 校准 | 让维护画面的触点与屏幕坐标对齐。 | 触屏坐标映射及 Check Calibration 确认。资料未列整机计量 MC。 | 在 Production & Service 的 Calibrate Touch Screen 界面依次点触目标，测试不同区域并确认指针是否落在指下。 | 《12c_AP-L1_SL_Mach_Based_Diagnostic_System_DHMI_v23.pdf》第 67–72 页。 |

培训资料给出的测试参数和报告示例随机型与版本变化。用本表定位程序时，应核对目标机软件、硬件选项、维修后的复校范围及相应 Coach 文档。
