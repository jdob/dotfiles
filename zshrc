# Load pre-override settings
if [ -f ~/.localrc-pre ]; then
    . ~/.localrc-pre
fi

# Path to your oh-my-zsh configuration.
ZSH=$HOME/code/oh-my-zsh

# Set name of the theme to load.
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="jdob"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
setopt nocorrectall

alias less="less -FiX"
alias tree="tree -C"

LS_COLORS='no=00:fi=00:di=01;36:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.flac=01;35:*.mp3=01;35:*.mpc=01;35:*.ogg=01;35:*.wav=01;35:';
export LS_COLORS

# Not sure who is setting this, but GREP_OPTIONS is deprecated, so unset
# it here to silence the annoying message.
unset GREP_OPTIONS

# virtualenvwrapper
if [ -f /usr/bin/virtualenvwrapper.sh ]; then
  WORKON_HOME=~/.envs
  source /usr/bin/virtualenvwrapper.sh 
  export VIRTUAL_ENV_DISABLE_PROMPT=1
fi

# Aliases
alias vi=vim
alias emacs=emacs -nw
alias o=openstack

# Functions
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
  aplay "$SOUND" -q
}

git-branch-cleanup () {
  git for-each-ref --format '%(refname:short)' refs/heads | grep -v master | xargs git branch -D
}

# libvirt
export LIBVIRT_DEFAULT_URI=qemu:///system

# Load local override settings
if [ -f ~/.localrc ]; then
    . ~/.localrc
fi

