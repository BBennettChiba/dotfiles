#XDG
export XCOMPOSEFILE="$XDG_CONFIG_HOME"/X11/xcompose
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
export PARALLEL_HOME="$XDG_DATA_HOME"/parallel
export MYSQL_HISTFILE="$XDG_DATA_HOME"/mysql_history
export GOPATH="$XDG_DATA_HOME"/go
export CARGO_HOME="$XDG_DATA_HOME"/cargo

#ENV
export EDITOR=nvim
export TERMINAL=ghostty
export AC_CODE_DIR=/home/bryson/Games/wow/azerothcore-wotlk
export OMARCHY_PATH=$HOME/.local/share/omarchy
export MANPAGER="nvim +Man!"

#PATH
export PATH="$HOME/.local/share/omarchy/bin:$PATH"
export PATH="/home/bryson/bin:/usr/local/mysql/bin:$PATH"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
