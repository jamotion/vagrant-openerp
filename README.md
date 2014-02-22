Vagrant Configuration for OpenERP 7 Development
===============================================

This Vagrant configuration provides OpenERP development box optimized for using and debugging by PyCharm IDE.

Installation
------------

- Clone this repository
- cd vagrant-openerp
- vagrant up

After some minutes the box is ready and OpenERP is installed and configured.

Connecting PyCharm with Vagrant Box
-----------------------------------
Prepare PyCharm for runnig or debugging OpenERP by making these steps:
- Open "File -> Settings -> Project Interpreter -> Python Interpreters"
- Click on the green cross (or ALT+INS) and select "remote" for adding the interpreter located in the vagrant box
- Push the button "fill from vagrant config" for automatically set the interpreter settings of vagrant box
- Change the user name to "openerp"
- Change the auth type to "password"
- Set "openerp" as password
- Click on "Test connection..."
- Change the PyCharm helpers path to "/home/openerp/.pycharm_helpers"
- Close all PopUps with [OK] and install all missing packages shown from PyCharm

Adding Run/Debug Configuration
------------------------------
- Add a new Run Configuration by opening the Menu "Run -> Edit Configurations"
- Add a new Python configuration by clicking the green cross (or ALT+INS) and selecting the "Python" entry.
- Give the configuration a name (e.g. OpenERP)
- Set Script: to "\usr\bin\openerp-server"
- Set Script parameter: to "--config=/etc/openerp/openerp-server.conf"
- Close the PopUp

What's next?
------------
Now your are ready for developing your own OpenERP Apps with PyCharm on the vagrant box.
All locally available OpenERP modules are located in the ./addons folder. This is also the place for your own addons.
You will reach the OpenERP under http://localhost:8069/ but you have to run it first :-P

Enjoy it!!!


