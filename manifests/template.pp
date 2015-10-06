# == Definition: cacti::template
#
#  This class lets you import cacti templates from an xml file.
#  First make sure the file is located on the server in the ${cacti_dir}/scripts/ directory.
#  assigning the filename param is mandatory.
#
# [*cacti_dir*]
#   The base location where cacti is installed, only change this if you specifically installed
#   cacti to another location.
#   Default: '/usr/share/cacti'
#
# [*cli_dir*]
#   The base location for cacti cli files, this is usually a cli folder in the base dir.
#   You should'nt change this unless you moved to another folder,
#   or want to use your own cli directory.
#   Default: ${cacti_dir}/cli
#
# [*filename*]
#  In order to import a template, specify the template filename( this should be located in cacti_basedir/scripts/* )
#  Default: none
#
define cacti::template (
  $cli_dir       = $cacti::cli_dir,
  $cacti_dir     = $cacti::cacti_dir,
  $filename      = $cacti::filename,
) {

  if ! defined(Class['cacti']) {
    fail('You must include the cacti base class before using any cacti defined resources')
  }

  exec { "cacti::template::import_template_${name}":
    command => template('cacti/import_template.erb'),
    require => File["${cacti_dir}/scripts/${filename}"],
  }
}

