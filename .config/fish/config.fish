if status is-interactive
	set -U fish_greeting
  fastfetch
	starship init fish | source
end
