# OpenERP installation
class openerp {
package { ["python-dateutil", "python-feedparser", "python-gdata", "python-ldap", "python-libxslt1", "python-lxml", "python-mako", "python-openid", "python-psycopg2", "python-pybabel", "python-pychart", "python-pydot", "python-pyparsing", "python-reportlab", "python-simplejson", "python-tz", "python-vatnumber", "python-vobject", "python-webdav", "python-werkzeug", "python-xlwt", "python-yaml", "python-zsi",
"python-docutils", "python-jinja2", "python-mock", "python-psutil", "python-unittest2"]:
  ensure => installed,
}
exec { "pip-install-QUnitSuite":
  command => "sudo pip install QUnitSuite",
  require => [ Package["python-dateutil", "python-feedparser", "python-gdata", "python-ldap", "python-libxslt1", "python-lxml", "python-mako", "python-openid", "python-psycopg2", "python-pybabel", "python-pychart", "python-pydot", "python-pyparsing", "python-reportlab", "python-simplejson", "python-tz", "python-vatnumber", "python-vobject", "python-webdav", "python-werkzeug", "python-xlwt", "python-yaml", "python-zsi"] ]
}
exec { "wget-openerp":
  command => "wget http://nightly.openerp.com/$OPENERP_VERSION/nightly/deb/openerp_$OPENERP_VERSION-latest-1_all.deb",
  creates => "/home/vagrant/openerp_$OPENERP_VERSION-latest-1_all.deb",
  require => [ Exec["pip-install-QUnitSuite"] ]
}
exec { "apt-install-openerp":
  command => "dpkg -i openerp_$OPENERP_VERSION-latest-1_all.deb",
  require => Exec["wget-openerp"]
}
user { "openerp":
  ensure     => "present",
  managehome => true,
  shell => "/bin/bash",
  groups => "sudo",
  password => "$6$DWxp1OC6$oDdl8o.Gcwr.WXTtEEgcTkraeKBckJf4Uxuaxk6aMMVGJMnLe/omkZWbOtNW1BFgbpkT70KQ0jm58SyzJQZt60",
  require => Exec["apt-install-openerp"]
}
exec { "copy-openerp-addon-files":
  command => "sudo cp -Ru /usr/share/pyshared/openerp/addons/* /vagrant/addons/",
  timeout => 0,
  require => User["openerp"],
}
exec { "rename-addons-folder":
  command => "sudo mv /usr/share/pyshared/openerp/addons /usr/share/pyshared/openerp/addons_orig",
  require => Exec["copy-openerp-addon-files"]
}
file { "/etc/openerp/openerp-server.conf":
  source => "/vagrant/puppet/files/etc/openerp/openerp-server.conf",
  owner => "root",
  group => "root",
  mode => 0644,
  ensure => file,
  require => Exec["rename-addons-folder"]
}
exec { "stop-openerp":
  command => "service openerp stop",
  require => File["/etc/openerp/openerp-server.conf"]
}
exec { "disable-openerp-service":
  command => "sudo update-rc.d -f openerp disable",
  require => Exec["stop-openerp"]
}
}
