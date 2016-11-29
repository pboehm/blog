+++
layout = "post"
title = "git: simple but powerful workflow"
date = "2013-03-31"
tags = ["devops", "development", "git", "vcs", "workflow", "team"]
+++

`git` the distributed version control system built for the Linux kernel is widely used
nowadays and has been adapted by more and more dev-teams. Developing with `git`
in a small team requires a different workflow to `push/pull/merge/rebase`
without any problems. This post describes a minimal workflow, which builds up on
feature branches on which the developer implements their changes. The
`master`-branch tracks the remote changes and the feature branch will be merged
into `master` if the work is done.

<!-- more -->

__The workflow requires the following steps:__

1. Create a feature branch by typing `feature MYLITTLEBRANCHNAME`
2. A new branch called `MYLITTLEBRANCHNAME` has been created and checked out for you
3. You will edit some files and create some commits until your feature is complete
4. Merge your changes into `master` by typing `merge_with_master`. This will
   checkout the `master`-branch and runs a `git pull` on it. Now it tries to merge your
   branch. If new commits are added to `master` since you created your
   feature-branch, a Fast-Forward-Merge is not possible and `merge_with_master`
   asks you if it should rebase your changes on the current `master`. If you
   accept this, a `git rebase master` will be executed and another attempt to
   merge your code into `master` will be started.
5. Your changes are now merged into `master` and the feature-branch has been
   deleted. You can now push your code to a remote `git`-repo.

__Installation__

The workflow is implemented as a shell-alias and a shell-function which should
work in both `zsh` and `bash`. To install it, copy the following lines into
your `~/.[bash|zsh]rc` and start a new shell-session.

{{< gist pboehm 5282061 >}}

__The workflow in action__

The following shell session shows the workflow in action. A situation, where a
Fast-Forward-Merge is not possible, is created and than resolved by
`merge_with_master`. All lines started by a `$`-sign are shell commands.

``` bash
$ echo "Test" >> README.md
$ git add . && git commit -am "Added README"
[master (root-commit) 50c0b89] Added README
1 file changed, 1 insertion(+)
create mode 100644 README.md
$ feature README_improvements
Switched to a new branch 'README_improvements'
$ git checkout master
Switched to branch 'master'
$ echo "\nTesttest" >> README.md
$ git add . && git commit -am "Updated README"
[master 483c7b6] Updated README
1 file changed, 2 insertions(+)
$ git checkout README_improvements
Switched to branch 'README_improvements'
$ echo "*.pyc" >> .gitignore
$ git add . && git commit -am "Added .gitignore"
[README_improvements 7a84507] Added .gitignore
1 file changed, 1 insertion(+)
create mode 100644 .gitignore
$ merge_with_master
Switched to branch 'master'
fatal: Not possible to fast-forward, aborting.
Switched to branch 'README_improvements'
Your are behind master, a clean Merge is not possible!
Should I rebase it with master and try it again? (y/n) y
First, rewinding head to replay your work on top of it...
Applying: Added .gitignore
Switched to branch 'master'
Updating 483c7b6..49445e7
Fast-forward
.gitignore | 1 +
1 file changed, 1 insertion(+)
create mode 100644 .gitignore
Deleted branch README_improvements (was 49445e7).
You can now 'git push' your code
```
