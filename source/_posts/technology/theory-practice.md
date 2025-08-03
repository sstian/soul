---
title: 技术琐话
categories: Technology
tags:
  - Theory
  - Practice
abbrlink: f477
date: 2022-05-22 12:32:55
---

## 计算机科学

计算机科学家 David Wheeler：
- All problems in computer science can be solved by another level of indirection.
  **计算机科学中的所有问题都可以通过增加一个中间层（抽象层）来解决。**

## 低代码 VS 无代码

万字长文讲透低代码  https://mp.weixin.qq.com/s/loiHnUC-laQAW_NxHdn9EQ

对比角度：

|      | 低代码                                           | 无代码                         |
| ---- | ------------------------------------------------ | ------------------------------ |
| 受众 | 面向开发人员                                     | 面向业务人员                   |
| 工具 | 特指一种通用开发工具                             | 泛指多种开发细分领域应用的工具 |
| 认可 | 被广泛认可                                       | 被国际头部分析机构认可         |
| 适合 | 企业应用，如：CRM，ERP                           | 应用搭建，在线表单，工作流等   |
| 不适 | 专业性要求高的应用，如：算法，界面，性能，分析等 |                                |
| 代表 | OutSystems，Mendix等产品                         | 营销用语                       |
| 概括 | 面向专业开发的通用应用开发平台                   | 形容多种面向业务人员的工具     |

判断标准：模型驱动，可视化开发，表达式语言，软件工程，开放集成，脚本语言。
企业应用复杂性分解纬度：数据，权限，流程，算法，集成，报表。
三层结构：界面，罗辑，数据。

CRM = Customer Relationship Management 客户关系管理
ERP = Enterprise Resource Planning 企业资源计划

## 前端同构渲染

前端页面秒开的关键 - 小白也能看懂的同构渲染原理和实现  https://mp.weixin.qq.com/s/AlVjfRupDPxlEAcYvZBqyg

客户端渲染 CSR = Client Side Render
通过牺牲首屏加载速度和SEO，来获取用户体验的一种技术。
SEO = Search Engine Optimization 搜索引擎优化

服务器端渲染 SSR = Server Side Render
拥有良好的首屏性能和SEO，但用户体验方面较差，且会占用较多的服务器端资源。

同构 Isomorphic
最开始的步骤和SSR相同，将生成的HTML字符串返回给用户即可；同时可以将CSR生成的JS一并发送给用户；
这样用户在接收到SSR生成的html后，页面还会再执行一次CSR的流程。

脱水 Dehydrate：服务器端获取到数据后，把数据随着HTML一起传给客户端的过程。
注水 Hydrate：客户端拿到HTML和数据，利用这个数据来初始化组件的过程。

心跳包检测的作用主要是为了防止子进程卡死。

对比：

|                | CSR    | SSR  | 同构 |
| -------------- | ------ | ---- | ---- |
| SEO            | 不友好 | 友好 | 友好 |
| 白屏问题       | 有     | 无   | 无   |
| 占用服务器资源 | 少     | 多   | 中   |
| 用户体验       | 好     | 差   | 好   |

## 软件开发模型 - 敏捷开发

符合敏捷宣言的叫敏捷开发，敏捷开发是一种软件开发理念，极限编程是其中一个方法。

**敏捷宣言**：
个体和互动高于流程和工具
工作的软件高于详尽的文档
客户合作高于合同谈判
响应变化高于遵循计划

> 动 > 静 | dynamic > static
> 千变万化 > 一成不变
> 世界日新月异，对手千变万化，如果你墨守成规、一成不变，那你就成了必定被淘汰的“改变”。

https://agilemanifesto.org/
Manifesto for Agile Software Development：
Individuals and interactions over processes and tools
Working software over comprehensive documentation
Customer collaboration over contract negotiation
Responding to change over following a plan

**敏捷开发**：
是一种以人为核心，迭代，循序渐进的开发方法，适用于小团队和小项目，具有“小步快跑”的思想。

**敏捷方法**：
- **极限编程 XP = Extreme Programming**
“Extreme”（极限）是指，对比传统的项目开发方式，XP强调把它列出的每个方法和思想做到极限、做到最好；其它XP所不提倡的，则一概忽略（如开发前期的整体设计等）。一个严格实施XP的项目，其开发过程应该是平稳的、高效的和快速的，能够做到一周40小时工作制而不拖延项目进度。
  - 4个价值观：
  沟通 Communication，简单 Simplicity，反馈 Feedback，勇气 Courage。
  任何一个软件项目都可以从四个方面入手进行改善：加强交流；从简单做起；寻求反馈；勇于实事求是。
  - 5个原则：
  快速反馈，简单性假设，逐步修改，提倡更改，优质工作。
  - 12个最佳实践：
    - 规划策略/计划游戏 The Planning Game
    快速制定计划，随着细节的不断变化而完善。
    - 结对编程 Pair programming
    由两个程序员在同一台电脑共同编写解决用以问题的代码。通常一个人负责编写，而另一个负责保证代码的正确性和可读性。
    - 测试驱动开发 Testing-Driven Development
    先写测试代码，再编写程序。
    - 重构 Refactoring
    重新审视需求和设计，重新明确地描述它们以符合新的和现有的需求。
    - 简单设计 Simple Design
    只处理当前的需求，使设计保持简单。
    - 集体代码所有权 Collective Code Ownership
    任何人在任何时候都可以在系统中的任何位置更改任何代码，每个成员都有更改代码的权利，所有人对于全部代码负责。
    - 持续集成 Continuous Integration
    可以按日甚至按小时为客户提供可运行的版本。
    - 客户测试 Customer Tests
    在团队中加入一位真正起作用的用户，他将全职负责回答问题。
    - 小型发布 Small Release
    系统的设计要能够尽可能早地交付。
    - 每周40小时工作制 40-hour Week
    要求项目团队人员每周工作时间不能超过40小时，加班不得连续超过两周，否则会影响效率。
    - 编码标准 Code Standards
    强调通过制定严格的代码规范来进行沟通，尽可能减少不必要的文档。
    - 系统隐喻 System Metaphor
    找到合适的比喻传达信息。
- **水晶法 Crystal**
每一个不同的项目都需要一套不同的策略，约定和方法论 以项目为本，人对软件质量有重要的影响 以人为本。
随着项目质量和开发人员素质的提高，项目和过程的质量也随之提高。
通过更好地交流和经常性交付，软件生产力得到提高。
- **开放式源码程序**
开发人员在地域上分布广。
- **并列争球法 Scrum**
橄榄球中的“并列争球”，多个成员站在一排，都同时冲刺着去争抢球权。
软件开发中，把每30天一次的迭代称为一个“冲刺周期” Sprint，并按需求的优先级来实现产品。多个自组织和自治的小组并行地递增实现产品。
- **功用驱动开发 FDD = Feature Driven Development**
开发成员人尽其用，把功能快速开发好。首席程序员和“类”程序员。
- **自适应软件开发 ASD = Adaptive Software Development**
核心是三个非线性的，重叠的开发阶段：猜测，合作与学习。
6个基本原则：
  - 有一个使命作为指导
  - 特征被视为客户价值的关键点
  - 过程中等待是很重要的，因此“重做”与“做”同样关键
  - 变化不被视为改正，而是被视为对软件开发实际情况的调整
  - 确定的交付时间迫使开发人员认真考虑每一个生产的版本的关键需求
  - 风险也包含其中
- **敏捷统一过程 AUP = Agile Unified Process**
采用经典的UP阶段性 初始，精化，构建，转换，
采用“小型迭代”和“大型连续”原理来构建软件系统。
