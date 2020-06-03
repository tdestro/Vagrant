#!/bin/bash

sudo rm -rf /cloudsql
sudo mkdir /cloudsql
sudo /home/vagrant/cloud_sql_proxy -instances=destromachinesstore:us-central1:destromachines-pg12-db -dir=/cloudsql -credential_file ./DestroMachinesStore-2601b370cb00.json &
