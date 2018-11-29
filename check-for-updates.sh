#!/bin/sh -e

# Check if either the git repo or any of the npm modules needs to be updated,
# and if so kill the running node.

git_needs_update()
{
    git fetch --dry-run | tail -1 | grep -q -s '..'
    return $?
}

npm_needs_update()
{
    npm outdated "$@" | tail +2 | awk '{ if ($2 != $3) { exit(127); } }' -
    test $? -eq 127
    return $?
}

cd $DATA/$EXTENSION

if git_needs_update || npm_needs_update -g || npm_needs_update ; then
    echo "*** Update required ***"
    set -x
    rm -f package-lock.json
    git status
    npm outdated -g || true
    npm outdated || true
    killall node
    sleep 2
    killall -INT node
    sleep 2
    killall -KILL node
fi
