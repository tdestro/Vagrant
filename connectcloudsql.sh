#!/bin/bash

sudo rm -rf /cloudsql
sudo mkdir /cloudsql
sudo ~/cloud-sql-proxy destromachinesstore:us-central1:destromachines-pg12-db -u=/cloudsql  -c ~/DestroMachinesStore-2601b370cb00.json &
