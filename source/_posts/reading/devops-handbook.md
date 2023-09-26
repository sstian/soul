---
title: DevOps 实践
categories: Reading
tags:
  - Book
  - DevOps
abbrlink: 221f
date: 2023-08-13 20:58:37
---

## 凤凰项目：一个IT运维的传奇故事

**The Phoenix Project
A Novel About IT, DevOps, and Helping Your Business Win**

[美] 基恩·金 (Gene Kim) 凯文·贝尔 (Kevin Behr) 乔治·斯帕福德 (George Spafford) /著

COO = Chief Operation Officer 首席营运官
CIO = Chief Information Officer 首席信息官 / = “Career Is Over” 职业生涯结束了
ITIL = Information Technology Infrastructure Library 信息技术基础架构库
ITSM = Information Technology Service Management 信息技术服务管理
WIP = Work in Process 在制品

### 经典语录

有些书适合给你的朋友，为了分享阅读的喜悦；有些书适合给你的同事，为了建立理念的共识；有些书适合给你的老板，为了播下伟大的种子。

电影《拯救大兵瑞恩》：这里有一系列的命令：只可对上抱怨，不许对下牢骚。

### 虚构人物语录

比尔·帕尔默：
- 要想在IT运维管理的岗位上做得长久，一定得有足够的资历，这样才能把事情干好。但是一定要低调，不能卷入政治斗争，以免惹祸上身。副总裁们整天做的就是互发PPT。
- 俗话说得好，如果你的同事主动告诉你他们要离职，那多半是自愿的。但如果是其他人告诉你的，那他们一定是被迫的。
- 海军陆战队，保持军营干净整洁不只是为了美观，更是为了安全。
- 靠道听途说可没法破案，当然也没法解决服务中断故障。
- 知道真相总好过一无所知。
- 再也没有比阻止人们去做他们理应做的事更能毁掉大家的热情和支持了。我不认为我们还能有第二次机会让事情走上正轨。
- 80/20法则在这里似乎同样适用：80%的风险是由20%的变更造成的。
- 流程是用来保护人的。
- 埃瑞克把半成品称为“沉默的杀手”，车间控制半成品的能力不足，是造成长期性延误和质量问题的根源之一。
- 搞死你的不是前期投入，而是后台的运行和维护。
- 告知真相是一种爱的表现。隐瞒真相是一种恨的表现。甚至更糟，是一种冷漠的表现。
- 开发和QA的环境与生产环境不匹配，绝对不应该发生这样的事。

埃瑞克：
- 只有掌握了战术，才能实现战略目标。
- 半成品是个隐形杀手。因此，管理任何一家工厂最关键的机制之一，就是工作任务和原材料的发布。没有这个机制，就无法控制半成品。
- 不应该根据第一个工作站的效率来安排工作，而是根据瓶颈资源所能完成工作的速度来安排工作。
- 创建约束理论的艾利·高德拉特告诉我们，在瓶颈之外的任何地方做出的改进都是假象。（所有在非约束点所做的改进都是假象）
- 作为IT运维部的副总裁，你的工作是确保形成一条迅速、可预测、持续不断的计划内工作流，从而向业务部门交付工作价值，同时尽可能降低计划外工作的影响和破坏，那样你才能提供稳定的、可预期的、安全的IT服务。
- 反复实践是精通工作的先决条件。
- 不仅仅是要减少半成品。相比于向系统中投入更多的工作，将无用的工作剔出系统更为重要。
- 重要的是结果，而非过程、管理，或者你完成了哪些工作。
- 每个工作中心都由四种东西组成：机器、人员、方法，以及测评。
- 研究表明，每天训练5分钟比每周开展一次为期3小时的训练更有效。
- 一个给定资源的等待时间，是那个资源忙碌时间的百分比除以空闲时间的百分比。因此，如果一个资源使用了50%，等待时间就是50/50，或者说1个单位。
- （信息安全）可以不对IT系统做过多无用功就保护公司，这才是你的胜利。如果你能把那些无用功剔出IT系统，你的胜利就更进一步。
- 把整个环境创建流程自动化。
- 要记住，你身边有很多经验丰富的人，他们也踏上过同样的旅程，所以，你可别因为不去找人帮忙，而变成一个失败的傻瓜啊。
- 一时的救世主固然好，但普世的圣经则更有用。

