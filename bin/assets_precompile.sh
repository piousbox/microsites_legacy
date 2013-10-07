#!/bin/bash

git checkout master-resume
git pull origin master-resume
git pull origin resume
git rebase resume

bundle install
bundle exec rake assets:precompile

git add public/assets
git add -u

git commit -m "recompiling assets"
git push origin master-resume

echo "+++ +++"
echo "Assets have compiled"