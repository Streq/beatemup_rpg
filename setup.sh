#!/bin/bash

git checkout -b gh-pages || exit "$?" 
git push origin gh-pages || exit "$?" 
git push --set-upstream origin gh-pages || exit "$?" 
git checkout develop || exit "$?" 
#configure gh-pages branch on the gh repo

git checkout -b main || exit "$?" 
git push origin main || exit "$?" 
git push --set-upstream origin main || exit "$?" 
git checkout develop || exit "$?" 

cp template_secrets.sh secrets.sh

chmod +x secrets.sh
chmod +x release.sh