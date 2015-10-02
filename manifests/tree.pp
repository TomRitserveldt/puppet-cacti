# Class Definition: cacti::tree
#
define cacti::tree (
  $cli_dir       = $cacti::cli_dir,
  $tree_type     = $cacti::tree_type,
  $sort_method   = $cacti::sort_method,
) {

  if ! defined(Class['cacti']) {
    fail('You must include the cacti base class before using any cacti defined resources')
  }

  exec { "cacti::tree::add_tree_${name}":
    command => "php -q ${cli_dir}add_tree.php --type=${tree_type} --name=${name} --sort-method=${sort_method}",
    unless  => "php -q ${cli_dir}add_tree.php --list-trees | grep ${name}",
  }
}

