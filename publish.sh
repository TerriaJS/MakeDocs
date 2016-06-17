#!/usr/bin/env bash
pushd ../site
#git add .
#git commit -m 'Update' --author 'Terria Bot <TerriaBot@users.noreply.github.com>'
git remote rm origin
git remote add origin git@github.com:TerriaJS/Documentation.git
# this requires Git 2.3.x GIT_SSH_COMMAND="ssh -i ../terriabit_id_rsa" 
# instead, we put TerriaBot's SSH key in my SSH dir. great.
git push -f origin gh-pages
popd
