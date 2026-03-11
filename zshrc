# -- Local Override ----------

if [ -f ~/.localrc-pre ]; then
    . ~/.localrc-pre
fi

# -- Theme Engine ----------

ENGINE_OH_MY_ZSH=1
ENGINE_POWERLINE=2
# THEME_ENGINE=$ENGINE_POWERLINE
THEME_ENGINE=$ENGINE_OH_MY_ZSH

# -- Oh My Zsh ----------

if [ $THEME_ENGINE = $ENGINE_OH_MY_ZSH ]; then

    # Disable warning on mac
    ZSH_DISABLE_COMPFIX=true

    # Path to your oh-my-zsh configuration.
    ZSH=$HOME/Code/oh-my-zsh

    # Set name of the theme to load.
    # Optionally, if you set this to "random", it'll load a random theme each
    # time that oh-my-zsh is loaded.
    ZSH_THEME="jdob-iv"
    # ZSH_THEME="powerlevel9k/powerlevel9k"

    # Set to this to use case-sensitive completion
    # CASE_SENSITIVE="true"

    # Comment this out to disable weekly auto-update checks
    DISABLE_AUTO_UPDATE="true"

    # Uncomment following line if you want red dots to be displayed while waiting for completion
    COMPLETION_WAITING_DOTS="true"

    # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
    # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
    # Example format: plugins=(rails git textmate ruby lighthouse)
    # plugins=(git docker sudo)
    # plugins=(git python go oc sudo zsh-autosuggestions)
    plugins=(git python go sudo)

    # Start oh-my-zsh
    source $ZSH/oh-my-zsh.sh
fi

# -- Powerline ----------

if [ $THEME_ENGINE = $ENGINE_POWERLINE ]; then

    # There may be a better way of doing this, but for now this works across all of my machines

    if [ -f /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh ]; then
        source /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
    fi

    if [ -f /home/jdob/.local/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh ]; then
        source /home/jdob/.local/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh
    fi
fi

# -- Aliases ----------

alias less="less -FiX"
alias tree="tree -C"

alias ls="ls --color"
alias ll="ls -l"
alias ..="cd .."
alias watch="watch "

alias vi=vim
alias emacs=emacs -nw

alias k=kubectl

alias files="xdg-open ."

# -- Python ----------

WORKON_HOME=~/Code/.venvs
if [ -f /usr/bin/virtualenvwrapper.sh ]; then
  source /usr/bin/virtualenvwrapper.sh
fi

# MacOS (maybe also Ubuntu?)
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
  source /usr/local/bin/virtualenvwrapper.sh
fi

# Ubuntu
if [ -f /usr/share/virtualenvwrapper/virtualenvwrapper.sh ]; then
  source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
fi

export VIRTUAL_ENV_DISABLE_PROMPT=1

# -- Go ----------

export GOPATH=$HOME/Code/.go
export PATH=$GOPATH/bin:$PATH

# -- Node.js ----------

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# -- Ruby ----------

if command -v rbenv &>/dev/null; then
  eval "$(rbenv init - zsh)"
fi

# -- kubectl ----------

export KUBE_EDITOR=vim

# -- Functions ----------

_bb () {
  $*
  RESULT=$?
  RESULT_TXT="FAILED"
  SOUND="/home/jdob/.sounds/bb8-failure.wav"
  if [ "$RESULT" -eq "0" ]; then
    RESULT_TXT="SUCCESS"
    SOUND="/home/jdob/.sounds/bb8-success.wav"
  fi
  notify-send "$RESULT_TXT :: $*"
  if [ -f $SOUND ]; then
    aplay "$SOUND" -q
  fi
}

bb () {
  local START_NS END_NS ELAPSED_MS
  START_NS=$(date +%s%N)
  "$@"
  END_NS=$(date +%s%N)  
  local EXIT_CODE=$?
  ELAPSED_MS=$(( (END_NS - START_NS) / 1000000 ))

  local TITLE
  [[ $EXIT_CODE -eq 0 ]] && TITLE="SUCCESS" || TITLE="FAILURE" 

  # notify-send "${TITLE}" "Command '$*' exited with code ${EXIT_CODE} in ${ELAPSED_MS}ms"
  notify-send "${TITLE}" "$* :: ${EXIT_CODE} :: ${ELAPSED_MS}ms"
}

git-branch-cleanup () {
  git fetch --prune
  git branch --merged main | grep -v '^\*\|main\|master\|develop' | xargs git branch -d  
}

docker-clean () {
  docker rm $(docker ps -a -q)
}

docker-image-clean () {
  docker rmi $(docker images -q)
}

docker-ps () {
  docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}"
}
# -- Misc ----------

setopt nocorrectall
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# Not sure who is setting this, but GREP_OPTIONS is deprecated, so unset
# it here to silence the annoying message.
unset GREP_OPTIONS

# Not sure who is setting this, but it's getting in the way of system themes
unset LS_COLORS

# History
# HISTFILE=~/.zsh_history
# HISTSIZE=10000
# SAVEHIST=1000
unsetopt SHARE_HISTORY
export HISTCONTROL=erasedups:ignorespace

# Local Binaries
export PATH=~/.local/bin:~/Applications/bin:$PATH

# pywal
# (cat $HOME/.config/wpg/sequences &)
if [ -f ~/.cache/wal/sequences ]; then
    (cat ~/.cache/wal/sequences &)
fi

# oh-my-zsh turns this on by default, meaning every cd will push the previous
# directory to the stack
unsetopt auto_pushd

# -- Local Override ----------

if [ -f ~/.localrc ]; then
    . ~/.localrc
fi
