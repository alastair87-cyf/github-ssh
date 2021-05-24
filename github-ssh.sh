#!/bin/bash

gh_ubuntu()
{
    VERSION=$(wget -O- https://api.github.com/repos/cli/cli/releases/latest | grep tag_name | cut -d : -f 2,3 | tr -d v\", | xargs)
    wget -O /tmp/gh-cli.deb https://github.com/cli/cli/releases/download/v${VERSION}/gh_${VERSION}_linux_amd64.deb
    apt install -fy /tmp/gh-cli.deb
    rm -f /tmp/gh-cli.deb
}

gh_mingw()
{
    mkdir -p $HOME/.local/bin
    VERSION=$(curl -s https://api.github.com/repos/cli/cli/releases/latest | grep tag_name | cut -d : -f 2,3 | tr -d v\", | xargs)
    curl -L -o /tmp/gh-cli.zip https://github.com/cli/cli/releases/download/v${VERSION}/gh_${VERSION}_windows_amd64.zip
    unzip -jd /usr/bin/ /tmp/gh-cli.zip bin/gh.exe
    rm -f /tmp/gh-cli.zip
}

get_systype()
{
    IFS="-" read -r -a UNAME_ARR <<< $(uname)
    echo $UNAME_ARR[0]
}

printf "Checking if key exists...\n"

if [ -f "$HOME/.ssh/id_rsa" ]
then
    printf "Key detected at ~/.ssh/id_rsa!\n"
else
    printf "No key detected - creating key...\n"
    ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa -q -N ""
    printf "Key created at ~/.ssh/id_rsa!\n"
fi

printf "Checking for GitHub CLI...\n"

if [ command -v gh &> /dev/null ]
then
    printf "GitHub CLI is already installed!\n"
else
    printf "GitHub CLI is not installed!\n"
    printf "Fetching latest GitHub CLI installer...\n"
    SYS_TYPE = $(get_systype)
    if [[ $SYS_TYPE -eq "Linux" ]]
    then
        gh_ubuntu
    elif [[ $SYS_TYPE -eq "MING64_NT" ]]
    then
        gh_mingw
    fi
    printf "GitHub CLI is now installed!\n"
fi