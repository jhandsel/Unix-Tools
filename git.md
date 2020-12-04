# Git

## Checkout a branch from origin
```
git checkout -t origin/<name of branch>
```

## Create a release branch based on develop
```
git checkout -b release-x.y develop
```
When the release branch is ready for deployment,
its changes should be merged into develop and
master.

## Apply the changes to master
```
git checkout master
git merge --no-ff release-x.y
```
The `--no-ff` means the branch will be shown in
`git log` as such, which makes the history easier
to understand.

Do the same for the develop branch, and push the
changes to the server.
```
git push
```

The release branch pointer can then be deleted:
```
git branch -d release-x.y
```

If the branch pointer also exists on the central
server, it can also be deleted:
```
git push origin --delete release-x.y
```

## Making a hotfix
A hotfix should be branched off master, and then
the changes merged back in as a minor version. The
changes must also be merged into the develop branch

## Resolving a git merge conflict
Edit the file that contains the conflicts. It will
have sections similar to:
```
<<<<<<< HEAD
...
<code>
...
=======
...
<code>
...
>>>>>>> <branch being merged in>
```
The section before `=======` contains the code
from the current branch, and the section below
contains the code from the branch being merged
in. Delete the unwanted lines, including the
section markers.

The modified file can then be added and the merge
committed:
```
git add <file_with_conflicts>
git commit
```

If the conflict is not resolvable, the merge can be
aborted:
```
git merge --abort
```
