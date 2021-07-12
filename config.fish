if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting
end

if test -f /$HOME/.config/aliases;
	source /$HOME/.config/aliases;
end

set fish_color_cwd cyan
