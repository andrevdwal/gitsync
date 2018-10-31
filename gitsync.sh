#!/bin/sh
# This script can be used to keep two repos in sync by fetching changes from
# a source repo and pushing it to a target repo.

# usage
if [ "$1" == "help" ]; then
  echo "USAGE: $ ./gitsync <WORKING_DIR> <REPO_SRC> <REPO_DST>"
  echo "  <WORKING_DIR>  - the directory where the repo will be checked out"
  echo "  <REPO_SRC>     - the source repository"
  echo "  <REPO_DST>     - the target repository"
  exit
fi

WORKING_DIR=$1                              # parent directory of repo
REPO_SRC=$2                                 # the clone source (origin)
REPO_DST=$3                                 # the target
REPO_SRC_DIR=${WORKING_DIR}/${REPO_SRC##*/} # the local path of the repo

# clone and setup repo if not exists
if [ ! -d "$REPO_SRC_DIR" ]; then
  git clone $REPO_SRC $REPO_SRC_DIR --mirror
  git -C $REPO_SRC_DIR remote add target $REPO_DST
fi

# fetch and push latest changes
git -C $REPO_SRC_DIR fetch --all -p
git -C $REPO_SRC_DIR push --all target

# remove remote branches in target
TARGET_BRANCHES=$(git -C $REPO_SRC_DIR branch -r)
LOCAL_BRANCHES=$(git -C $REPO_SRC_DIR branch --list)

for REMOTE_BRANCH in $TARGET_BRANCHES; do
  SIMPLE_BRANCH_NAME=${REMOTE_BRANCH##*/}

  if [[ ! "$LOCAL_BRANCHES" =~ "$SIMPLE_BRANCH_NAME" ]]; then
    git -C $REPO_SRC_DIR push target --delete $SIMPLE_BRANCH_NAME
  fi
done
