# Description

This is a shell script which automates setting up GitHub with SSH authentication.

Currently supports Ubuntu (probably also other Debians) with support for Windows (Git Bash) and macOS to come. It should also work on WSL but has not been tested.

```sh
$ sh ./github-ssh.sh
```

Dockerfile builds image for testing script in Ubuntu 20.04. Note final authentication step *will* fail due to lack of web browser in container.

```sh
$ docker build . -t github-ssh
$ docker run --rm -it -v $PWD:/working -w /working github-ssh /bin/bash
$ sh ./github-ssh.sh
```