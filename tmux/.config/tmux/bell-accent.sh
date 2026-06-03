#!/usr/bin/env bash
# Accent the "needs input" window (tmux bell flag — Claude Code emits a BEL when
# it wants input) with catppuccin peach instead of the loud default full-pill
# yellow. Only the index cap turns peach, mirroring the current-window pill;
# the body stays surface. Must run AFTER fix-transparent-pills.sh, which rewrites
# window-status-format and whose sed patterns expect the cap color unwrapped.

num=$(tmux show -gqv @catppuccin_window_number_color)
peach="#{@thm_peach}"

repl="#{?window_bell_flag,${peach},${num}}"
fmt=$(tmux show -gqv window-status-format)
fmt=${fmt//"$num"/"$repl"}
tmux set -g window-status-format "$fmt"

tmux set -g window-status-bell-style default
