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

