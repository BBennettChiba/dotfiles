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



alias start_ac='$HOME/scripts/start_ac.sh'

alias cat=bat

alias please='sudo $(fc -ln -1)'

alias dust="du -sh * | sort -hr"

alias taskt=taskwarrior-tui

alias viu=viu-media

alias peaclock="peaclock --config-dir ~/.config/peaclock"

alias rm='echo "This is not the command you are looking for. (trash-put)"; false'

alias delete_force='/usr/bin/rm -rf'

alias reload="source $HOME/.config/zsh/.zshrc"

alias music=rmpc

alias cliexercises='$HOME/Learning/cli_learning/bin/cliexercises'
alias grepexercises='$HOME/Learning/cli_learning/bin/grepexercises'
alias awkexercises='$HOME/Learning/cli_learning/bin/awkexercises'
alias sedexercises='$HOME/Learning/cli_learning/bin/sedexercises'

alias sysdmt=systemd-manager-tui

alias lzd=lazydocker
alias lzg=lazygit
alias mail=aerc
