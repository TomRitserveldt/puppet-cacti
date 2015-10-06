# == Definition: cacti::graph
#
# [*cli_dir*]
#   The base location for cacti cli files, this is usually a cli folder in the base dir.
#   You should'nt change this unless you moved to another folder,
#   or want to use your own cli directory.
#   Default: ${cacti_dir}/cli
#
# [*host*]
#   Default:  none
#
# [*graphtype*]
#   the graph type you want to add,possible values are cg or ds.
#   Default:  none
#
# [*graphtemplate*]
#   Name of the graph template required to add the new graph to cacti.
#   Default:  none
#
# [*field*]
#   Default:  none
#
# [*snmpquery*]
#   Default:  none
#
# [*snmptype*]
#   Default:  none
#
# [*snmpvalue*]
#   Default:  none
#
# [*reindexmethod*]
#   Default:  none
#
# [*graphtitle*]
#   the internal cacti graph title, should always default to the title of the resource.
#   Default: $name
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
