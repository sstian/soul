---
title: 格式设计
categories: Collection
tags:
  - Format Design
abbrlink: 952b
date: 2020-12-30 12:30:00
---

## 论文格式

### 正文

中文：宋体

英文：Times New Roman

其它：小四号字，1.5倍行距

对应关系：四号=14磅，小四=12磅，五号=10.5磅，小五=9磅

### 表格

参考正文

### 流程图

Visio绘制

中文：宋体

英文：Times New Roman

字号：小四/12磅

### 题注

图之上：图m-n xxx

表之下：表m-n xxx

公式之右：(m-n)

> m=章号，n=序号；图表标题字体：五号

### 页眉页脚

字号：小五

## 程序开发

### MFC SDI 功能区使用图像带

界面单个图标尺寸：

+ Large Images: 分辨率 32 x 32 p, 32位深
+ Small Images: 分辨率 16 x 16 p, 32位深
+ app.icon: 24 x 24 p, 32位深
+ main.bmp: 26 x 26, 32位深，带透明度信息

### MFC CSocket事件

AsyncSelect(FD_READ);

| 网络事件 | FD_READ   | FD_WRITE | FD_ACCEPT | FD_CONNECT |
| -------- | --------- | -------- | --------- | ---------- |
| 回调函数 | OnReceive | OnSend   | OnAccept  | OnConnect  |
