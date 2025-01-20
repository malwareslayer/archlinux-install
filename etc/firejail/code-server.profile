include code-server.local
include globals.local

# Default Java
include allow-java.inc

noblacklist ${PATH}/javac

whitelist /usr/bin/java
whitelist /usr/bin/javac
# =======

include disable-common.inc
include disable-devel.inc
# include disable-exec.inc
include disable-interpreters.inc
include disable-programs.inc

whitelist ${HOME}/.config/fish/fish_variables
whitelist ${HOME}/.config/fish/completions
whitelist ${HOME}/.config/fish/conf.d
whitelist ${HOME}/.config/fish/functions/fish_greeting.fish
whitelist ${HOME}/.config/fish/functions/fish_right_prompt.fish

whitelist ${HOME}/.config/omf
whitelist ${HOME}/.local/share/omf

## Code Server User Directory
whitelist ${HOME}/.config/code-server
whitelist ${HOME}/.local/share/code-server

whitelist /usr/bin/code-server
## =======

## Default Shared
whitelist ${HOME}/Documents/Workspaces Shared
## =======

whitelist /usr/bin/cd
whitelist /usr/bin/clear
whitelist /usr/bin/basename
whitelist /usr/bin/bash
whitelist /usr/bin/date
whitelist /usr/bin/dirname
whitelist /usr/bin/echo
whitelist /usr/bin/env
whitelist /usr/bin/file
whitelist /usr/bin/fish
whitelist /usr/bin/git
whitelist /usr/bin/jobs
whitelist /usr/bin/kill
whitelist /usr/bin/ls
whitelist /usr/bin/mkdir
whitelist /usr/bin/readlink
whitelist /usr/bin/realpath
whitelist /usr/bin/sh
whitelist /usr/bin/shellfirm
whitelist /usr/bin/set
whitelist /usr/bin/stat
whitelist /usr/bin/stty
whitelist /usr/bin/test
whitelist /usr/bin/uname
whitelist /usr/bin/wc

noblacklist /sbin
noblacklist /usr/sbin
noblacklist /usr/bin
noblacklist /usr/lib

blacklist /boot
blacklist /var
blacklist /efi
blacklist /mnt
blacklist /opt
blacklist /root
blacklist /srv

caps.drop all
ipc-namespace
no3d
nodvd
nogroups
nonewprivs
noroot
nosound
notv
nou2f
novideo
seccomp

disable-mnt
private-dev
private-tmp

restrict-namespaces
