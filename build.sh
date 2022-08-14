#!/bin/bash

# Exit immediately if a simple command exits with a non-zero status
set -e

echo "start building..."

echo "git pushing changes..."
echo -e "\n>> git add --all"           && git add --all
echo -e "\n>> git commit -m 'deploy'"  && git commit -m "deploy"
echo -e "\n>> git push"                && git push

echo "hexo deploying webpage..."
echo -e "\n>> hexo clean"    && hexo clean
echo -e "\n>> hexo generate" && hexo generate
echo -e "\n>> hexo deploy"   && hexo deploy

echo "build completely!"