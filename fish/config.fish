if status is-interactive
	set -U fish_greeting
	pokemon-colorscripts --no-title -s -b -n pikachu| fastfetch -c $HOME/.config/fastfetch/config.jsonc --logo-type file-raw --logo-height 10 --logo-width 5 --logo -
	starship init fish | source
end

