# Install python and compiled modules for project
class python {
    case $operatingsystem {
        ubuntu: {
            package {
                ["python2.7-dev", "python2.7", "python-pip"]:
                    ensure => installed;
            }
        }
    }
}
