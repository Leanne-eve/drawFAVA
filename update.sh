#!/usr/bin/env bash
###############################################################################
# Script to update the current branch from the repo and from the upstream.

# Error handling:
set -euo pipefail

# First: figure out what directory this script is in.
REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
# Go to that directory.
cd "${REPO_DIR}"

# First, see if the origin is already nbenlab
ghaddr="git remote get-url origin"
if [ "$ghaddr" = "git@github.com:nbenlab/drawFAVA" ]
then echo "-------------------------------------------------------------------"
     echo "Your local repository appears to be cloned from nbenlab/drawFAVA"
     echo "instead of from <your GitHub username>/drawFAVA. In order to use"
     echo "this repository, you need to first fork nbenlab/drawFAVA repository"
     echo "to your user account then clone the forked repository."
     exit 1
fi

# Next, git pull!
if ! git pull --ff-only
then echo "-------------------------------------------------------------------"
     echo "Git pull failed!"
     echo "This likely means that something in your local GitHub repo isn't"
     echo "committed. If you've edited annotations, try running the"
     echo '`bash sync.sh` script first.'
     exit 1
fi
   
if ! git pull --rebase git@github.com:nbenlab/drawFAVA main
then echo "-------------------------------------------------------------------"
     echo "Git pull from upstream failed!"
     exit 1
fi

echo "-------------------------------------------------------------------"
echo "Success!"

exit 0
