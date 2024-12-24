if status is-interactive
    # Do Nothing
end

if not contains "/home/$USER/.local/bin" $PATH
	set PATH $PATH /home/malwareslayer/.local/bin
end

set GPG_TTY (tty)

gpg-connect-agent updatestartuptty /bye > /dev/null

if not test -n "$TMUX"
    tmux
end
