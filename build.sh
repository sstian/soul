#!/bin/bash

echo "start building..."

echo "git pushing changes..."
echo ">> git add --all"           && git add --all
echo ">> git commit -m 'deploy'"  && git commit -m "deploy"
echo ">> git push"                && git push

echo "hexo deploying webpage..."
echo ">> hexo clean"    && hexo clean
echo ">> hexo generate" && hexo generate
echo ">> hexo deploy"   && hexo deploy

echo "build completely"