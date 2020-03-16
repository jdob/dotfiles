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

    # Path to your oh-my-zsh configuration.
    ZSH=$HOME/Code/oh-my-zsh

    # Set name of the theme to load.
    # Optionally, if you set this to "random", it'll load a random theme each
    # time that oh-my-zsh is loaded.
    ZSH_THEME="jdob"
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
    plugins=(git docker sudo)

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

export GOPATH=$HOME/Code/go
export GOROOT=$HOME/Code/go-1.12
export PATH=$GOPATH/bin:$PATH

# -- Functions ----------

bb () {
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

git-branch-cleanup () {
  git for-each-ref --format '%(refname:short)' refs/heads | grep -v master | xargs git branch -D
}

docker-clean() {
  docker rm $(docker ps -a -q)
}

docker-image-clean() {
  docker rmi $(docker images -q)
}

oc-running() {
  oc get pods | grep -v deploy
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
(cat ~/.cache/wal/sequences &)


# -- Local Override ----------

if [ -f ~/.localrc ]; then
    . ~/.localrc
fi

