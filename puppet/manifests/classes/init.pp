# stage {"pre": before => Stage["main"]} class {'apt': stage => 'pre'}

# Commands to run before all others in puppet.
class init {
    group { "puppet":
        ensure => "present",
    }

    case $operatingsystem {
        ubuntu: {
			exec { "dpkg_config":
                command => "sudo dpkg --configure -a",
            }
            exec { "update_apt":
                command => "sudo apt-get update",
				require => Exec["dpkg_config"]
            }
            # Provides "add-apt-repository" command, useful if you need
            # to install software from other apt repositories.
            package { "python-software-properties":
                ensure => present,
                require => [
                    Exec['update_apt'],
                ];
            }
        }
    }
}
