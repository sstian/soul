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
  计算机科学中的所有问题都可以通过加一层（增加一个抽象层）来解决。


## 低代码 VS 无代码

万字长文讲透低代码  https://mp.weixin.qq.com/s/loiHnUC-laQAW_NxHdn9EQ

对比角度：
|      | 低代码                                           | 无代码                         |
| ---- | ------------------------------------------------ | ------------------------------ |
| 受众 | 面向开发人员                                     | 面向业务人员                   |
| 工具 | 特指一种通用开发工具                             | 泛指多种开发细分领域应用的工具 |
| 认可 | 被广泛认可                                       | 被国际头部分析机构认可         |
| 适合 | 企业应用，如：CRM、ERP                           | 应用搭建、在线表单、工作流等   |
| 不适 | 专业性要求高的应用，如：算法、界面、性能、分析等 |                                |
| 代表 | OutSystems、Mendix等产品                         | 营销用语                       |
| 概括 | 面向专业开发的通用应用开发平台                   | 形容多种面向业务人员的工具     |

判断标准：模型驱动、可视化开发、表达式语言、软件工程、开放集成、脚本语言。
企业应用复杂性分解纬度：数据、权限、流程、算法、集成、报表。
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

