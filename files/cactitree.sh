#!/bin/bash
exec >> /tmp/cactitree.log 2>&1
set -x
treeid=$(php -q /usr/share/cacti/cli/add_tree.php --list-trees | grep "$3" | awk '{print $1}')
hostid=$(php -q /usr/share/cacti/cli/add_tree.php --list-hosts | grep "$5" | awk '{print $1}')
basecmd="php -q /usr/share/cacti/cli/add_tree.php --type=$1 --node-type=$2 --tree-id=$treeid --host-id=$hostid"

    if [ -n "$4" ];then
      basecmd="$basecmd --parent-node=\"$4\""
    fi
    if [ -n "$6" ];then
      basecmd="$basecmd --host-group-style=\"$6\""
    fi
    eval $basecmd
