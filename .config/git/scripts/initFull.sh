#!/bin/sh

username=$(git config user.name)
email=$(git config user.email)

# Check if user config set
if [ -z "$username" ] || [ -z "$email" ]; then
    echo "It seems your user.name and/or user.email are not configured in git." 
    echo "If you have the GitHub cli, you can re-run the addGitHelper script to set it."
    echo "Otherwise, you can manually set your username with the following command:"
    echo "git config --global user.name \"Your Name\""
    echo "git config --global user.email \"youremail@example.com\""
fi

# Check if .git exists
if [ ! -d .git ]; then
    echo "Initializing git repository."
    git init
fi

# Check if README.md exists
if [ ! -f README.md ]; then
    echo "Generating README.md file."
    cat <<EOF > README.md
# $(basename "$PWD")

This is an example file for a new project.

## Reference

- This is a default README.md file created by [GitHelper](https://github.com/wake-forest-ctsi/GitHelper).

EOF
fi

# Check if .gitattributes exists (windows line endings)
if [ ! -f .gitattributes ]; then
    echo "Generating .gitattributes file."
    cat <<EOF > .gitattributes
* text=auto eol=lf
*.{cmd,[cC][mM][dD]} text eol=crlf
*.{bat,[bB][aA][tT]} text eol=crlf
EOF
fi

# Check if .gitignore exists
if [ ! -f .gitignore ]; then
    echo "Generating .gitignore file."
    cat <<EOF > .gitignore
# Go find a good starter .gitignore file at
# https://github.com/github/gitignore
# Best case, keep it as short as possible.
# IMPORTANT: Use this to keep your .env file out of git
.env
EOF
fi