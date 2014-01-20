rm -rf /tmp/restful-openerp && git clone git://github.com/tgpfeiffer/restful-openerp.git /tmp/restful-openerp
cd /tmp/restful-openerp
virtualenv --no-site-packages .env
. .env/bin/activate
pip install -r /tmp/restful-openerp/requirements.txt
cp /tmp/restful-openerp/restful-openerp.cfg.default /tmp/restful-openerp/restful-openerp.cfg
nohup python /tmp/restful-openerp/restfulOpenErpProxy.py &
