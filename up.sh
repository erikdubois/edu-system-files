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
# Author    : Erik Dubois
# Website   : https://www.erikdubois.be
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################

# Parse common arguments
parse_common_args "up.sh" "1.0.0" \
    "Push changes to the edu-system-files repository" \
    "[OPTIONS]" \
    "    (no additional options)"

# Remove processed flags from $@ if needed
shift $((OPTIND - 1)) 2>/dev/null || true
#tput setaf 0 = black
#tput setaf 1 = red
#tput setaf 2 = green
#tput setaf 3 = yellow
#tput setaf 4 = dark blue
#tput setaf 5 = purple
#tput setaf 6 = cyan
#tput setaf 7 = gray
#tput setaf 8 = light blue
##################################################################################################################

# reset - commit your changes or stash them before you merge
# git reset --hard - personal alias - grh

# Below command will backup everything inside the project folder
git add --all .

git commit -m "update"

# Push the local files to github

if grep -q main .git/config; then
	echo "Using main"
		git push -u origin main
fi

if grep -q master .git/config; then
	echo "Using master"
		git push -u origin master
fi

echo "################################################################"
echo "###################    Git Push Done      ######################"
echo "################################################################"
