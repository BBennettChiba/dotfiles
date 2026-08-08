eval "$(mise activate zsh)"
eval "$(zoxide init zsh)"
# eval "$(atuin init zsh)"
eval "$(thefuck --alias)"
eval "$(drift shell-init zsh)"

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


