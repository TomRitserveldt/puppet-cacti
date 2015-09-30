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
  $reindexmethod = $cacti::reindexmethod,
) {

  if ! defined(Class['cacti']) {
    fail('You must include the cacti base class before using any cacti defined resources')
  }

  exec { "cacti::graph::add_graph_${host}_${graphtemplate}_${field}":
    command => template('cacti/add_graph.erb'),
    require => File['/usr/share/cacti/scripts/cactigraph.sh'],
    unless  => template('cacti/check_graph.erb'),
  }
}
