#!/bin/bash
os=`uname`

if [[ "$os" == 'Linux' ]]; then
  JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:bin/javac::")
  alias ls='ls --color=auto'
elif [[ "$os" == 'Darwin' ]]; then
  JAVA_HOME=`/usr/libexec/java_home -v1.7`
  alias ls='ls -G'
fi

# run local bash stuff (pc-specific aliases and such)
if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi

source ~/.exports

export GOPATH=$HOME/projects/go
PATH=/usr/local/bin:/usr/local/go/bin:$PATH
PATH=$PATH:$JAVA_HOME/bin
PATH=$PATH:$HOME/bin
PATH=$PATH:$GOPATH/bin

# common aliases 
alias ls='ls -F --color --show-control-chars'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias st='git status'
alias hs='homesick'
alias hsgit='cd ~/.homesick/repos/dotfiles'

alias ex='open . &'
alias tod='cd ~/projects'
alias tog='cd ~/Google\ Drive'
alias killds='rm -f $(find . -name ".DS_Store" -type f)'
alias sshul='ssh ubuntu@ultilabs.xyz'
alias sshcc='ssh ubuntu@cason.cc'
alias gitlogs='git log --decorate --graph --oneline --all'

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

source ~/.git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWCOLORHINTS=1
PROMPT_DIRTRIM=5
PROMPT_COMMAND='__git_ps1 "\[\e[01;34m\]\w\[\e[0m\]" "\n\h\$ "'

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Avoid duplicates
export HISTCONTROL=ignoredups:erasedups  
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# After each command, append to the history file and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# push public key to remote servers
function ssh-pushkey {
  ssh $1 "echo '`cat ~/.ssh/id_rsa.pub`' >> ~/.ssh/authorized_keys"
}

# add something to gitignore
function gi {
  echo "$1" >> .gitignore
}

# grab the ip of a docker contanier by name
function dockerip {
  docker inspect --format '{{ .NetworkSettings.IPAddress }}' $1
}

function docker-clean {
  docker rm $(docker ps -a -q)
  docker rmi $(docker images | grep "^<none>" | awk "{print $3}")
}
# `a` with no arguments opens the current directory in Atom Editor, otherwise
# opens the given location
function a() {
  if [ $# -eq 0 ]; then
    atom .;
  else
    atom "$@";
  fi;
}

# Create a new directory and enter it
function mkd() {
  mkdir -p "$@" && cd "$_";
}

function yts() {
  youtube-dl --no-mtime -f bestaudio[ext=mp3] --extract-audio --prefer-ffmpeg --audio-format "mp3" -i -o \(title\)s.%\(ext\)s $1
}

function yt() {
  youtube-dl --no-mtime -f bestvideo[ext=mp4]+bestaudio -i -o %\(title\)s.%\(ext\)s $1
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
  tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

# `o` with no arguments opens the current directory, otherwise opens the given
# location
function o() {
  if [ $# -eq 0 ]; then
    open .;
  else
    open "$@";
  fi;
}

# set up resty if it's there
if [ -e ~/.resty ]; then
    . ~/.resty
fi

# Connect to $1 with credentials $1 : $2.
# Set up for JSON. Don't encode the request URL. Ignore key warnings. 
function resty-auth {
  echo "Connecting to $1 with $2"
  resty $1 -H "Content-Type: application/json" -H "Accept: application/json" -Q -k -u $2:$3
}
