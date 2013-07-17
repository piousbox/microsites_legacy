#!/bin/sh

branch_name=$1

git add .
git commit -am "automated push of $branch_name"
git push origin $branch_name
git checkout master
git merge $branch_name
bundle exec rake assets:precompile
git add .
git commit -am "automated push of branch $branch_name"
git push origin master
git checkout branch_name
git status