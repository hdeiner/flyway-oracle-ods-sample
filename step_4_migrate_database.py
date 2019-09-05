#!/usr/bin/env python
import os

os.system('figlet -w 160 -f standard "Migrate Database"')

os.system('figlet -w 160 -f slant "ODS"')
os.system('./flyway-4.2.0/flyway -configFile=./flyway-4.2.0/conf/flyway.ods.conf info')
os.system('./flyway-4.2.0/flyway -configFile=./flyway-4.2.0/conf/flyway.ods.conf migrate -target=3_2')
os.system('./flyway-4.2.0/flyway -configFile=./flyway-4.2.0/conf/flyway.ods.conf info')
