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
# Written to be used on 64 bits computers
# Author 	: 	Erik Dubois
# Website 	: 	http://www.erikdubois.be
##################################################################################################################
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################

# Parse common arguments
parse_common_args "setup-edu.sh" "1.0.0" \
    "Set up git configuration for edu-system-files repository" \
    "[OPTIONS]" \
    "    (no additional options)" \
    "$@"

# Problem solving commands

# Read before using it.
# https://www.atlassian.com/git/tutorials/undoing-changes/git-reset
# git reset --hard orgin/master
# ONLY if you are very sure and no coworkers are on your github.

# Command that have helped in the past
# Force git to overwrite local files on pull - no merge
# git fetch all
# git push --set-upstream origin master
# git reset --hard orgin/master

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
