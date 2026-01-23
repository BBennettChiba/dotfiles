# Add user configurations here
# For HyDE to not touch your beloved configurations,
# we added a config file for you to customize HyDE before loading zshrc

# Edit $ZDOTDIR/.user.zsh to customize HyDE before loading zshrc

if [[ -n $GHOSTTY_RESOURCES_DIR ]]; then
  source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration
fi

#  Plugins 
# oh-my-zsh plugins are loaded  in $ZDOTDIR/.user.zsh file, see the file for more information

unset -f command_not_found_handler # Uncomment to prevent searching for commands not found in package manager


. "/home/bryson/.local/share/cargo/env"
