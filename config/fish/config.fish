if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting
end

if test -f /$HOME/.config/aliases;
	source /$HOME/.config/aliases;
end

set fish_color_cwd cyan
fish_add_path $HOME/.cargo/bin

if test -f /$HOME/.vim/pack/fzf/start/fzf/shell/key-bindings.fish;
	source /$HOME/.vim/pack/fzf/start/fzf/shell/key-bindings.fish
end

if test -f /$HOME/.config/exports.local.fish;
	source $HOME/.config/exports.local.fish
end
