#  Startup 
# Commands to execute on startup (before the prompt is shown)
# Check if the interactive shell option is set

# Load user modules
for file in "${ZDOTDIR:-$HOME/.config/zsh}/user/"*.zsh; do
    [ -r "$file" ] && source "$file"
done


# .zshenv (which sources this file) runs on every zsh invocation, including
# the transient outer shell that .zshrc's `eval "$(iris init zsh)"` immediately
# exec's away into iris. iris then spawns its own inner zsh (with IRIS_PID
# set) for the actual interactive session. Without this guard, the greeting
# below runs once in the throwaway outer shell (before iris's PTY is fully up,
# so fastfetch falls back to block graphics) and again in the real inner
# shell -- showing twice per new terminal window.
if [[ $- == *i* ]] && { [[ -n $IRIS_PID ]] || [[ -n $IRIS_RESCUE ]] || ! command -v iris >/dev/null; }; then
    # This is a good place to load graphic/ascii art, display system information, etc.
    if command -v pokego >/dev/null; then
        pokego --no-title -r 1,3,6
    elif command -v pokemon-colorscripts >/dev/null; then
        pokemon-colorscripts --no-title -r 1,3,6
    elif command -v fastfetch >/dev/null; then
        if do_render "image"; then
            fastfetch
        fi
    fi
fi


#   Overrides 
# HYDE_ZSH_NO_PLUGINS=1 # Set to 1 to disable loading of oh-my-zsh plugins, useful if you want to use your zsh plugins system 
# unset HYDE_ZSH_PROMPT # Uncomment to unset/disable loading of prompts from HyDE and let you load your own prompts
# HYDE_ZSH_COMPINIT_CHECK=1 # Set 24 (hours) per compinit security check // lessens startup time
# HYDE_ZSH_OMZ_DEFER=1 # Set to 1 to defer loading of oh-my-zsh plugins ONLY if prompt is already loaded

if [[ ${HYDE_ZSH_NO_PLUGINS} != "1" ]]; then
    #  OMZ Plugins 
    # manually add your oh-my-zsh plugins here
    plugins=(
        "sudo"
        git
        zsh-vi-mode
    )
fi

export PNPM_HOME="/home/bryson/.local/share/pnpm"
case ":PATH:" in
  *":PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
unsetopt correct_all
unsetopt correct

