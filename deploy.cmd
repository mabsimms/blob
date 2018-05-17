@ECHO OFF
ECHO Deploying updates to Github
hugo

cd public
git add .
git commit -m "Rebuilding site, date TODO"
git push origin master
cd ..

