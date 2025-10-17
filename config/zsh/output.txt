#  Startup 
# Commands to execute on startup (before the prompt is shown)
# Check if the interactive shell option is set
if [[ $- == *i* ]]; then
    # This is a good place to load graphic/ascii art, display system information, etc.
    if command -v pokego >/dev/null; then
        pokego --no-title -r 1,3,6
    elif command -v pokemon-colorscripts >/dev/null; then
        pokemon-colorscripts --no-title -r 1,3,6
    elif command -v fastfetch >/dev/null; then
        if do_render "image"; then
            fastfetch --logo-type kitty
        fi
    fi
else 
    eval "$(mise active zsh --shims)"
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

export PATH="$HOME/.local/share/omarchy/bin:$PATH"
export XCOMPOSEFILE="$XDG_CONFIG_HOME"/X11/xcompose

export TERMINAL=ghostty
# Function to save directory contents to a text file with headers
# Ignores files starting with .zcompdump
save_dir_contents_to_file() {
  local output_file="$1"
  local current_dir="${2:-.}" # Default to current directory if no second argument

  # Ensure the output file is provided
  if [[ -z "$output_file" ]]; then
    echo "Usage: save_dir_contents_to_file <output_filename> [directory]"
    return 1
  fi

  # Enable extended glob for Zsh-specific exclusions
  setopt LOCAL_OPTIONS EXTENDED_GLOB

  echo "DEBUG: Finding files in '$current_dir'..." >&2 # Debug message to stderr
  local files
  files=("${(@f)$(find "$current_dir" -type f ! -name ".zcompdump*" | sort)}")
  echo "DEBUG: Found ${#files[@]} files." >&2 # Debug message to stderr

  if [[ -e "$output_file" ]]; then
    echo "Warning: File '$output_file' already exists and will be overwritten."
  fi

  # Clear the output file before writing
  > "$output_file"

  # Iterate through the found files and append their content to the output file
  for file in "${files[@]}"; do
    # Get the relative path for the header, or full path if current_dir is not '.'
    local display_path
    if [[ "$current_dir" == "." ]]; then
      display_path="${file#./}" # Remove leading ./
    else
      display_path="$file"
    fi

    echo "DEBUG: Processing file: $display_path" >&2 # Debug message to stderr

    echo "--- FILE START: $display_path ---" >> "$output_file"
    # This is where 'cat' and redirection happen
    cat "$file" >> "$output_file"
    echo "--- FILE END: $display_path ---" >> "$output_file"
    echo "" >> "$output_file" # Add a blank line for readability
    echo "DEBUG: Finished processing: $display_path" >&2 # Debug message to stderr
  done

  echo "Contents of '$current_dir' (excluding .zcompdump files) saved to '$output_file'."
}
