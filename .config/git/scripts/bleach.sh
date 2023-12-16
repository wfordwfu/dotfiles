#!/bin/sh

git fetch origin
git reset --hard origin/main
git clean -f -d

echo "## Bleached!! ##"
echo "Local repo has been reset to match remote."