# Get postgresql up and running
class postgresql {
    package { "postgresql":
        ensure => installed;
    }

    case $operatingsystem {
        ubuntu: {
            package { "libpq-dev":
                ensure => installed;
            }
        }
    }

    # file { "/etc/postgresql/9.1/main/pg_hba.conf":
    #     ensure => file,
    #     source => "$PROJ_DIR/puppet/files/etc/postgresql/pg_hba.conf",
    #     replace => true,
    #     owner  => "postgres",
    #     group  => "postgres",
    #     mode => 640,
    #     require => Package["postgresql"];
    # }

    service { "postgresql":
        ensure => running,
        enable => true,
        require => Package['postgresql'];
    }
}
