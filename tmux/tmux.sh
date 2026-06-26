# Tmux session helpers.

WAYVE_SESSION="Wayve"

_tmx_log() {
    printf 'tmx: %s\n' "$*"
}

tmx() {
    if tmux has-session -t "$WAYVE_SESSION" 2>/dev/null; then
        _tmx_log "Attaching to existing session '$WAYVE_SESSION'"
        tmux attach-session -t "$WAYVE_SESSION"
        return
    fi

    _tmx_log "Creating session '$WAYVE_SESSION' with windows 1-5"
    tmux new-session -d -s "$WAYVE_SESSION" -n "1"
    tmux new-window -t "$WAYVE_SESSION:" -n "2"
    tmux new-window -t "$WAYVE_SESSION:" -n "3"
    tmux new-window -t "$WAYVE_SESSION:" -n "4"
    tmux new-window -t "$WAYVE_SESSION:" -n "5"
    tmux select-window -t "$WAYVE_SESSION:1"
    _tmx_log "attaching to session '$WAYVE_SESSION'"
    tmux attach-session -t "$WAYVE_SESSION"
}

tmd() {
    if ! tmux has-session -t "$WAYVE_SESSION" 2>/dev/null; then
        echo "Tmux session '$WAYVE_SESSION' does not exist" >&2
        return 1
    fi

    tmux kill-session -t "$WAYVE_SESSION"
}
