# Tmux session helpers.

WAYVE_SESSION="Wayve"

_TMX_GREEN='\033[1;38;2;184;187;38m'
_TMX_RED='\033[1;38;2;251;73;52m'
_TMX_RESET='\033[0m'

_tmx_ok() {
    printf '%btmx: %s%b\n' "$_TMX_GREEN" "$*" "$_TMX_RESET"
}

_tmx_fail() {
    printf '%btmx: %s%b\n' "$_TMX_RED" "$*" "$_TMX_RESET" >&2
}

tmx() {
    if tmux has-session -t "$WAYVE_SESSION" 2>/dev/null; then
        _tmx_ok "Attaching to existing session '$WAYVE_SESSION'"
        tmux attach-session -t "$WAYVE_SESSION"
        return
    fi

    _tmx_ok "Creating session '$WAYVE_SESSION' with windows 1-5"
    tmux new-session -d -s "$WAYVE_SESSION" -n "1"
    tmux new-window -t "$WAYVE_SESSION:" -n "2"
    tmux new-window -t "$WAYVE_SESSION:" -n "3"
    tmux new-window -t "$WAYVE_SESSION:" -n "4"
    tmux new-window -t "$WAYVE_SESSION:" -n "5"
    tmux select-window -t "$WAYVE_SESSION:1"
    _tmx_ok "Attaching to session '$WAYVE_SESSION'"
    tmux attach-session -t "$WAYVE_SESSION"
}

tmd() {
    if ! tmux has-session -t "$WAYVE_SESSION" 2>/dev/null; then
        _tmx_fail "Session '$WAYVE_SESSION' does not exist"
        return 1
    fi

    tmux kill-session -t "$WAYVE_SESSION"
}
