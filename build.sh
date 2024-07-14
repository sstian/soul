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
