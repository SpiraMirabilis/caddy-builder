#!/bin/sh
#===============================================================================
#
#          FILE: get_plugins.sh
# 
#         USAGE: ./get_plugins.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 12/12/2017 11:30
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
echo "$@" | sed -n 1'p' | tr ',' '\n' | while read word; do
    /app/decomment.sh $word /tmp/plugins.go
done

