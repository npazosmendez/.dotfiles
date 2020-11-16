# Common shell configuration
if [ -f ~/.shellrc ]; then
    . ~/.shellrc
fi

# Aliases
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi


# Enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# bash-completion doesn't seem to load git-prompt in manjaro
if [ -f /usr/share/git/completion/git-prompt.sh ]; then
    . /usr/share/git/completion/git-prompt.sh
fi

# Prompt
function light_prompt {
    export PS1="[\$?] $Bold$Blue\w$Reset_Style $ "
}
function fancy_prompt {
    if [[ `type -t __git_ps1` != 'function' ]]
    then
      # __git_ps1 not available for some reason, just use the light prompt
      light_prompt
      return
    fi

    # local __user_and_host="\[\033[01;32m\]\u@\h"
    # local __mercurial_branch='`hg identify --branch 2> /dev/null`'
    local __cur_location="\[\033[01;34m\][ \w ]"
    local __git_branch_color="\[\033[31m\]"
    local __git_branch='`__git_ps1 2> /dev/null`'
    local __prompt_tail="\[\033[35m\]"
    local __last_color="\[\033[00m\]"
    local __ret_code='\[\033[31m\]`ret=$?; if [ $ret -ne 0 ]; then echo "($ret) "; fi`\[\033[00m\]'

    export PS1="$__ret_code$__cur_location$__git_branch_color$__git_branch$__prompt_tail$__last_color$ "
}
fancy_prompt
unset fancy_prompt
unset light_prompt

# Avoids writing duplicated commands to history
export HISTCONTROL=erasedups
HISTSIZE=1000
HISTFILESIZE=5000

# Appends modified commands to history instead of overwriting them
shopt -s histappend

# Disables 'feature' activated with Ctrl-S which disables terminal output
# https://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator
if [[ $- == *i* ]] # if interactive
then
    stty -ixon
fi

# Check the window size after each command
shopt -s checkwinsize

if [ -f ~/.fzf.bash ]
then
  . ~/.fzf.bash
fi

