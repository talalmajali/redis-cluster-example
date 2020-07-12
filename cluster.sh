#!/bin/bash

set -e # Exit on errors

if [ -n "$TMUX" ]; then
  export NESTED_TMUX=1
  export TMUX=''
fi

if [ ! $RC_DIR ];  then export RC_DIR=$HOME/src/redis-cluster;   fi
export TERM=screen-256color-bce

tmux new-session  -d -s redis-cluster

tmux send-key     -t redis-cluster 'cd $RC_DIR/7001'   Enter        'redis-server redis.conf'  Enter
tmux split-window -t redis-cluster
tmux send-key     -t redis-cluster 'cd $RC_DIR/7002'   Enter        'redis-server redis.conf'  Enter

tmux new-window   -t redis-cluster -n ''
tmux send-key     -t redis-cluster 'cd $RC_DIR/7003'                    Enter 'redis-server redis.conf'                  Enter
tmux split-window -t redis-cluster
tmux send-key     -t redis-cluster 'cd $RC_DIR/7004'                    Enter 'redis-server redis.conf'                  Enter

tmux new-window   -t redis-cluster -n ''
tmux send-key     -t redis-cluster 'cd $RC_DIR/7005'                    Enter 'redis-server redis.conf'                  Enter
tmux split-window -t redis-cluster
tmux send-key     -t redis-cluster 'cd $RC_DIR/7006'                    Enter 'redis-server redis.conf'                  Enter
#

if [ -z "$NESTED_TMUX" ]; then
  tmux attach-session -t redis-cluster
else
  tmux switch-client -t redis-cluster
fi
