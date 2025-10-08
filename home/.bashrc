# --- Shell Frameworks and Interactive Session Setup ---

# Initialize Ble.sh if in an interactive session.
# Ble.sh provides a rich interactive environment.
# shellcheck disable=SC1094
[[ $- == *i* ]] && source -- /home/bryson/.local/share/blesh/ble.sh --attach=none

# Set vi keybindings for interactive sessions if preferred.
if [[ $- == *i* ]]; then
  set -o vi
fi


# --- Environment Variables ---

# Add custom binaries and MySQL to the PATH.
# Keep custom paths at the beginning to prioritize them.
export PATH="/home/bryson/bin:/usr/local/mysql/bin:$PATH"

# Define the root directory for AzerothCore-WotLK.
export AC_CODE_DIR=/home/bryson/Games/wow/azerothcore-wotlk

# Securely retrieve OpenAI API key using pass.
if ! OPENAI_API_KEY_VALUE="$(pass show openAIToken)"; then
    echo "Error: Failed to retrieve OpenAI API token from 'pass show openAIToken'." >&2
    exit 1 
fi

# Export the variable if successful
export OPENAI_API_KEY="${OPENAI_API_KEY_VALUE}"

# Set default pagers for man pages and general output to 'most -s'.
export MANPAGER="most -s"
export PAGER="most -s"

# FZF (Fuzzy Finder) Configuration
# Default command for fzf to search hidden files, follow symlinks, and exclude specific directories.
export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude=.git --exclude=node_modules'

# Extensive FZF options for layout, preview, prompts, colors, and keybinds.
# The preview command uses 'bat' for syntax highlighting, 'eza' for directory listings.
# Ensure 'bat', 'eza', and '$CLIPCOPY' (for clipboard integration) are installed/defined.
export FZF_DEFAULT_OPTS="
--layout=reverse --info=inline --height=80% --multi --cycle --margin=1 --border=rounded
--preview '([[ -f {} ]] && (bat --style=numbers --color=always --line-range=:500 {} || cat {})) || ([[ -d {} ]] \
&& (eza -ahlT -L=2 -s=extension --group-directories-first --icons --git --git-ignore --no-user {} | less)) || echo {} 2> /dev/null | head -200'
--prompt=' ' --pointer=' ' --marker=' '
--color='hl:148,hl+:154,prompt:blue,pointer:032,marker:010,bg+:000,gutter:000'
--preview-window=right:65%
--bind 'ctrl-j:down,ctrl-k:up'
--bind '?:toggle-preview'
--bind 'ctrl-a:select-all'
--bind 'ctrl-y:execute-silent(echo {+} | \$CLIPCOPY)'
--bind 'ctrl-e:become(xdg-open {+})'"

# Ignore common or short commands from bash history to keep it clean.
# This regex ignores commands consisting primarily of special characters or numbers.
HISTIGNORE=$'*([\t ])+([-%+,./0-9\:@A-Z_a-z])*([\t ])'


# --- Sourcing Other Configuration Files ---

# Source omarchy's bash configuration.
source /home/bryson/.local/share/omarchy/default/bash/rc

# Initialize Atuin for shell history management.
eval "$(atuin init bash)"

# Initialize The Fuck for correcting mistyped commands.
eval "$(thefuck --alias)"

# Initialize FZF's bash keybindings and fuzzy completion.
eval "$(fzf --bash)"


# --- Custom Functions ---

# Command for updating system packages using pacman and yay.
# This is specific to Arch-based systems.
UPDATE_PACKAGES="sudo pacman -Syu && yay -Syu"

# Function to execute the package update command in a floating terminal.
update ()
{
    omarchy-launch-floating-terminal-with-presentation "$UPDATE_PACKAGES"
}

# Integrate Yazi file manager: opens Yazi and changes directory to its last location.
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
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

# Grep for a string using ripgrep (rg) and open the selected file in the editor.
# Uses fzf for interactive selection and requires 'rg' and '$EDITOR'.
grep_open(){
  # shellcheck disable=SC2153
  local editor="$EDITOR +/$1 + 'norm! n'"
  rg -l "$1" | fzf --bind "enter:execute($editor + {})"
}

# Override man command to display colored man pages.
# Sets LESS_TERMCAP variables for color definitions.
man() {
    env \
        LESS_TERMCAP_mb="$(printf "\e[1;31m")" \
        LESS_TERMCAP_md="$(printf "\e[1;36m")" \
        LESS_TERMCAP_me="$(printf "\e[0m")" \
        LESS_TERMCAP_se="$(printf "\e[0m")" \
        LESS_TERMCAP_so="$(printf "\e[1;44;33m")" \
        LESS_TERMCAP_ue="$(printf "\e[0m")" \
        LESS_TERMCAP_us="$(printf "\e[1;32m")" \
        PAGER="${commands[less]:-$PAGER}" \
        _NROFF_U=1 \
        PATH="$HOME/bin:$PATH" \
        man "$@"
}

# --- Aliases ---

# Alias to start AzerothCore.
alias start_ac='$HOME/scripts/start_ac.sh'

# Alias 'cat' to 'bat' for syntax highlighting and file viewing enhancements.
alias cat=bat

# Alias 'please' to re-run the last command with sudo.
alias please='sudo $(fc -ln -1)'

alias dust="du -sh * | sort -hr"

alias taskt=taskwarrior-tui

# --- FZF Custom Completion Functions ---

# Custom FZF completion function for specific commands (cd, nvim).
# Provides different previews based on the command.
_fzf_comprun() {
    local command="$1"
    shift

    case "$command" in
    cd) fzf "$@" --preview 'exa -TFl --group-directories-first --icons --git -L 2 --no-user {}' ;;
    nvim) fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}' ;;
    *) fzf "$@" ;;
    esac
}

# --- Final Ble.sh Initialization ---

# Attach Ble.sh once all other configurations are loaded.
# This should typically be the very last command in bashrc.
[[ ! ${BLE_VERSION-} ]] || ble-attach
export PATH=$PATH:$HOME/.local/bin

# Added by LM Studio CLI tool (lms)
export PATH="$PATH:/home/bryson/.lmstudio/bin"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
