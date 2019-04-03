# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export PS1="\[\e[1;35m\][\T]\[\e[0;34m\]\u@\H:\[\e[32m\]\w\[\e[0m\]
\[\e[1;31m\]$ \[\e[0m\] "

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
