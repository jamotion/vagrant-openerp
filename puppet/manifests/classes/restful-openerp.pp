# restful-openerp installation
class restful-openerp {
    package { ["git", "python-virtualenv", "libxslt1-dev", "libxml2-dev"]:
        ensure => installed,
    }
}
