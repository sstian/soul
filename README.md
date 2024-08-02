# in Future

It's my personal website.

| Platform   | Username | Repository URL                             | Website                   |
| ---------- | -------- | ------------------------------------------ | ------------------------- |
| Github     | sstian   | https://github.com/sstian/sstian.github.io | https://sstian.github.io/ |
| Gitee      | sstian   | https://gitee.com/sstian/sstian            | https://sstian.gitee.io/  |
| Aliyun ECS |          | /home/git/blog.git                         | https://www.sstian.top/   |

## Layout

+ max title number is **20**, in every article post with markdown
+ max tag number is **3**, in every article, in order to good reading experience

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

### 配置ssh
```cmd
# 生成ssh公钥
ssh-keygen -t rsa -C st.tian@foxmail.com

# 检测ssh公钥是否配置成功
C:\Users\Snow-Angel>ssh -t git@gitee.com
Hi sstian! You've successfully authenticated, but GITEE.COM does not provide shell access.
Connection to gitee.com closed.
```

### 配置git
全局用户设置
```cmd
git config --global user.email "sstian@snowflake.com"
git config --global user.name "sstian"
```
/_config.yml
```yaml
deploy:
  type: git
  repo: 
    - git@github.com:sstian/sstian.github.io.git
    - git@gitee.com:sstian/sstian.git
    - git@sstian.top:/home/git/blog.git
  branch: master
```

### 部署

`npm install hexo-deployer-git`

```cmd
hexo clean
hexo g -d <=> hexo d -g <=> hexo generate –deploy <=> hexo deploy --generate
```

## 推送仓库

### 一系列操作

```cmd
git add --all
git commit -m "xxx"
git push
```

### 推送文件到多个仓库

更改 `E:\rulebook\website\.git\config` 文件：
加入`url = git@gitee.com:sstian/website.git` 

```
[core]
	repositoryformatversion = 0
	filemode = false
	bare = false
	logallrefupdates = true
	symlinks = false
	ignorecase = true
[remote "origin"]
	url = git@github.com:sstian/website.git
	url = git@gitee.com:sstian/website.git
	fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
	remote = origin
	merge = refs/heads/master
```

## 构建自动化

1. 配置系统环境变量
可通过界面将以下路径加到环境变量中
$PATH = D:\Program\Git\bin;$PATH
```cmd
D:\Program\Git\bin>dir /b
bash.exe
git.exe
sh.exe
```

2. 编写脚本
build.sh
```bash
#!/bin/bash

# usage: e.g. bash build.sh "commit message"

# exit immediately if a simple command exits with a non-zero status
set -e

# input parameters
message=$1

commit_message=`echo "$message" | tr -d " "`
if [ -z "$commit_message" ]; then 
  commit_message="deploy"
else 
  commit_message="$message"
fi

echo "start building..."
start_time=`date +%s`

echo "git pushing changes..."
echo -e "\n>> git add --all"                      && git add --all
echo -e "\n>> git commit -m \"$commit_message\""  && git commit -m "$commit_message"
echo -e "\n>> git push"                           && git push

echo "hexo deploying webpage..."
echo -e "\n>> hexo clean"    && hexo clean
echo -e "\n>> hexo generate" && hexo generate
echo -e "\n>> hexo deploy"   && hexo deploy
# echo -e "\n>> gulp build"    && gulp build

echo -e "\nbuild complete!"
end_time=`date +%s`
elapsed=`expr $end_time - $start_time`
echo "elasped $elapsed seconds"

```

3. 设置脚本命令（可选）
package.json
```json
"scripts": {
	"build": "bash build.sh"
}
```

4. 执行命令
in the terminal of command
```cmd
# npm run build
# e.g.
bash build.sh "commit message"
```

## Fix

### 修复图片懒加载的bug
一般情况下懒加载会和gallery插件会发生冲突，结果可能就是点开图片，左翻右翻都是loading image。
matery主题的解决方案是：修改 /themes/matery/source/js 中的 matery.js文件
在第108行加上：
```js
$(document).find('img[data-original]').each(function(){
    $(this).parent().attr("href", $(this).attr("data-original"));
});
```

做完这步之后，还有点小Bug，首页的logo点击会直接打开logo图，而不是跳到首页。
伪解决方案：打开 /themes/matery/layout/_partial/header.ejs文件，在img和span的两个头加个div：
```ejs
<div class="brand-logo">
    <a href="<%- url_for() %>" class="waves-effect waves-light">
        <div>
            <% if (theme.logo !== undefined && theme.logo.length > 0) { %>
            <img src="<%= theme.logo %>" class="logo-img" alt="LOGO">
            <% } %>
            <span class="logo-span"><%- config.title %></span>
        </div>
    </a>
</div>
```

懒加载优化，可做可不做。
其实第一次加载后本地都是有缓存的，如果每次都把loading显示出来就不那么好看。
所以我们需要对插件进行魔改，让图片稍微提前加载，避开加载动画。
解决方案：打开 Hexo根目录>node_modules > hexo-lazyload-image > lib > simple-lazyload.js 文件
第11行修改为：
```js
&& rect.top <= (window.innerHeight +240 || document.documentElement.clientHeight +240)
```
作用：提前240个像素加载图片；当然这个值也可以根据自己情况修改。

## Skill

### 测试百度Spider能不能爬你的域名
在任意目录下执行以下命令（将“你的域名”换成你的域名）：
```bash
curl -A "Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)" -o example.html 你的域名

# e.g.
curl -A "Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)" -o example.html www.sstian.top
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed 
100   145  100   145    0     0   2499      0 --:--:-- --:--:-- --:--:--  2685
```
执行完命令，在该目录下会生成一个文件 `example.html`，打开它，如果显示：
- 301 Moved Permanently，说明被重定向了。
- **302 Found，说明被爬到了。**
- 如果打开是你的首页，说明爬取到的内容就是你的首页HTML内容。
- 如果显示以下内容，说明域名解析到GitHub时，403 Forbidden 访问被禁止。
Your access to this site has been restricted.
If you believe this is an error, please contact the Support Team.

## Reference

- Hexo 文档  https://hexo.io/zh-cn/docs/
- hexo+github搭建博客(超级详细版，精细入微)  https://blog.csdn.net/victoryxa/article/details/103733655?spm=1001.2014.3001.5506 
- Hexo进阶之各种优化  https://blog.sky03.cn/posts/42790.html
- 关于百度无法爬取GitHub内容解决方案  https://blog.sky03.cn/posts/7974.html

