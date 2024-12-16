if status is-interactive
        # Do Nothing
end

set -x GPG_TTY (tty)

gpg-connect-agent updatestartuptty /bye > /dev/null

if not test -n "$TMUX"
        tmux
end
