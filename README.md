# Git-Sync

Use this script to keep two git repos in sync (master -> slave).

### Install
Clone the repo or download the source. Give the script execute permissions:

```
$ chmod +x gitsync.sh
```

### Usage
You can run the following command for help:

```
$ ./gitsync help

USAGE: $ ./gitsync <WORKING_DIR> <REPO_SRC> <REPO_DST>
  <WORKING_DIR>  - the directory where the repo will be checked out
  <REPO_SRC>     - the source repository
  <REPO_DST>     - the target repository
```

### Example:

This example assumes you have SSH configured on both Gitlab and Github
```
$ ./gitsync ./repos git@gitlab.com:andrevdwal/passgen-go.git git@github.com:andrevdwal/passgen-go.git
```

What this does is:
 1. Create a `./repos` directory if it does not exist
 1. Clone ` git@gitlab.com:andrevdwal/passgen-go.git ` to `./repos/passgen-go.git` as a mirror repo. This is the SRC
 1. Add ` git@github.com:andrevdwal/passgen-go.git ` as a remote called `target`. This is the DST.
 1. Fetch all the changes from `SRC` and push them to `DST`.
 1. Delete branches on `DST` that do not exist on `SRC` any more.
 