史蒂夫：
- 一个伟大的团队并不代表他们拥有最聪明的人。使团队变得伟大的因素，是每个人都互相信任。当那种神奇的动力出现，就会让整个团队充满力量。（凝聚力）
- 兰西奥尼教导我们，展现自己脆弱的一面有助于建立起信任的基础。
- IT不只是一个部门。相反，它就像电力一样无处不在。IT是一种技能，就像能读会算一样。
- 每一个称职的COO都会是从IT部门出来的。任何尚未精通IT系统就负责管理公司运行的COO，都只会是金玉其外的傀儡，需要依靠别人来开展工作。

玛姬·李：
- 在竞争的时代，游戏规则就是“快速上市，快速淘汰”。我们需要短而快的周期，不断整合来自市场的反馈。

### 现实人物语录

卡伦·马丁和麦克·奥斯特林《Value Stream Mapping》：
价值流：一个组织基于客户的需求所执行的一系列有序的交付活动，或者是为了给客户设计、生产和提供产品或服务所需从事的一系列活动，它包含了信息流和物料流的双重价值。

爱德华·戴明博士：没人会强迫你学习……学习也并非生存必需。（自驱的学习才有用）
克里斯托弗·利特尔：DevOps不仅是自动化，就像天文学不只是望远镜一样。
通用电气公司 首席执行官 伊梅尔特：没有将软件作为核心业务的每一个行业或公司都会受到影响。
微软 技术院士 杰弗里·斯诺弗：在过去的经济时代，企业通过移动原子创造价值。而现在，他们必须通过数字创造价值。
克里斯托弗·利特尔：每个公司都是科技公司，无论他们认为自己处在哪个行业。银行也只是拥有银行执照的IT公司而已。
高德拉特博士《目标之外》：在任何价值流中，总是有一个流动方向、一个约束点，任何不针对此约束点而做的优化都是假象。
休哈特：循环（即PDCA环）——计划（Plan）、实施（Do）、检查（Check）、改进（Act）。
麦克·奥泽恩：比日常工作更重要的，是对日常工作的持续改进。

帕特里克·兰西奥尼《团队发展的五大障碍》：
1.缺乏信任；2.惧怕冲突；3.欠缺投入（投入激情）；4.逃避责任；5.无视结果。

### 项目管理

变更：对应用程序、数据库、操作系统、网络或硬件进行的物理、逻辑或虚拟操作，并且这样的操作可能对相关服务产生影响。

技术债务：沃德·坎宁安首次提出。类似于金融债务。我们当前所做出的决定会导致一些问题，而这些问题随着时间的推移会越来越难解决，未来可采取的措施也越来越少。即使我们审慎地承担技术债务，也依然会产生利息。

分钟级别的部署前置时间的方法：
向版本控制系统中持续不断地提交小批量的代码变更，并对代码做自动化测试和探索测试，然后再将它部署到生产环境中。这样，我们就能对代码变更在生产环境中的成功运行保持高度自信，同时还能快速地发现并修复可能出现的问题。

预防措施有个问题，就是你很少能知道自己究竟避开了哪些灾难。
要想在现代技术上取得成功，必然需要多方向和多专业领域的协作。
想要在团队中达成相互信任，你需要展现出自己脆弱的一面。
更卓越的领导力其实是为团队创造条件，让团队能在日常工作中感受到这种卓越。
产品负责人不应该只关注具有创新性的产品和功能，还需重视维护工作和移除技术债务等优先级。
任何一个领域或学科想要取得进步和成熟，就需要认真反思它的起源，在反思中寻求不同的观点，并把这些不同观点的来龙去脉思考清楚，这对预见未来发展是非常有帮助的。

