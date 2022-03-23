# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ $USER == "root" ]; then
    prompt_char="#"
else
    prompt_char="$"
fi

# Force the terminal mode to fix tmux and GNU screen causing emacs to show
# colors incorrectly.
export TERM=xterm-256color

export PS1="\[\e[1;32m\][\T]\[\e[0;33m\]\u@\H:\[\e[31m\]\w\[\e[0m\]
\[\e[1;36m\]$prompt_char\[\e[0m\] "

# Set ~/go as $GOPATH
if [ -x ~/go ]; then
    export GOPATH="~/go"
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


# User specific aliases and functions

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

source /usr/share/doc/fzf/examples/key-bindings.bash
source /usr/share/doc/fzf/examples/completion.bash

# enable color support of ls (and group directories first) and also add handy
# aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto --group-directories-first'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# Add thefuck alias for correcting typos in command calls
eval $(thefuck --alias)


# Test if cowsay, figlet, and fortune are installed. If any of them are not,
# notify the user and do not output the typical welcome / MOTD. If they are
# installed, do nothing and output the welcome / MOTD.
if [ -x /usr/games/cowsay ] && [ -x /usr/bin/figlet ] && [ -x /usr/games/fortune ]; then
    # Get block letters for
    # "Welcome", add a fortune cookie to the end and pipe that output through cowsay
    # with tux, which is consequently piped through lolcat for crazy colors, if
    # lolcat exists, if not just print it out.
    if [ -x /snap/bin/lolcat ]; then
	(figlet -c Welcome; fortune) | cowsay -f tux -n | lolcat
    else
	(figlet -c Welcome; fortune) | cowsay -f tux -n
    fi
else
    echo
    echo "cowsay, figlet, or fortune is missing!"
    echo
fi
