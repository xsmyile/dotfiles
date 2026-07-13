#!/usr/bin/env bash

set -euo pipefail

PLUGIN_DIR="$HOME/.config/tmux/plugins/tmux-ccradar"
source "$PLUGIN_DIR/scripts/helpers.sh"

STATUS_DIR="$HOME/.cache/tmux-ccradar"

fg=$(tmux show -gqv @thm_fg)
surface=$(tmux show -gqv @thm_surface_0)
green=$(tmux show -gqv @thm_green)
peach=$(tmux show -gqv @thm_peach)
yellow=$(tmux show -gqv @thm_yellow)

hooks_ok=""
raw=$(tmux show-environment -g TMUX_CCRADAR_HOOKS_OK 2>/dev/null) && hooks_ok="${raw#*=}"

working_ttl=""
raw=$(tmux show-environment -g TMUX_CCRADAR_WORKING_TTL 2>/dev/null) && working_ttl="${raw#*=}"
case "$working_ttl" in ''|*[!0-9]*) working_ttl="$CCRADAR_DEFAULT_WORKING_TTL" ;; esac
now=$(date +%s)

total=0
working=0
waiting=0

claude_panes=$(get_claude_panes)

while read -r pane_id; do
    [ -n "$pane_id" ] || continue
    status_file="$STATUS_DIR/${pane_id}.status"
    [ -f "$status_file" ] || continue

    pane_status=$(effective_state "$status_file" "$working_ttl" "$now")
    total=$((total + 1))
    case "$pane_status" in
        working) working=$((working + 1)) ;;
        waiting) waiting=$((waiting + 1)) ;;
    esac
done <<< "$claude_panes"

if [ "$hooks_ok" != "1" ] && [ -n "$claude_panes" ]; then
    echo "#[fg=${peach}]⚠ hooks not configured"
    exit 0
fi

idle=$((total - working - waiting))

TXT="#[fg=${fg},bg=${surface}]"
echo "#[fg=${green}]●${TXT} ${working} #[fg=${peach}]●${TXT} ${waiting} #[fg=${yellow}]●${TXT} ${idle}"