IT运维、信息安全和开发等不同职能部门之间的良好合作是成功的关键。
一个IT做得失败的公司，整个公司也都是失败的。
IT公司的任务和价值：
- 对变化莫测的市场做出反应；
- 为客户提供稳定、可靠和安全的服务。

界定问题的性质：
1.经常发生的问题——流程制度
2.偶然发生的问题——规则方法
3.首次发生的“经常问题”——重点决策

提高效率三要素：稳定环境，减少切换成本；可视化目标，掌握全局；紧紧盯住约束点，抓住关键。

四类工作：业务项目，内部项目，变更，计划外工作（破坏性最强）。

五个聚焦步骤：
1.确认约束点。找不到真正的瓶颈，做什么都是多余。
2.利用约束点。不能让约束点闲着，让它一直运转，而不是需要他才运转。
3.迁就约束点。以瓶颈的产出速度作为整个项目的产出速度。使布伦特解决完一个关键后马上解决下一个关键问题，只做关键工作，疏通瓶颈，避免半成品过剩。
4.消灭约束点。可以通过增员，引进新技术，跳过瓶颈等方式提高瓶颈产出速度，降低瓶颈对项目进程的约束。
5.发现新的约束点。主要矛盾被解决后，次要矛盾会上升为主要矛盾。在约束点被消灭后，找到新的约束点，聚焦它，将进一步提高产能。工作流将越来越流畅高效。



### DevOps

DevOps = Development & Operations 开发和运维
infrastructure as code 基础设施即代码
CI = Continuous Integration 持续集成
CD = Continuous Deployment / Continuus Delivery 持续部署/持续交付

“每日10次部署”
DevOps的准则：总有更好的方法
DevOps的原则和模式就是通过整合企业文化、企业架构和技术实践，让下降式螺旋变成上升式螺旋。
DevOps是把精益原则应用到技术价值流中的结果。
DevOps基于精益、约束理论、丰田生产系统、柔性工程、学习型组织、安全文化、人员优化因素等知识体系，并参考了高信任管理文化、服务型领导、组织变动管理等方法论。
精益的两个主要原则：
- 坚信前置时间（把原材料转换为成品所需的时间）是提升质量、客户满意度和员工幸福感的最佳度量指标之一
- 小批量任务的交付是缩短前置时间的一个关键因素

在DevOps中，技术价值流：把业务构想转化为向客户交付价值的、由技术驱动的服务所需要的流程。
流程的输入是既定的业务目标、概念、创意和假设，始于研发部门接受工作，并将它添加到待完成工作列表中。
技术价值流的核心是建立高度信任的文化。

三步工作法：
第一工作法，建立工作流并以可视化方式呈现
第二工作法，根除计划外工作的最大源头
第三工作法，不断给系统增加压力，使其习惯并强化。

**三步工作法**的原则：
- **流动**原则：它加速了从开发、运维到交付给客户的流程。
使工作可见；限制在制品数；减小批量大小；减少交接次数；持续识别和改善约束点；消除价值流中的困境和浪费。
- **反馈**原则：它使我们能建立更加安全可靠的工作体系。
在复杂系统中安全地工作；及时发现问题；群策群力，战胜问题获取新知；在源头保障质量；为下游工作中心而优化。
- **持续**学习与实验原则：它打造出一种高度信任的文化和一种科学的工作方式，并将对组织的改进和创新作为日常工作的一部分。
建立学习型组织和安全文化；将日常工作的改进制度化；把局部发现转化为全局优化；在日常工作中注入弹性模式；领导层强化学习文化。

更快、更廉价、更低风险的软件交付趋势正加速发展：

