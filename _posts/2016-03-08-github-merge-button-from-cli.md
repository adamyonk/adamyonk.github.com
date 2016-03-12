---
layout: post
title: GitHub Merge Button from CLI
date: 2016-03-08 12:42:39 -0600
tags: command-line github
---

It's no fun to have to clean up git history after a botched command line merge
of a GitHub pull request. I love to live life in the shell, and I don't want to
open a new browser tab just to click [The Merge Button][], so sometimes I'm
stubborn and I don't. And sometimes I waste a lot of time cleaning up the mess
that happens when I try to do all of that with an outdated master branch.

With some prodding and direction from my good friend [pengwynn][], I put
together a script based on the new-to-me [Merge Button API Route][]. So, go
forth and merge with glee, in safety, and without leaving our beloved shell. ❤️

See `git-merge-pr` below or [cherry-pick it from my dotfiles][commit]!

[The Merge Button]: https://github.com/blog/843-the-merge-button
[pengwynn]: https://github.com/pengwynn
[Merge Button API Route]: https://developer.github.com/v3/pulls/#merge-a-pull-request-merge-button
[commit]: https://github.com/adamyonk/dotfiles/commit/2db7d4b82344816bb215eec21c40044e48e59781

## git-merge-pr

~~~shell
#!/usr/bin/env bash

# Contributors:
#   Adam Jahnke - http://github.com/adamyonk
#   Wynn Netherland - http://github.com/pengwynn

#/
#/ Usage:
#/   git merge-pr [<branch>]
#/
#/ Looks up the most recent pull requst based on the current branch or
#/ <branch>, and tries to merge it using the merge API (like the Merge Button).
#/
#/ Requirements:
#/   - $GITHUB_TOKEN environment variable
#/   - jq https://stedolan.github.io/jq/
#/

set -e

if [[ "$1" == "--help" || "$1" == '-h' ]]; then
  grep ^#/ "$0" | cut -c4-
  exit
fi

if [[ -z "$GITHUB_TOKEN" ]]; then
  echo "Please export \$GITHUB_TOKEN"
  exit 1
fi

if [[ -z "$(which jq)" ]]; then
  echo "Please install jq: https://stedolan.github.io/jq/"
  exit 1
fi

remote_url=$(git config --get remote.origin.url)
owner_repo=$(echo $remote_url | sed -En 's_^(git@|https://)?github.com(:|/)(.*)/(.*)(.git)?_\3 \4_p')
owner=$(echo $owner_repo | sed 's_ .*__')
repo=$(echo $owner_repo | sed 's_.* __')
branch=${1:-"$(git symbolic-ref HEAD | sed 's_refs/heads/__')"}

endpoint="https://api.github.com/repos/$owner/$repo/pulls"
auth="Authorization: token $GITHUB_TOKEN"

# Get the first matching pull request for $branch
# https://developer.github.com/v3/pulls/#list-pull-requests
pull=$(curl --silent --header "$auth"\
  "$endpoint?head=$owner:$branch"\
  | jq '.[0].number')

# Try to merge
# https://developer.github.com/v3/pulls/#merge-a-pull-request-merge-button
if [[ "$pull" != "null" ]]; then
  response=$(curl --silent --request PUT --data "{}" --header "$auth"\
    "$endpoint/$pull/merge"\
    | jq '.message'\
    | sed 's_"__g')

  if ! [[ "$response" =~ "success" ]]; then
    response="$response\nhttps://github.com/$owner/$repo/pull/$pull"
  fi
else
  response="Couldn't find an open pull request based on $branch."
fi

echo -e "\n$response"
~~~

