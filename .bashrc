# Common shell configuration
if [ -f ~/.shellrc ]; then
    . ~/.shellrc
fi

# Aliases
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

# Prompt with branch info
function color_my_prompt {
    # local __user_and_host="\[\033[01;32m\]\u@\h"
    # local __mercurial_branch='`hg identify --branch 2> /dev/null`'
    local __cur_location="\[\033[01;34m\]\w"
    local __git_branch_color="\[\033[31m\]"
    local __git_branch='`__git_ps1 2> /dev/null`' # TODO: test if __git_ps1 present
    local __prompt_tail="\[\033[35m\]$"
    local __last_color="\[\033[00m\]"
    export PS1="$__cur_location $__git_branch_color$__git_branch$__mercurial_branch$__prompt_tail$__last_color "
}
color_my_prompt
unset color_my_prompt

# Avoids writing duplicated commands to history
export HISTCONTROL=erasedups
HISTSIZE=1000
HISTFILESIZE=2000

# Appends modified commands to history instead of overwriting them
shopt -s histappend

# Disables 'feature' activated with Ctrl-S which disables terminal output
# https://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator
stty -ixon

# Check the window size after each command
shopt -s checkwinsize

# Enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
