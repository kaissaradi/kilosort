# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Path configuration
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Prompt styling
PS1="\[\e[1;33m\][\[\e[1;35m\]\w\[\e[1;32m\]]\[\e[1;31m\]$\[\e[0m\] "

# History settings
HISTSIZE=10000
HISTFILESIZE=10000
HISTFILE=~/.bash_history
HISTCONTROL=ignoreboth
shopt -s histappend

# Check window size after each command
shopt -s checkwinsize

# Enhanced tab completion
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"
bind "set menu-complete-display-prefix on"
bind 'TAB':menu-complete

# Command history search
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Enable color support
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Common aliases
alias l='ls'
alias la='exa -a'
alias ll='exa -la'
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'
alias ..='cd ..'
alias gs='git status'
alias cl='clear'
alias fd='fdfind'
alias bat='batcat'

# Alert alias for long running commands
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# WSL fix
fix_wsl2_interop() {
    for i in $(pstree -np -s $$ | grep -o -E '[0-9]+'); do
        if [[ -e "/run/WSL/${i}_interop" ]]; then
            export WSL_INTEROP=/run/WSL/${i}_interop
        fi
    done
}

# Exports
export EDITOR=vim
export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"
export PATH

# Preferred editor settings
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Edit line in vim with ctrl-e
bind '"\C-e": edit-command-line'

# Enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# HSTR configuration - add this to ~/.bashrc
alias hh=hstr                    # hh to be alias for hstr
export HSTR_CONFIG=hicolor       # get more colors
shopt -s histappend              # append new history items to .bash_history
export HISTCONTROL=ignorespace   # leading space hides commands from history
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
# ensure synchronization between bash memory and history file
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"
function hstrnotiocsti {
    { READLINE_LINE="$( { </dev/tty hstr ${READLINE_LINE}; } 2>&1 1>&3 3>&- )"; } 3>&1;
    READLINE_POINT=${#READLINE_LINE}
}
# if this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
if [[ $- =~ .*i.* ]]; then bind -x '"\C-r": "hstrnotiocsti"'; fi
export HSTR_TIOCSTI=n

