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
