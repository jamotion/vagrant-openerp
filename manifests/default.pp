exec { "add apt-source":
  command => "/bin/echo \"deb http://nightly.openerp.com/7.0/nightly/deb/ ./\" > /etc/apt/sources.list.d/openerp.list",
}
exec { "apt update":
  command => "/usr/bin/apt-get update",
  require => Exec["add apt-source"],
}
package { "language-pack-de": 
  ensure => "installed",
  require => Exec["apt update"], 
}
package { "postgresql":
  ensure => "installed",
  require => Package["language-pack-de"],
}
exec { "openerp":
  command => "/usr/bin/apt-get -y --force-yes install openerp",
  require => Package["postgresql"],
}
