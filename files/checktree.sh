#!/bin/bash
exec >> /tmp/checktree.log 2>&1
set -x
treeid=$(php -q /usr/share/cacti/cli/add_tree.php --list-trees | grep "$1" | awk '{print $1}')
hostname=$(php -q /usr/share/cacti/cli/add_tree.php --list-hosts | grep "$2" | awk '{print $2}')

if [ -z "$hostname" ];then
  exit 1
else
  php -q /usr/share/cacti/cli/add_tree.php --list-nodes --tree-id=$treeid | grep "$hostname"
fi
