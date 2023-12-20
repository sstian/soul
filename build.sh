#!/bin/bash

# Exit immediately if a simple command exits with a non-zero status
set -e

echo "start building..."
start_time=`date +%s`

echo "git pushing changes..."
echo -e "\n>> git add --all"           && git add --all
echo -e "\n>> git commit -m 'deploy'"  && git commit -m "deploy"
echo -e "\n>> git push"                && git push

echo "hexo deploying webpage..."
# echo -e "\n>> hexo clean"    && hexo clean
# echo -e "\n>> hexo generate" && hexo generate
# echo -e "\n>> hexo deploy"   && hexo deploy
echo -e "\n>> gulp build"    && gulp build

echo -e "\nbuild completely!"
end_time=`date +%s`
elapsed_time=`expr $end_time - $start_time`
echo "elasped time=$elapsed_time seconds"
