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
      require => [ Exec["pip-install-QUnitSuite"] ]
    }   
    exec { "apt-install-openerp":
        command => "dpkg -i openerp_$OPENERP_VERSION-latest-1_all.deb",
        require => Exec["wget-openerp"]
    }
    file { "/etc/openerp/openerp-server.conf":
        source => "/vagrant/puppet/files/etc/openerp/openerp-server.conf",
        owner => "root", 
        group => "root", 
        mode => 0644,
        ensure => file,
        require => Exec["apt-install-openerp"]
    }
    exec { "restart-openerp":
        command => "service openerp restart",
        require => File["/etc/openerp/openerp-server.conf"]
    }
}
