#!/bin/sh

gh_version()
{
    wget -O- https://api.github.com/repos/cli/cli/releases/latest | grep tag_name | cut -d : -f 2,3 | tr -d v\", | xargs
}

gh_ubuntu()
{
    VERSION=$(gh_version)
    wget -O /tmp/gh-cli.deb https://github.com/cli/cli/releases/download/v${VERSION}/gh_${VERSION}_linux_amd64.deb
    apt install -fy /tmp/gh-cli.deb
}

echo "Checking if key exists...\n"

if [ -f "$HOME/.ssh/id_rsa" ]
then
    echo "Key detected at ~/.ssh/id_rsa!\n"
else
    echo "No key detected - creating key...\n"
    ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa -q -N ""
    echo "Key created at ~/.ssh/id_rsa!\n"
fi

echo "Checking for GitHub CLI...\n"

if [ command -v gh &> /dev/null ]
then
    echo "GitHub CLI is already installed!\n"
else
    echo "GitHub CLIdock is not installed!\n"
    echo "Fetching GitHub CLI installer...\n"
    gh_ubuntu
    echo "GitHub CLI is now installed!"
fi

echo "Now authenticating to GitHub:\n"
gh auth login
