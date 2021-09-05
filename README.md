# in Future

It's my personal website.

Github url: https://github.com/sstian
Gitee  url: https://github.com/sstian

Website: 
https://sstian/github.io
https://sstian/gitee.io

## Layout

+ max title number is 20, in every article post with markdown
+ max tag number is 3, in every article, in order to good reading experience

## Format

Article
```
## <titile>

**<foreign name>**

[<nation>] <director>

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
  repo: git@github.com:sstian/sstian.github.io.git
  branch: main
```

### 部署

`npm install hexo-deployer-git`

```cmd
hexo clean
hexo g -d <=> hexo d -g <=> hexo generate –deploy <=> hexo deploy --generate
```

## Reference

Hexo 文档  https://hexo.io/zh-cn/docs/

