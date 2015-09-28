# == Definition: cacti::graph
#
define cacti::graph (
  $cli_dir       = $cacti::cli_dir,
  $host          = $cacti::host,
  $graphtype     = $cacti::graphtype,
  $graphtemplate = $cacti::graphtemplate,
  $graphtitle    = $name,
  $field         = $cacti::field,
  $snmpquery     = $cacti::snmpquery,
  $snmptype      = $cacti::snmptype,
  $snmpvalue     = $cacti::snmpvalue,
  $reindexmethod = $cacti::reindexmethod
) {

  if ! defined(Class['cacti']) {
    fail('You must include the cacti base class before using any cacti defined resources')
  }

  exec { "add_graph_${host}_${graphtemplate}_${field}":
    command => "/usr/share/cacti/scripts/cactigraph.sh '${host}' ${graphtype} '${graphtemplate}' '${graphtitle}' '${field}' '${snmpquery}' '${snmpqtype}' '${snmpvalue}' '${reindexmethod}'",
    require => File['/data/scripts/cactigraph.sh'],
    unless  => "/usr/bin/php -q ${cli_dir}/add_tree.php --list-hosts | grep '${host}' | awk '{print \$1}' | xargs -I++ php -q ${cli_dir}/add_tree.php --list-graphs --host-id=++ | grep '${graphtitle}'",
  }
 

}
