#!/bin/bash

tmux new-session -d
# Creates a 2nd window named dev, in addition to the new session's first window
tmux neww -n dev
tmux neww -n log 
tmux selectw -t 1
tmux -2 attach-session -d
