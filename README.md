# cacti

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with cacti](#setup)
    * [What cacti affects](#what-cacti-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with cacti](#beginning-with-cacti)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

A one-maybe-two sentence summary of what the module does/what problem it solves.
This is your 30 second elevator pitch for your module. Consider including
OS/Puppet version it works with.

## Module Description

If applicable, this section should have a brief description of the technology
the module integrates with and what that integration enables. This section
should answer the questions: "What does this module *do*?" and "Why would I use
it?"

If your module has a range of functionality (installation, configuration,
management, etc.) this is the time to mention it.

## Setup

### What cacti affects

* A list of files, packages, services, or operations that the module will alter,
  impact, or execute on the system it's installed on.
* This is a great place to stick any warnings.
* Can be in list or paragraph form.

### Setup Requirements **OPTIONAL**

If your module requires anything extra before setting up (pluginsync enabled,
etc.), mention it here.

### Beginning with cacti

The very basic steps needed for a user to get the module up and running.

If your most recent release breaks compatibility or requires particular steps
for upgrading, you may wish to include an additional section here: Upgrading
(For an example, see http://forge.puppetlabs.com/puppetlabs/firewall).

## Usage

Adding new hosts to cacti:

Use the class cacti::host resource, example:

@@cacti::host {'hosting1':
  ip       => '10.1.0.14',
  template => 'Local Linux Machine',
}
This will add a new device and some default graphs (as seen in the host.pp manifest)

Valid Host Templates: (id, name)
0	None
1	Generic SNMP-enabled Host
3	ucd/net SNMP Host
4	Karlnet Wireless Bridge
5	Cisco Router
6	Netware 4/5 Server
7	Windows 2000/XP Host
8	Local Linux Machine


## Reference

Here, list the classes, types, providers, facts, etc contained in your module.
This section should include all of the under-the-hood workings of your module so
people know what the module is touching on their system but don't need to mess
with things. (We are working on automating this section!)

## Limitations

This is where you list OS compatibility, version compatibility, etc.

## Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

### Basic operations

```
gem install bundler -v 1.10.5
```
Selecting this (max) bundler version is important to work together with
Vagrant 1.7.4 (...on Mac OSX)

```
PUPPET_VERSION=3.8.4 bundle install [--path vendor/bundle]
```

```
bundle exec rake validate
```

```
bundle exec rake spec
```

```
BEAKER_destroy=no bundle exec rake beaker
```
```
BEAKER_destroy=no BEAKER_provision=no bundle exec rake beaker
```

###beaker-rspec Details

####Supported ENV variables

`BEAKER_debug` - turn on extended debug logging

`BEAKER_set` - set to the name of the node file to be used during testing (exclude .yml file extension, it will be added by beaker-rspec), assumed to be in module's spec/acceptance/nodesets directory

`BEAKER_setfile` - set to the full path to a node file be used during testing (be sure to include full path and file extensions, beaker-rspec will use this path without editing/altering it in any way)

`BEAKER_destroy` - set to `no` to preserve test boxes after testing, set to `onpass` to destroy only if tests pass

`BEAKER_provision` - set to `no` to skip provisioning boxes before testing, will then assume that boxes are already provisioned and reachable

###Typical Workflow

1. Run tests with `BEAKER_destroy=no`, no setting for `BEAKER_provision`
  * beaker-rspec will use spec/acceptance/nodesets/default.yml node file
  * boxes will be newly provisioned
  * boxes will be preserved post-testing
* Run tests with `BEAKER_destroy=no` and `BEAKER_provision=no`
  * beaker-rspec will use spec/acceptance/nodesets/default.yml node file
  * boxes will be re-used from previous run
  * boxes will be preserved post-testing
* Nodes become corrupted with too many test runs/bad data and need to be refreshed then GOTO step 1
* Testing is complete and you want to clean up, run once more with `BEAKER_destroy` unset
  * you can also:

        cd .vagrant/beaker_vagrant_files/default.yml ; vagrant destroy --force

## Release Notes/Contributors/Etc **Optional**

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You may also add any additional sections you feel are
necessary or important to include here. Please use the `## ` header.
