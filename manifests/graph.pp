# == Definition: cacti::graph
#
define cacti::graph (
  $cli_dir = $cacti::params::cli_dir,
  $host = $cacti::params::host,
  $graphtype = $cacti::params::graphtype,
  $graphtemplate = $cacti::params::graphtemplate,
  $graphtitle=$name
) inherits cacti::params {

  exec { "add_graph_${host}_${graphtemplate}_${field}":
    command => "/usr/share/cacti/scripts/cactigraph.sh '${host}' ${graphtype} '${graphtemplate}' '${graphtitle}' '${field}' '${snmpquery}' '${snmpqtype}' '${snmpvalue}' '${reindexmethod}'",
    require => File['/data/scripts/cactigraph.sh'],
    unless  => "php -q ${cli_dir}add_tree.php --list-hosts | grep '${host}' | awk '{print \$1}' | xargs -I++ php -q ${cli_dir}add_tree.php --list-graphs --host-id=++ | grep '${graphtitle}'",
  }
 

}
