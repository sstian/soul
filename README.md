# in Future

It's my personal website.

| Platform | Repository URL                                | Website                   |
| -------- | --------------------------------------------- | ------------------------- |
| Github   | htthttps://github.com/sstian/sstian.github.io | https://sstian.github.io/ |
| Gitee    | https://gitee.com/sstian/sstian               | https://sstian.gitee.io/  |

## Layout

+ max title number is **20**, in every article post with markdown
+ max tag number is **3**, in every article, in order to good reading experience

## Post Article

Markdown style:
```markdown
## 影视名

**原版名/外文名**

[国籍] 作者……

人物：
+ 名言警句。

> 其它内容
```

e.g.
```markdown
## 你好世界

**HELLO WORLD，ハロー・ワールド**

[日] 伊藤智彦

一行琉璃：
+ 被人阅读，才是书的夙愿吧。

> 一行琉璃，二度救赎，三千世界，四亭八当。
```

## 配置环境

### 安装node.js

https://nodejs.org/en/

查看版本：
``` cmd
node -v
npm -v
```

### 创建目录

e.g. website/, npm全局安装hexo，配置发布
```cmd
npm install hexo-cli -g
hexo init
```

### 新建博客

e.g. hello-world：n = new, g = generate, s = server
```cmd
hexo new hello-world
hexo g
hexo s
```

本地访问地址：http://localhost:4000

blog required title:
```
title: Hello World
abbrlink: 3eeb
date: 2021-01-01 00:00:00
categories: Tutorial
tags:
  - GitHub
  - Hexo
```

### 配置git

/_config.yml
```yaml
deploy:
  type: git
  repo: 
    - git@github.com:sstian/sstian.github.io.git
    - git@gitee.com:sstian/sstian.git
  branch: master
```

### 部署

`npm install hexo-deployer-git`

```cmd
hexo clean
hexo g -d <=> hexo d -g <=> hexo generate –deploy <=> hexo deploy --generate
```

## Reference

Hexo 文档  https://hexo.io/zh-cn/docs/

