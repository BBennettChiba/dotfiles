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

path_prepend() {
  local dir="$1"
  [[ -z "$dir" || ! -d "$dir" ]] && return 0
  case ":$PATH:" in
    *":$dir:"*) ;;
    *) PATH="$dir:$PATH" ;;
  esac
}
path_append() {
  local dir="$1"
  [[ -z "$dir" || ! -d "$dir" ]] && return 0
  case ":$PATH:" in
    *":$dir:"*) ;;
    *) PATH="$PATH:$dir" ;;
  esac
}

#PATH
path_prepend "$HOME/.local/share/omarchy/bin"
path_prepend "$HOME/bin"
path_prepend "$HOME/.local/bin"
path_prepend "/usr/local/mysql/bin"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export _Z_DATA="$XDG_DATA_HOME/z" 
export WINEPREFIX="$XDG_DATA_HOME""/win"

export DRIFT_TIMEOUT=120   # seconds of inactivity (default: 120)

export ANDROID_HOME=$HOME/Android/Sdk
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
export PATH="$JAVA_HOME/bin:$ANDROID_HOME/platform-tools:$PATH"

export PATH;
