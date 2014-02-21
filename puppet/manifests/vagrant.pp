#
# Playdoh puppet magic for dev boxes
#
import "classes/*.pp"

$PROJ_DIR = "/home/vagrant/project"

# You can make these less generic if you like, but these are box-specific
# so it's not required.
$OPENERP_VERSION = "7.0"
$DB_NAME = "openerp"
$DB_USER = "root"

Exec {
    path => "/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/bin",
}

class dev {
    class {
        init: before => Class[postgresql];
        postgresql: before  => Class[python];
        python: before => Class[openerp];
        openerp: ;
        custom: ;
    }
}

include dev
