#!/bin/bash

# some functions and aliases :
#
#  cheat: alias for 'man -7'
#    tip: function
#       show a tip for a subject
#
#       Usage : tip {some_subject}
#       tip font

export TIPS=$HOME/.local/share/tips.csv
tip() {
   echo "subject    command                          description"
   echo "-------    -------                          -----------"
   grep -i "$1" "$TIPS" | column -s ';' -t | grep -i "$1" 
}
alias cheat='man 7'

# update the tip "database"
test -f tips.csv && cp -i tips.csv "$TIPS"
