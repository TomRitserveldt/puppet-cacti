#!/bin/bash
>> /tmp/cactiversion.log 2>&1
set -x
version=$(grep 'config\["cacti_version"\] = ' /usr/share/cacti/site/include/global.php | awk '{print $3}' | grep -o '".*"' | sed 's/"//g')

mysql cacti << EOF
DROP TABLE IF EXISTS version;
CREATE TABLE version (
  cacti char(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
INSERT INTO version VALUES ('$version');
EOF
