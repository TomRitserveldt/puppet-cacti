#!/bin/bash
exec >> /tmp/cacticmd.log 2>&1
set -x
hostid=$(php -q /usr/share/cacti/cli/add_graphs.php --list-hosts | grep "$1" | head -1 | awk '{print $1}')
templateid=$(php -q /usr/share/cacti/cli/add_graphs.php --list-graph-templates | grep "$3" | head -1 | awk '{print $1}')
basecmd="php -q /usr/share/cacti/cli/add_graphs.php --host-id=$hostid --graph-type=$2 --graph-template-id=$templateid"
case "$2" in 
  cg) 
    if [ -n "$5" ];then
      basecmd="$basecmd --graph-title=\"$4\""
      shift 4
      inputfields=$(echo $@ | sed -e 's/\s+$//')
      basecmd="$basecmd --input-fields=\"$inputfields\""
    fi
    eval $basecmd
    ;;
  ds)
    if [ -n "$4" ];then
      basecmd="$basecmd --graph-title=\"$4\""
    fi
    if [ -n "$5" ];then
      snmpfield=$5
      basecmd="$basecmd --snmp-field=$snmpfield"
    fi
    if [ -n "$6" ];then
      snmpqueryid=$(php -q /usr/share/cacti/cli/add_graphs.php --list-snmp-queries | grep "$6" | head -1 | awk '{print $1}')
      basecmd="$basecmd --snmp-query-id=$snmpqueryid"
    fi
    if [ -n "$7" ];then
      snmpquerytypeid=$(php -q /usr/share/cacti/cli/add_graphs.php --list-query-types --snmp-query-id=$snmpqueryid | grep "$7" | head -1 | awk '{print $1}')
      basecmd="$basecmd --snmp-query-type-id=$snmpquerytypeid"
    fi
    if [ -n "$8" ];then
      snmpvalues=$8
    else
      snmpvalues=$(php -q /usr/share/cacti/cli/add_graphs.php --list-snmp-values  --snmp-field=$snmpfield --snmp-query-id=$snmpqueryid --host-id=$hostid | sed 1,3d | egrep -v '^dm|^loop|^fd|^sr|^lo')
    fi
    if [ -n "$9" ];then
      basecmd="$basecmd --reindex-method=$9"
    fi
    export IFS=$'\n'
    for snmpvalue in $snmpvalues; do
      eval $basecmd --snmp-value=\'$snmpvalue\'
    done
    ;;
esac