|            | 1970~1989 年              | 1990~1999 年           | 2000 年~至今                              |
| ---------- | ------------------------- | ---------------------- | ----------------------------------------- |
| 时代       | 主机                      | 客户端/服务器          | 商品化和云计算                            |
| 标志性技术 | COBOL、运行在MVS上的DB2等 | C++、Oracle、Solaris等 | Java、MySQL、RedHat、Ruby on Rails、PHP等 |
| 交付周期   | 1~5年                     | 3~12个月               | 2~12个星期                                |
| 成本       | 100万~1亿美元             | 10万~1000万美元        | 1万~100万美元                             |
| 风险级别   | 整个公司                  | 产品线或部门           | 产品特性                                  |
| 失败成本   | 破产、出售公司、大量裁员  | 业务亏损、CIO革职      | 可忽略不计                                |

罗恩·韦斯特拉姆的组织类型学模型：

| 病态型         | 官僚型               | 生机型         |
| -------------- | -------------------- | -------------- |
| 隐瞒信息       | 忽略信息             | 积极探索信息   |
| 消灭信使       | 不重视信使           | 训练信使       |
| 逃避责任       | 各自担责             | 共担责任       |
| 阻碍团队的互动 | 容忍团队的互动       | 鼓励团队间结盟 |
| 隐瞒事故       | 组织是公道和宽容的   | 调查事故根因   |
| 压制新想法     | 认为新想法会造成麻烦 | 接纳新想法     |

### 思想感悟

- 浴火重生的叫凤凰，浴火成灰的叫火鸡。
- 获得别人好感，拉进别人距离的好办法就是很自然的说出这个人的一些事儿。
- 在约束理论中曾经提到过，所有人都在忙碌是一件很可怕的事情，这不是高效的表现。所有在非瓶颈处的更高效率都是无用功，甚至可能有副作用。
- 工作的动力大部分是成就感，而不是一直被某些人或者事情追着跑。需要时间静下心来思考。

> IT技术，应用层日新月异，要保持学习；底层变化不大，要夯实基础。基础不牢，地动山摇。

## 独角兽项目：数字化转型时代的开发传奇

**The Unicorn Project
A Novel about Developers, Digital Disruption, and Thriving in the Age of Data**

[美] 吉恩·金 著

ITIL = Information Technology Infrastructure Library 信息技术基础架构库
TEP-LARB = Technology Evaluation Process - Lead Architecture Review Board 技术评估流程表-首席架构审查委员会
STEM：Science 科学，Technology 技术，Engineering 工程，Mathematics 数学。
FAANG：美国市场上五大最受欢迎和表现最佳的科技股的首字母缩写，即社交网络巨头Facebook（NASDAQ:FB）、苹果（NASDAQ:AAPL）、在线零售巨头亚马逊（NASDAQ:AMZN）、流媒体视频服务巨头奈飞（Netflix，NASDAQ:NFLX）、谷歌母公司Alphabet（NASDAQ:GOOG，NASDAQ:GOOGL）。
HPPO效应：Highest Paid Person's Opinion，最高收入者意见。
big wad of crap 一大团废物

### 名词术语
- 竞态条件 race condition：设备或系统出现不恰当的执行时序，而得到不正确的结果。从多进程间通信的角度来讲，是指两个或多个进程对共享的数据进行读或写的操作时，最终的结果取决于这些进程的执行顺序。
- “海森堡 bug”：观察行为改变了现实本身性质的量子物理现象。
- 亚马逊的“两个比萨团队”原则：用两张比萨可以喂饱的团队就能创建出功能特性。
- 塔克曼的团队阶段模型：形成期、动荡期、规范期和高效期。
- 混沌工程：在生产环境中对软件系统进行实验的学科，目的是建立对系统承受动荡和意外情况能力的信心。
- 惊群问题：同时进行的客户端重试最终导致服务器挂掉。在计算机科学中是指，如果许多进程在等待一个事件，事件发生后这些进程被唤醒，但只有一个进程能获得CPU执行权，其他进程又得被阻塞，从而造成严重的系统上下文切换代价。
- 现金牛 cash cow：拥有高市场占有率及低预期增长的业务。
- 霍尔原则 Hoare principle：写代码有两种方法：写得非常简单，显而易见没有bug；写得非常复杂，没有显而易见的bug。
- 沃德利映射 Wardley Map：从客户的需求入手，逐步绘出满足这些需求的各个功能和系统，以及这些功能和系统的演进，以呈现出组织内部存在的价值链。
- 美国心理学家库伯勒−罗斯（Kübler-Ross）将身患绝症的患者从获知病情到临终时期的心理反应和行为改变归纳为5个典型阶段：否认期、愤怒期、讨价还价期、抑郁期和接受期。

