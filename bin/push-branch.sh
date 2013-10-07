#!/bin/sh

branch_name=$1

echo "adding, committing and pushing all to $branch_name"
git add .
git commit -am "automated push of $branch_name"
git push origin $branch_name

echo "mergine to master, compiling and pushing"
git checkout master
git merge $branch_name
bundle exec rake assets:precompile --trace
git add .
git commit -am "automated push of branch $branch_name"
git push origin master

echo "switching back to branch $branch_name"
git checkout branch_name
git status