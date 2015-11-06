# Class Definition: cacti::tree
# [*cli_dir*]
#   The base location for cacti cli files, this is usually a cli folder in the base dir.
#   You should'nt change this unless you moved to another folder,
#   or want to use your own cli directory.
#   Default: ${install_dir}/cli
#
# [*tree_type*]
#  you should not change this, since you will automatically use the node tree type when you add a new device.
#  Default: tree
#
# [*sort_method*]
#  The desired sort method for the new tree, options are: [manual|alpha|natural|numeric]
#  Default: numeric
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
    command => "/usr/bin/php -q ${cli_dir}/add_tree.php --type=${tree_type} --name=${name} --sort-method=${sort_method}",
    unless  => "/usr/bin/php -q ${cli_dir}/add_tree.php --list-trees | grep ${name}",
  }
}

