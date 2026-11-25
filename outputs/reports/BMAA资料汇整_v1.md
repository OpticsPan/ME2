# BMAA 资料汇整 v1

[L1 载板与零位](#l1) · [L2 光学参照与后续项目](#l2) · [L3 自动过程与原图](#l3) · [各次 Fine](#sequence) · [不同讲义如何对应](#versions) · [BMAA 章节草稿](MEtrology-BMAA整理草稿_v1.md#bmaa)

**阅读范围。** 本机 Level 1–3 的 MinerU 索引共 103 份 PDF 或 PPT、7,902 页或张。按原文件逐页检查正文，并用 BMAA、BM-AA、BM AA、Basic Machine Constants Advanced Alignment、TRM、FTBU、CMXPA、reference grating offsets 等写法定位相关页，回看载板、捕获、拟合和测试报告的原图。以下 PDF 页号均从文件首页计数，PPT 标幻灯片序号。ME book 的印刷页比文件页小 8，AA 手册的印刷页比文件页小 6。文件名供在本机只读原始资料区定位。

<a name="l1"></a>

## L1　光从哪里读，位置以什么为准

| 原文件、页 | 原文支持的信息 |
| --- | --- |
| L1《13_AP-L1-ME_rel_3.2.pdf》文件第 29–32 页 | 先检查 AA（Advanced Alignment，高级对准）光纤、激光输出和初始化，晶圆台须能工作。BMAA 测台上的载板，BMWL 测晶圆装载偏移。每块载板有自己的局部坐标，标记设计位置已知。TRM 给出台坐标与板坐标之间的平移、面内转角和倍率。 |
| 同文件第 31、35 页 | 两个 chuck 各自以 TIS1 载板的名义 XY 平移规定台坐标的平移基准。TIS1 中心可以离晶圆台几何中心很远。AA 找到该板后，对照此时 X/Y 干涉仪读数和名义应读值，差量用于更新测量侧归零偏置 X0、Y0。 |
| 同文件第 33–37 页 | 早期相机流程先找 3×3 XPA 标记阵列的中央标记 CMXPA，人工确认后，对两台的 TIS1、TIS2 各测 I1、I2。讲义所示的第二台还测 Abbe 模块 AC1、AC3 与 Confidence Sensor 模块 CS1、CS3。第 34 页的手动十字线容差为 ±4 µm。 |
| 同文件第 38–39 页 | 第 38 页 Chuck 2 实例中，TIS1 的平移校前、校后同为 (−122.5, 144.5) mm；面内转角由 0 变为 164.2 µrad，倍率由 1 变为 0.9999991。标题为 **Coarse**。第 39 页的 Fine 跳过 CMXPA，更新先前的常数。该实例证明固定平移与校正板转角可以同时成立。数值只用于理解这份示例报告。 |
| L1《01_AP-L1-Hardware_Introduction_v2.pdf》《17_AP-L1-HardwareIntroduction_v2 [Read-Only].pdf》《17_AP-L1-HI_v2 [Read-Only].pdf》文件第 160 页 | 三份硬件课件均把 BMAA 列为 AA 用途。载板实际配置参见硬件课件第 123 页与 L3 TIS 示例。 |
| L1《09_AP-L1-Production_Metrology_in-line.pdf》文件第 9、14、20、31、40、49 页；L1《12e_AP-L1-SL- Software Architecture.pdf》文件第 15、27–28 页 | 生产时晶圆台归零后，还要测台上的基准做 stage alignment，再开展晶圆测量。此处合并说明日常使用的次序，BMAA 则为这些已知台上基准建立离线标定。 |

<a name="l2"></a>

## L2　可观察的标记与后续项目

| 原文件、页 | 原文或原图支持的信息 |
| --- | --- |
| L2《TT-L2-ME-3v0.pdf》文件第 12–13 页（印刷 6–7），图 1.7、1.10 | 图 1.7 画出测量侧 AA 与台上 TIS 的位置关系；图 1.10 由台面、载板放大到 I0/XPA。它们解释 AA 能看见什么。生产 stage alignment 的标记示例不能直接充当所有 BMAA 配置的标记清单。 |
| L2《12-TT-L2-ME-module.pdf》文件第 36、39、41、43 页 | BMWL Load Offsets、WS Tilt Rotation Interferometer Matrix、Combined FOCAL、Combined Final XY and Matching 的相应测试条件中列有 BMAA Fine。各页列的其他条件仍各自适用。这里描述的是后续测试的进场条件。 |
| L2《TT-L2-ME-3v0.pdf》和《TT_L2_ME_.pdf》各文件第 60 页 | Load Offsets 条目也要求事先完成 BMAA Fine。装片偏移量由 BMWL 校准。 |

<a name="l3"></a>

## L3　实机流程、输出和质量判据

| 原文件、页 | 操作、观测与输出 |
| --- | --- |
| L3《12-TT-L3-L3-ME_book.pdf》文件第 37 页（印刷 29），图 2.17；L3《TT-MA-ME_setupblock_1-5_1v3.ppt》第 32–34 张 | 自动粗校在测量侧建立 WS 归零后相对 AA 的位置、TIS2 与适配时 ILIAS 的平移；测光学模块 OM 各参考光栅的相对偏置。课件也用「AA position」描述几何参照。未见可另列为独立自由参数的 AA 机械安装位移字段。 |
| L3《12-TT-L3-L3-ME_book.pdf》文件第 38 页（印刷 30）图 2.18；上述 setupblock 第 34–35 张 | 初始标记可偏离预期位置达 1 mm；以 100 µm 间距的二维网格作螺旋搜索，在各位置扫描。最大信号超过门限才认为捕获可靠。随后 WQ 轮廓定位的精度指标在讲义中写为 <4 µm。 |
| 同书文件第 39 页（印刷 31），图 2.19–2.21；上述 setupblock 第 36 张 | WQ（Wafer Quality）轮廓反映标记像与参考光栅随横向偏置改变的重叠。图 2.19 的 X 段上画有一排横向扫描箭头；逐次改变扫描线的 Y 偏置，得到定 Y 的轮廓。Y 段交换两轴，定 X。图 2.20 比较窄标记与普通 XPA 的轮廓。图 2.21 为理想几何重叠模板。 |
| 同书文件第 40 页（印刷 32），图 2.22 | 模板与实测轮廓作相关，对相关函数求导，在峰附近用直线拟合求导数零点。每个方向按颜色、奇数阶得到候选中心，书中由十个候选中取红、绿两色的第 3、5、7 阶共六个位置的平均作为标记位置，并报各参考光栅相对此平均的偏移。书列标准 OM 参考光栅偏移规格 12 µm，窄标记 OM 为 8 µm。 |
| 同书文件第 41–42 页（印刷 33–34），图 2.23–2.26；上述 setupblock 第 37–39 张 | 每个标记可输出 capture 和 determine 两份 WQ 诊断数据。图 2.23 比较正常信号与无标记实例；图 2.24 是测试界面。图 2.25、2.26 按卡盘、标记、级次给出捕获、相关和线性拟合资格。TIS 信号 >0.001、相关系数 >0.7、拟合的多重相关系数 MCC >0.95 是该版课件的规格。 |
| L3《04-TT-L3-ATS-AA-2v0.pdf》文件第 76–78 页（印刷 70–72），图 5.21、5.22 | 粗校前 AA 硬件正常、WS 的 XY 性能在 ±1 µm 内、Rz 在 ±5 µrad 内，wafer handler 可用。本书保留自动搜索和手柄十字线 ±2 µm 两种描述。图 5.21 的红圈圈出 capture mark；图 5.22 右半区同时画了 WS 坐标和各载板局部坐标。AA 测标记、X/Y IFM 给出台位置，两者配合确定载板在台上的实际位置。 |
| L3《TT-MA-ME_setupblock_1-5_1v3.ppt》第 40–41、46 张；L3《12-TT-L3-L3-ME_book.pdf》文件第 45 页（印刷 37）；L3《04-TT-L3-ATS-AA-2v0.pdf》文件第 122 页（印刷 116） | Fine 对两台所有适用载板重新对准；实测与板上名义标记不合时，调整 TRM。自动版细化零位、TIS2／ILIAS 平移并求载板面内转角与倍率。AA 书所述配置求两台 TIS1/TIS2 TRM、Abbe/CSCM TRM、最终测量侧 WS X0、Y0。它列的前置含 Coarse、测量侧 XY IFM、对准触发延迟、两卡盘适用的级次间偏移 SBO。 |
| L3《05-TT-L3-TIS-2v0.pdf》文件第 7–8 页，图 1.1、1.2；L3《04-TT-L3-ATS-AA-2v0.pdf》文件第 57 页（印刷 51） | TIS1、TIS2 位于台面不同角；前书图 1.2 在第二台标有 ILIAS，而 AA 书描述的另一种配置具有 Abbe/CSCM。部分机型或软件取消 Confidence Sensor。应按实际配置确定需测的载板。 |

**两处可对照的原文。** 原文以“WQ profile of X-segment”说明沿 X 分区取轮廓时，解出的是每条扫描线的横向 Y 偏置中心（L3《12-TT-L3-L3-ME_book.pdf》文件第 39 页，印刷 31，图 2.19）。L1 在讲解两台的台面参考时写道 “On both wafer chucks the TIS1 plate has this purpose.”，其前文指一块载板的名义平移规定卡盘的坐标原点（L1《13_AP-L1-ME_rel_3.2.pdf》文件第 31 页）。

<a name="sequence"></a>

## L3　Fine 分别在什么时候运行

| Setup 的位置 | 为什么运行 | 出处 |
| --- | --- | --- |
| 初始 AA 支路，Coarse 后第一次 Fine | 粗校后能自动找到标记，开始细化零位与板几何。 | L3《12-TT-L3-L3-ME_book.pdf》文件第 14、37 页，图 1.3、2.17；L3《TT-MA-ME_setupblock_1-5_1v3.ppt》第 32、40–41 张 |
| AA 对焦、SBO 与测量侧 XY IFM 更新后，第二次 Fine | 重新测得的标记位置更准，IFM 模型更新也会改变其坐标。 | 同书文件第 45 页（印刷 37）；同 PPT 第 46 张 |
| PGA 增益校准后，第三次 Fine | 更新对准结果，随后运行 BMTIS Fine。 | 同书文件第 87 页（印刷 79）；L3《TT-MA-ME_setupblock_6-8_1v3.ppt》第 18、29–30 张 |
| SODOM 后，第四次 Fine | 焦面已变，更新与 BMTIS 的联系，再做 BMTIS Fine。若单论 WS 非正交／比例更新引起的台坐标变化，资料另列重跑或坐标前馈修正两途。 | 同书文件第 98、104 页（印刷 90、96）；上述 setupblock 6–8 第 57–58 张 |

L3《12-TT-L3-L3-ME_book.pdf》文件第 56、58、89 页及《07-TT-L3-LS-2v0.pdf》文件第 33 页区分了三组参照：BMAA 得到台上基准标记相对 AA 的位置，BMTIS／BMWZ 建立曝光侧相对投影镜头的关系，ELLA 把 LS 中央 M4 相对 AA 的位置接进测量坐标系。BMWL 可以使用相似的光学捕获原理，但测量对象是装载的晶圆。测量侧 XY IFM 在后续精调阶段也会因 BMAA 更新而复测。

L3《04-TT-L3-ATS-AA-2v0.pdf》文件第 79、82、96、123、126 页在 BMWL、载波相位、SBO 或对准重复性项目中引用 BMAA；《09-TT-L3-WSbook.pdf》文件第 76 页列为 WS 相关 setup。其他交叉条目见 L3《TT-L3-LS-3v0.ppt》第 38 张、《TT-MA-AA-part3-HWR-3V1.ppt》第 7、10、13、16、19、23、29、32 张、《TT-MA-TIS-3V1.ppt》第 33、35、37、42、51、61、65 张，以及《TT-MA-GD_Tempe.ppt》第 115 张的日志示例。它们用于核实参照链、前置或维护情境，操作细节以 ME 主章为准。

<a name="versions"></a>

## 回读时要保留的差别

- **自动版与早期版。** L3 ME 自动版明说 Coarse 先解决零位及平移，旋转和倍率留给 Fine。L1 2003 年讲义的 Coarse 报告却已列出旋转和倍率。两种流程各按原课件陈述，不能把手柄、自动 WQ 搜索和两套写参顺序拼成同一台机器的一次操作。
- **载板的名义坐标与台的零偏。** TIS1 的 XY 平移按定义固定；在 AA 下找到 TIS1 时，IFM 应读值与实读值仍会有差。零偏吸收这项差，其他载板的相对平移才能以同一台为基准比较。
- **参考光栅偏置、SBO、WQ 强度。** BMAA 报告的各光栅偏置相对红绿 3、5、7 阶位置均值；SBO 有独立校准项目；WQ 强度及相关、拟合的通过状态用来判断此次测量是否可靠。三者用途不同。

[阅读 BMAA 章节草稿](MEtrology-BMAA整理草稿_v1.md#bmaa) · [返回成果目录](../README.md)