### 经典语录
- 孤立地理解系统的任何部分都是很困难的。
- 信任的缺乏和太多嘈杂的信息让事情进展得越来越慢。
- 能够测试并将代码部署到生产环境更有助于提高产能和客户满意度，而且有助于程序员提升对代码质量的责任感，同时使其工作变得更令人愉悦、更有价值。
- 优秀的 QA 需要一种反常的、有时甚至是残酷的直觉，知道什么会导致软件爆炸、崩溃或无休止地挂起。
- 每个人都能及时将自己的变更合并到“主分支”，比如每天一次。这样，合并的变更就不会太大。就像在制造业里，小批量生产可以创造平稳的工作流程，没有相互冲突的中断或灾难。
- 我们甚至不再需要警卫了。我们太喜欢做囚徒了，认为那些栅栏是为了保护我们的安全而设。
- 永远背负这么多未兑现的承诺，真的是一种认知和精神负担。
- 工程师应该编写代码，而不是填写表单。
- 没有优秀设计师的应用常常被戏称为“企业级”的。原文为 enterprisey，用于形容为大型商业公司开发的软件，常用作贬义指过度设计、不合目的。
- 要想表达清晰，就必须思维清晰。要想思维清晰，就必须记录清晰。
- 伟大可以被扼杀，但也可以被修复。
- 当每个人都清楚目标是什么时，团队就会自我组织起来，以最好地实现这些目标。
- 领导者必须以身作则，示范他们期望的行为模式。
- 成年学习者经常掩盖他们正在试图学习一项新技能的事实，无论是学习一门新语言还是学游泳，甚至是上高尔夫球课。这通常是因为他们尴尬或害怕被人看到自己做不擅长的事情。
- 吸引优秀人才有一个意想不到的方式：通过公司令人惊叹的全新开源项目。
- 技术需要嵌入到业务中，而不是与业务无关，或者仅仅是“与业务保持一致”。
- 恐惧文化所造成的破坏性影响。在这种文化中，错误的行为通常会受到惩罚，替罪羊会被解雇。惩罚失败和“枪杀信使”只会让人们掩盖自己的错误。最终，所有创新的欲望都会被彻底磨灭。
- 当人们不能持续构建他们的应用时，灾难通常就在眼前。
- 有比代码更重要的东西是使开发人员能够高效工作的系统。
- 付出大于回报总是好事，因为你永远不知道将来谁可能会帮助你。人脉很重要。
- 当工程师抽象地思考“客户”而不是真实的人时，很少会得到正确的结果。
- 法律谚语：现实占有，九胜一败。指占有人在诉讼中处于有利地位。

一个笑话：一个 QA 工程师走进一家酒吧。点了1杯啤酒。点了0杯啤酒。点了999 999 999杯啤酒。点了1只蜥蜴。点了-1杯啤酒。点了1个 sfdeljknesv。

### 现实人物语录
孙振鹏：Patrick Debois: DevOps beyond Dev and Ops。意思是DevOps应超越开发和运维，服务于整个企业或组织，更快、更可靠、更安全地交付对用户更优的价值，助力数字化转型，让业务蓬勃发展，让企业基业长青。
张乐：别只惦记着眼前的几捆“白菜”，技术创新实践的星辰大海、未来的无限可能性更令人心潮澎湃！
PowerShell的发明者杰弗里·斯诺弗：Bash 是一种你会携带一生但不会致死的疾病。

