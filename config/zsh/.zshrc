# Add user configurations here
# For HyDE to not touch your beloved configurations,
# we added a config file for you to customize HyDE before loading zshrc
# Edit $ZDOTDIR/.user.zsh to customize HyDE before loading zshrc

#  Plugins 
# oh-my-zsh plugins are loaded  in $ZDOTDIR/.user.zsh file, see the file for more information

#  Aliases 
# Override aliases here in '$ZDOTDIR/.zshrc' (already set in .zshenv)

# # Helpful aliases
alias c='clear'                                                        # clear terminal
alias l='eza -lh --icons=auto'                                         # long list
alias ls='eza -1 --icons=auto'                                         # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto'                                       # long list dirs
alias lt='eza --icons=auto --tree'                                     # list folder as tree
alias un='$aurhelper -Rns'                                             # uninstall package
alias up='$aurhelper -Syu'                                             # update system/package/aur
alias pl='$aurhelper -Qs'                                              # list installed package
alias pa='$aurhelper -Ss'                                              # list available package
alias pc='$aurhelper -Sc'                                              # remove unused cache
alias po='$aurhelper -Qtdq | $aurhelper -Rns -'                        # remove unused packages, also try > $aurhelper -Qqd | $aurhelper -Rsu --print -
alias vc='code'                                                        # gui code editor
alias fastfetch='fastfetch --logo-type auto'

# Alias to start AzerothCore.
alias start_ac='$HOME/scripts/start_ac.sh'

# Alias 'cat' to 'bat' for syntax highlighting and file viewing enhancements.
# alias cat=bat

# Alias 'please' to re-run the last command with sudo.
alias please='sudo $(fc -ln -1)'

alias dust="du -sh * | sort -hr"

alias taskt=taskwarrior-tui


# # Directory navigation shortcuts
# alias ..='cd ..'
# alias ...='cd ../..'
# alias .3='cd ../../..'
# alias .4='cd ../../../..'
# alias .5='cd ../../../../..'

# # Always mkdir a path (this doesn't inhibit functionality to make a single dir)
# alias mkdir='mkdir -p'

#  This is your file 
# Add your configurations here
export EDITOR=nvim
export TERMINAL=ghostty

# Add custom binaries and MySQL to the PATH.
# Keep custom paths at the beginning to prioritize them.
export PATH="/home/bryson/bin:/usr/local/mysql/bin:$PATH"
export PATH="$HOME/.local/share/omarchy/bin:$PATH"

# Define the root directory for AzerothCore-WotLK.
export AC_CODE_DIR=/home/bryson/Games/wow/azerothcore-wotlk

# Securely retrieve OpenAI API key using pass.
if ! OPENAI_API_KEY_VALUE="$(pass show openAIToken)"; then
    echo "Error: Failed to retrieve OpenAI API token from 'pass show openAIToken'." >&2
    exit 1 
fi

# Export the variable if successful
export OPENAI_API_KEY="${OPENAI_API_KEY_VALUE}"

unset -f command_not_found_handler # Uncomment to prevent searching for commands not found in package manager

eval "$(mise activate zsh)"

eval "$(atuin init zsh)"

# Initialize The Fuck for correcting mistyped commands.
eval "$(thefuck --alias)"

# Initialize FZF's bash keybindings and fuzzy completion.
# eval "$(fzf --zsh)"

eval "$(zoxide init zsh)"

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

# export PATH=$HOME/bin:$PATH

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
