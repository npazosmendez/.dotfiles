
# MacOS specific
if [[ $OSTYPE == 'darwin'* ]]; then
  # Ignore bash deprecation msg
  export BASH_SILENCE_DEPRECATION_WARNING=1

  # Homebrew paths
  export HOMEBREW_PREFIX="/opt/homebrew";
  export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
  export HOMEBREW_REPOSITORY="/opt/homebrew";
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
  export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
  export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

  # Git completion and prompt
  if [ -d `brew --prefix git`/etc/bash_completion.d/ ]; then
    . `brew --prefix git`/etc/bash_completion.d/git-prompt.sh
    . `brew --prefix git`/etc/bash_completion.d/git-completion.bash
  fi
fi

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

export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1

__get_kube_provider()
{
  CLUSTER_NAME=$(kubectl config view --minify -o jsonpath='{.clusters[].name}')

  if [[ $CLUSTER_NAME == "gke"* ]]; then
    echo "gke"
    return
  else
    SERVER=$(kubectl config view --minify -o jsonpath='{.clusters[].cluster.server}')
    if [[ $SERVER == *"eks.amazonaws.com" ]]; then
      echo "eks"
      return
    elif [[ $SERVER == *"azmk8s.io"* ]]; then
      echo "aks"
      return
    fi
  fi
  echo "unknown"
}

__kube_ps1()
{
  CONTEXT=$(cat ~/.kube/config | grep "current-context:" | sed "s/current-context: //")

  if [ -f "/tmp/bashrc_$CONTEXT" ]; then
    PROVIDER=$(cat "/tmp/bashrc_$CONTEXT")
  else
    PROVIDER="?"
  fi
  __get_kube_provider > /tmp/bashrc_$CONTEXT &

  if [ -n "$CONTEXT" ]; then
      echo "${CONTEXT} (${PROVIDER})"
  fi
}

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
    #local __git_branch_color="\[\033[31m\]"
    local __git_branch='`__git_ps1 %s 2> /dev/null`'
    local __kube_context='`__kube_ps1`'
    local __prompt_tail="\[\033[35m\]"
    local purple="\[\033[01;35m\]"
    local orange="\[\033[01;31m\]"
    local yellow="\[\033[01;33m\]"
    local bold_purple="\[\033[01;35m\]"
    local color_reset="\[\033[00m\]"
    
    local __ret_code='\[\033[31m\]`ret=$?; if [ $ret -ne 0 ]; then echo "($ret) "; fi`\[\033[00m\]'

    export PS1="${yellow}git : $__git_branch $yellow| k8s : ${purple}$__kube_context$color_reset\n$__last_color$__ret_code$__cur_location$color_reset $ "
}
fancy_prompt
unset fancy_prompt
unset light_prompt

# Avoids writing duplicated commands to history
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=1000000
export HISTFILESIZE=1000000
export HISTTIMEFORMAT="[%F %T] "
export HISTIGNORE="cd*:git pull:git st:..:code .:git add ."

export HISTFILE=~/.bash_eternal_history
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

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

export FZF_DEFAULT_OPTS='--color=16'
if [ -f /usr/share/fzf/completion.bash ]
then
  source /usr/share/fzf/completion.bash
  source /usr/share/fzf/key-bindings.bash
fi

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null || eval "$(pyenv init -)"


export PATH=~/.npm-global/bin:$PATH
