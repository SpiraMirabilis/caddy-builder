#!/bin/sh
#===============================================================================
#
#          FILE: decomment.sh
# 
#         USAGE: ./decomment.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 12/12/2017 12:13
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
awk -v commentId='//' -v word=$1 '
  $0 ~ "(^|[[:punct:][:space:]])" word "($|[[:punct:][:space:]])" { 
    if (match($0, "^[[:space:]]*" commentId))
      $0 = substr($0, RSTART + RLENGTH)
    else
      $0 = commentId $0
  }
  { print }
  ' $2 > tmpfile.$$ && mv tmpfile.$$ $2