### 虚拟人物语录
史蒂夫：
- 安全永远排在第一位。
- 技术债务就是指造成困难、重复劳动，并降低软件工程师敏捷性的东西。
- 只要一个团队充满激情、致力于完成一项使命，并且拥有对的技能，那么与他们作对就是愚蠢的，因为他们会竭尽全力让一切成为现实。
- 过去几百年甚至未来上千年都会是这样：员工敬业度和客户满意度是唯一重要的事情。如果我们做到了这一点，并有效地管理现金，其他所有财务目标都会自动达成。
- 我们的未来取决于创新。创新不是来自流程，而是来自人。
- 我们的业务是建立在客户信任的基础上的。我们已经向客户承诺，保护他们的隐私和数据。

玛克辛·钱伯斯：
- 开发人员需要一个系统，以便快速并持续地获得关于其工作质量的反馈。如果你没能很快地发现问题，那么最终会在几个月后发现。但到那时，问题已经消失在其他开发人员所做的大量修改中了，而因果关系也会消失得无影无踪。任何项目都无法这样进行下去。
- Oh, the Places You'll Go。
- 美好的一天是当她在解决一个重要的业务问题时，时间过得飞快，因为她是那么专注，那么热爱这份工作。她处于心流状态，以至于根本感觉不到是在工作。
- 糟糕的一天就是她沮丧得想撞显示器，在网上搜索一些她根本不想学但为了解决手边的问题必须要学的东西。
- 无论你们使用什么语言，最重要的是不断运行你们的程序。经常运行程序的真正好处之一是你们可以看到它在运行。这很有趣，这就是编程的意义。
- 状态突变和循环是非常危险的，而且很难纠正。
- 作为项目的所有者，她把确保每位贡献者都能拥有很高的生产力视为自己的首要职责。
- 在几乎所有其他领域，特别是当你有客户的时候，变化是常态。健康的软件系统是可以按照所需的速度来进行变更的，人们可以很容易地做出贡献，而不需要跨越重重关卡。这就是让一个项目有趣并值得贡献的秘诀，你会经常看到最有活力的社区就是这样的。
- 她能够以专注、流动和快乐的状态来创造东西。她的工作很快得到了反馈。人们可以做自己想做的事情，而不需要依赖很多人。这就是伟大的架构所能实现的。
- 之所以生产部署是任何技术组织中最复杂的活动之一，是因为这需要在组织中进行如此多部门之间的协调。
- 如果你无法获取关于如何使用程序的反馈，又怎能创造出有价值的东西呢？
- 拥有一个优秀的构建过程是得到良好的代码部署和发布过程的关键。
- 每个决策都是一种承诺，要支持好几年甚至几十年——这远远超出了某个团队的能力范围。
- 找到同类，这就是有效的人际网络的意义所在——你可以召集一群积极的人来解决一个大问题，即使这个团队看起来一点也不像官方组织。
- 之所以痛苦，是因为合并的规模太大了。为了减少痛苦，他们需要更频繁地进行合并，这样合并的规模就会变小，产生的冲突也会更少。
- 环顾四周，她发现公司里最好的工程师都在努力提高其他人的工作效率。“就应该这样。”
- 如果有什么时候需要勇气和不懈的乐观，那就是现在。
- 他们能够取得现在成就的唯一途径，就是创造一种让人们感到安全的文化，从而去实验、学习和犯错，让人们有时间进行探索、创新和学习。
- 对于如此关键的任务，我们不应该依赖外部服务。当它们不工作或断开我们的调用时，我们需要优雅地进行处理。
- 小不一定能胜大。但是，快一定能胜慢。行动迅速的大块头几乎每次都会赢。

库尔特·雷茨尼克：
- 一旦我们可以持续构建，就能进行自动化测试。有了自动化测试，我们就可以更快、更有信心地进行变更，而不必依赖数百小时的手动测试。我相信，这是让我们更安全、更快、更幸福地交付更佳价值的关键第一步。我们需要在构建或测试过程中发现问题，而不是在部署期间或生产环境上。
- 预防需要诚实，诚实需要无所畏惧。就像诺曼·克尔斯在敏捷最高境界中指出的那样：“不管发现了什么，我们都理解并相信每个人都已经全力以赴，只是受限于他们当时所知道的、他们的技能和能力、可用的资源和手头的情况。”
- 在危机中，我们永远不知道真正在发生什么，而且我们需要为未来做准备。在未来，我们对世界的理解也会同样不完美。

