#!/bin/bash
# Deploy to GitHub Pages,
# based on a script from https://gist.github.com/domenic/ec8b0fc8ab45f39403dd

# Exit with nonzero exit code if anything fails
set -e

# Make the project using the default target
gulp

# Go to the target directory and create a new Git repo.
cd dist
git init

# Inside this git repo we'll pretend to be a new user
git config user.name "Travis CI"
git config user.email "${CI_EMAIL}"

# Commit the distribution files
# (Later, could remove unneeded files with something like `git reset -- WEB-INF META-INF`)
git add .
git commit -m "Deploy to GitHub Pages"

# Force push from the current repo's master branch to the remote
# repo's gh-pages branch. (All previous history on the gh-pages branch
# will be lost, since we are overwriting it.) We redirect any output to
# /dev/null to hide any sensitive credential data that might otherwise be exposed.
git push --force --quiet "https://${GH_TOKEN}@${GH_REF}" master:gh-pages  > /dev/null 2>&1
