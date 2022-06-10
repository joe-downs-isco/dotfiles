# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000
setopt autocd nomatch
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/joe/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


# Variable to hold a newline so that we can have multi-line prompts. zsh is
# kinda weird about them (sending them down in to another line, but I can't
# actually see what that new line is (it's off the screen.))
NEWLINE=$'\n'
PS1="%F{green}[%*]%F{yellow}%n@%m:%F{red}%~${NEWLINE}%F{cyan}%(!.#.$)%f "