埃瑞克：
- 交织（complect）就是把简单的东西变成复杂的东西。在紧耦合和交织的系统中，几乎不可能改变任何东西。
- 代码部署前置时间、代码部署频率和问题解决时间是软件交付、运营效能和组织绩效的预测指标，它们与职业倦怠和员工敬业度等很多因素相关。
- 简单性很重要，因为它促成了局部性。代码中的局部性使系统保持松耦合，使我们能够更快地交付功能特性。团队可以快速而独立地开发、测试，并把价值传递给客户。
- 底层的架构至关重要，关乎开发人员在日常工作中使用的系统是否高效。
- 创新和学习发生在边缘，而不是核心。必须在第一线解决问题，因为那里每天的工作是由世界上最频繁面对这些问题的前沿专家来完成的。
- 心理安全是卓越团队最重要的因素之一。团队有信心，不会因为有人发言而尴尬，受到否决或惩罚。出现错误时，我们会问“是什么原因导致的”，而不是“是谁导致的”。我们承诺尽一切努力让明天比今天更好。
- 未来需要创建一个动态的学习型组织。在这个组织中，实验和学习是每个人日常工作的一部分。
- 与初创公司相比，现代企业拥有更多资源和专业知识。我们需要的是专注和紧迫感，以及管理价值创造过程的现代方法。
- 沃德·坎宁安：技术债务是你下次想要做出变更时感觉到的。
- 比尔盖茨：如果开发人员必须在实现功能特性和提高安全性之间做出选择，他们必须选择后者，因为这关系到公司的存亡。
- 斯蒂芬·斯皮尔博士：无知是所有问题的根源，唯一能克服它的是学习。
- 爱德华兹·戴明：一个糟糕的制度每次都会击败一个好人。
- 约翰·奥斯帕：每个事故都是一次学习的机会，一次未经同意的计划外投资。
- 乔布斯：安全是一切工作的前提。
- 奥尼尔：每个人都必须对自己的安全和队友的安全负责。如果你看到什么东西可能会伤害到别人，就必须尽快修复。
- 克雷·克里斯坦森：我们自己管理“不够好”的东西，将“非常好”的东西外包出去。

柯尔斯顿：
- 公司的最高层不仅要做正确的事情，而且要把正确的事情做对。按时发布代码就是其中一部分。

戴夫
- 每个开发人员都知道，以后需要在编写功能特性的同时编写自动化测试，而不是在之后。（测试驱动）

黛布拉：
- 事实永远比想法有价值得多。

### 开发实践
绞杀者模式一般用于传统旧系统（大部分是单体）向微服务架构的改造和迁移的过程中。在旧系统中创建一个绞杀者外层（类似扔了一粒无花果种子在旧系统中），然后随着新功能的引入（无花果发芽生长），最终旧系统慢慢被替换成完整的新系统（宿主死亡）。

编程方法论：
1. 命令式编程
关注程序的执行流程和状态，程序员定义执行的步骤，而不是定义要达到的目标。
程序由一系列语句组成，其中包括条件语句、循环语句、赋值语句等。语句由计算机解释器或编译器按顺序执行，程序状态在执行过程中不断变化。程序员需要负责跟踪和维护程序状态，以确保程序按照预期执行。
适用于实现算法、操作系统、驱动程序、图形用户界面等领域。
常见的编程语言包括C、Java、Python、C++等。
2. 函数式编程
强调使用函数和避免变量状态和可变数据。
主要是基于数学中的λ演算发展而来，它的基础是数学和逻辑学。
广泛应用于处理函数对象和集合、函数式语言、科学计算、并行和分布式计算、Web应用程序等领域。
常见的函数式语言包括Lisp、Haskell、Erlang、Scala、Clojure等。
纯函数：其输出完全依赖于输入，没有副作用、突变或全局状态访问。
不可变性，使世界变得更可预测、更安全。
3. 面向对象编程
以对象为中心，通过封装、继承、多态等机制来组织程序结构和实现功能。
可以提高程序的重用性、可扩展性、可维护性和可读性。
广泛应用于各个领域，包括软件开发、游戏开发、物联网、人工智能、图形用户界面等。
常见的面向对象编程语言包括Java、Python、C++、C#、Ruby等。

