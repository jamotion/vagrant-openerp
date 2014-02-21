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
    exec { "chsh-openerp-user":
        command => "sudo chsh --shell /bin/bash openerp",
        require => Exec["apt-install-openerp"]
    }
    exec { "passwd-openerp-user":
        command => "sudo echo openerp:openerp | chpasswd",
        require => Exec["chsh-openerp-user"]
    }
    exec { "mkdir-openerp-user":
        command => "sudo mkdir /home/openerp",
        require => Exec["passwd-openerp-user"]
    }
    exec { "chown-openerp-user":
        command => "sudo chown openerp.openerp /home/openerp",
        require => Exec["mkdir-openerp-user"]
    }
    exec { "sudoer-openerp-user":
        command => "sudo usermod -a -G sudo openerp",
        require => Exec["chown-openerp-user"]
    }
    exec { "move-openerp-addon-files":
        command => "sudo mv /usr/share/pyshared/openerp/addons/* /vagrant/addons/",
        require => Exec["sudoer-openerp-user"]
    }
    file { "/etc/openerp/openerp-server.conf":
        source => "/vagrant/puppet/files/etc/openerp/openerp-server.conf",
        owner => "root", 
        group => "root", 
        mode => 0644,
        ensure => file,
        require => Exec["move-openerp-addon-files"]
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
