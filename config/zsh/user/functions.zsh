# Integrate Yazi file manager: opens Yazi and changes directory to its last location.
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	/usr/bin/rm -f -- "$tmp"
}

# Create a new directory and enter it.
mkd() {
    mkdir -p "$@" && cd "$@" || return 1
}

# Extract various archive types.
# Requires corresponding extraction utilities (tar, bunzip2, unrar, etc.) to be installed.
ex () {
    if [ -f "$1" ] ; then
        case "$1" in
            *.tar.bz2)   tar xvjf "$1"                  ;;
            *.tar.gz)    tar xvzf "$1"                  ;;
            *.bz2)       bunzip2 "$1"                   ;;
            *.rar)       unrar x "$1"                   ;;
            *.gz)        gunzip "$1"                    ;;
            *.tar)       tar xvf "$1"                   ;;
            *.tbz2)      tar xvjf "$1"                  ;;
            *.tgz)       tar xvzf "$1"                  ;;
            *.zip)       unzip "$1"                     ;;
            *.Z)         uncompress "$1"                ;;
            *.7z)        7z x "$1"                      ;;
            *)           echo "can't extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}