### DevOps
三个视野（Three Horizons），杰弗里·摩尔博士推广。
客户采纳是一个高斯分布曲线，可以划分为创新者、早期采纳者、早期大多数、晚期大多数和落后者。

波士顿矩阵：
公司若要取得成功，必须拥有“市场增长率”和“相对市场份额”各不相同的产品组合。用这两个维度画一个“二维四象限矩阵图”，并给这个矩阵中的四象限，起了几个形象的名字：现金牛，明星，问题，和瘦狗。
1. 现金牛业务
现金牛业务被戏称为“印钞机”，通常有很高的相对市场份额，也因此市场增长率显得低。
2. 明星业务
明星业务通常是很有前景的新兴业务，在一个快速增长的市场中，占据了相对高的市场份额。一旦明星业务成为现金牛，公司就进入下一个爆发期。
3. 问题业务
问题业务是一些相对市场份额还不高，但市场增长率提高很快的业务。它们最终会成为明星业务，甚至现金牛业务，还是会死掉，是不确定的问题。
4. 瘦狗业务
瘦狗业务是相对市场份额很低，也看不到什么增长机会的，食之无味弃之可惜的业务。

波士顿矩阵的四种战略建议：
1. 发展战略
就是不惜用“现金牛业务”的收益，大举投入到“问题业务”中，以提高相对市场份额，尽快成为“明星业务”的战略。
2. 保持战略
就是不轻易投资新方向，好好养牛，维持市场份额，让“现金牛业务”产生更多的收益。
3. 收割战略
对强大的替代产品已经出现的“现金牛业务”，比如柯达的胶卷相机，和发展前景不佳的“问题业务”和“瘦狗业务”，可以考虑尽可能快速收割短期利益，然后准备放弃。
4. 放弃战略
对于无利可图的“瘦狗业务”，果断清理、撤销、出售，把资源用在其他有前景的业务上。

核心（Core）与非核心（Context）的概念，也就是四个区域的内涵。
核心是组织的核心能力，是客户愿意付钱换取的能力，也是使投资者奖励的能力。
非核心是其余的一切，包括员工餐厅、办公楼之间的摆渡车，以及公司运营必须要做的成千上万件事。它们通常很关键，比如人力资源、薪酬系统和电子邮件。但是我们的客户不会因为我们为员工提供出色的薪酬服务而付钱给我们。

五大理念：
第一理念：局部性和简单性
第二理念：专注、流动和快乐
第三理念：改进日常工作
第四理念：心理安全
第五理念：以客户为中心

### 思想感悟
- 在占据了我们有限生命的大量时间的工作中，我们对创造价值的追求是共通的。
- 人们总是说“规矩是死的，人是活的”，而又总是制造出死的规矩来约束活的人。
- 公司盈利的极端：
一个极端是，通过削减成本，把运营中的每一点利润榨取干净，想到了丰田的精益生产；
另一个极端是，构建多维度业务，做大现金牛、培育明星、挖掘问题业务、抛弃瘦狗业务。

> 快速反馈，持续交付，敏捷迭代
>《独角兽项目》比起《凤凰项目》紧急上线时的惊心动魄，更多的是项目的解耦，架构的重构，团队成员的团结协作。
> 数据转型？：关系型的SQL，到NoSQL，到大数据
>
> 独角兽项目：定制化推荐和促销功能。
> 独角鲸：新数据库和 API 网关平台。
> 独角猫 ci-unikitty：持续集成和部署平台。
> 美洲豹：数据计算平台。
> 
> 逆戟鲸：分析和数据科学团队

