pokemon-colorscripts --no-title -s -r | fastfetch -c $HOME/.config/fastfetch/config.jsonc --logo-type file-raw --logo-height 10 --logo-width 5 --logo -
export ZSH="$HOME/.oh-my-zsh"
plugins=(git sudo zsh-autocomplete)
source $ZSH/oh-my-zsh.sh
source <(fzf --zsh)
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
