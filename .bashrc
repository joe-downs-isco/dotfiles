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

# Add ~/.emacs.d/bin to the $PATH so that we can call 'doom' directly
export PATH=$HOME/.emacs.d/bin:$PATH

# Add ~/git/dotfiles/shell to the path so we can call our custom scripts
# directly.
export PATH=$HOME/git/dotfiles/shell:$PATH

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

# If we're on Linux, alias 'xdg-open' to be just 'open'. This is hopefully to
# avoid breaking it on Mac, since they have 'open' by default (if I ever even go
# on one...). Bash gives us the variable, $OSTYPE so we'll check if that is
# "linux-gnu"
if [ $OSTYPE == "linux-gnu" ]; then
    alias open='xdg-open'
fi

# Alias a command "weather" to do `curl wttr.in?mF` (get the weather for my
# current location in metric and don't add the 'follow' line)
# https://wttr.in/:help.
alias weather="curl wttr.in?mF"

# Alias a command to get the current timestamp in YYYY-MM-DD-hhmmss format
alias timestamp="date +%F-%H%M%S"

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
