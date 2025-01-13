if status is-interactive
  if not test -n "$TMUX"
    tmux new || tmux attach
  end
end

if not contains "/home/$USER/.local/bin" $PATH
  set PATH $PATH /home/malwareslayer/.local/bin
end

set GPG_TTY (tty)

gpg-connect-agent updatestartuptty /bye > /dev/null

