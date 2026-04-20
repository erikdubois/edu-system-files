#!/bin/bash

# Exit on error, undefined variables, and pipe failures
set -Euo pipefail

# Source common library
if [[ -f /usr/local/lib/kiro-common.sh ]]; then
    source /usr/local/lib/kiro-common.sh
else
    echo "ERROR: kiro-common.sh not found" >&2
    exit 1
fi

##################################################################################################################

project=$(basename "$(pwd)")
echo "-----------------------------------------------------------------------------"
echo "this is project https://github.com/erikdubois/${project}"
echo "-----------------------------------------------------------------------------"
git config --global pull.rebase false
git config --global user.name "Erik Dubois"
git config --global user.email "erik.dubois@gmail.com"
sudo git config --system core.editor nano
#git config --global credential.helper cache
#git config --global credential.helper 'cache --timeout=32000'
git config --global push.default simple

git remote set-url origin git@github.com-edu:erikdubois/$project

echo "Everything set"

echo
tput setaf 6
echo "######################################################"
echo "###################  $(basename $0) done"
echo "######################################################"
tput sgr0
echo
