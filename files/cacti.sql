DROP TABLE IF EXISTS `version`;
CREATE TABLE `version` (
  `cacti` char(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

INSERT INTO `version` VALUES ('0.8.8b');

REPLACE INTO `host_snmp_cache` VALUES (1,6,'dskDevice','/dev/sda1','/dev/sda1','',1),(1,6,'dskMount','/','/dev/sda1','',1);

REPLACE INTO `poller_item` VALUES (3,0,1,1,1,'127.0.0.1','public',0,'','','MD5','','DES','',161,500,'mem_buffers','/var/lib/cacti/rra/localhost_mem_buffers_3.rrd',1,300,0,'perl /usr/share/cacti/site/scripts/linux_memory.pl MemFree:','',''),(4,0,1,1,1,'127.0.0.1','public',0,'','','MD5','','DES','',161,500,'mem_swap','/var/lib/cacti/rra/localhost_mem_swap_4.rrd',1,300,0,'perl /usr/share/cacti/site/scripts/linux_memory.pl SwapFree:','',''),(5,0,1,1,1,'127.0.0.1','public',0,'','','MD5','','DES','',161,500,'','/var/lib/cacti/rra/localhost_load_1min_5.rrd',1,300,0,'perl /usr/share/cacti/site/scripts/loadavg_multi.pl','',''),(6,0,1,1,1,'127.0.0.1','public',0,'','','MD5','','DES','',161,500,'users','/var/lib/cacti/rra/localhost_users_6.rrd',1,300,0,'perl /usr/share/cacti/site/scripts/unix_users.pl ','',''),(7,0,1,1,1,'127.0.0.1','public',0,'','','MD5','','DES','',161,500,'proc','/var/lib/cacti/rra/localhost_proc_7.rrd',1,300,0,'perl /usr/share/cacti/site/scripts/unix_processes.pl','','');

REPLACE INTO `settings` VALUES ('path_php_binary','/usr/bin/php'),('path_rrdtool','/usr/bin/rrdtool'),('poller_lastrun','1443593101'),('path_webroot','/usr/share/cacti/site'),('date','2015-09-30 06:05:01'),('stats_poller','Time:0.1049 Method:cmd.php Processes:1 Threads:N/A Hosts:2 HostsPerProcess:2 DataSources:0 RRDsProcessed:0'),('stats_recache','RecacheTime:0.0 HostsRecached:0'),('path_snmpwalk','/usr/bin/snmpwalk'),('path_snmpget','/usr/bin/snmpget'),('path_snmpbulkwalk','/usr/bin/snmpbulkwalk'),('path_snmpgetnext','/usr/bin/snmpgetnext'),('path_cactilog','/var/log/cacti/cacti.log'),('snmp_version','net-snmp'),('rrdtool_version','rrd-1.4.x');

REPLACE INTO `user_auth` VALUES (1,'admin','4f38f4117791e85980213136bb816569',0,'Administrator','','on','on','on','on',1,1,1,1,1,'on'),(3,'guest','43e9a4ab75570f5b',0,'Guest Account','on','on','on','on','on',3,1,1,1,1,'');

REPLACE INTO `user_log` VALUES ('admin',0,'2015-09-30 06:08:35',0,'192.168.50.1'),('admin',1,'2015-09-30 06:08:39',1,'192.168.50.1'),('admin',0,'0000-00-00 00:00:00',3,'192.168.50.1');
