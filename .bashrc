# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export PS1="\[\e[1;32m\][\T]\[\e[0;33m\]\u@\H:\[\e[31m\]\w\[\e[0m\]
\[\e[1;36m\]$ \[\e[0m\] "

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
