#!/usr/bin/env python
import os

os.system('figlet -w 160 -f standard "Create Database"')

os.system('figlet -w 160 -f slant "CSID"')
#os.system('./flyway-4.2.0/flyway -configFile=./flyway-4.2.0/conf/flyway.csid.conf clean')
os.system('./flyway-4.2.0/flyway -configFile=./flyway-4.2.0/conf/flyway.csid.conf info')
os.system('./flyway-4.2.0/flyway -configFile=./flyway-4.2.0/conf/flyway.csid.conf migrate')
os.system('./flyway-4.2.0/flyway -configFile=./flyway-4.2.0/conf/flyway.csid.conf info')

os.system('figlet -w 160 -f slant "ODS"')
#os.system('./flyway-4.2.0/flyway -configFile=./flyway-4.2.0/conf/flyway.ods.conf clean')
os.system('./flyway-4.2.0/flyway -configFile=./flyway-4.2.0/conf/flyway.ods.conf info')
os.system('./flyway-4.2.0/flyway -configFile=./flyway-4.2.0/conf/flyway.ods.conf migrate -target=2_2')
os.system('./flyway-4.2.0/flyway -configFile=./flyway-4.2.0/conf/flyway.ods.conf info')

os.system('figlet -w 160 -f slant "INCV"')
#os.system('./flyway-4.2.0/flyway -configFile=./flyway-4.2.0/conf/flyway.incv.conf clean')
os.system('./flyway-4.2.0/flyway -configFile=./flyway-4.2.0/conf/flyway.incv.conf info')
os.system('./flyway-4.2.0/flyway -configFile=./flyway-4.2.0/conf/flyway.incv.conf migrate')
os.system('./flyway-4.2.0/flyway -configFile=./flyway-4.2.0/conf/flyway.incv.conf info')

os.system('sqlplus CSID/CSID@localhost:1521/EE.oracle.docker @src/main/db/ddl_csid_grants_to_incv.sql > ./ddl_csid_grants_to_incv.out')
os.system('sqlplus ODS/ODS@localhost:1521/EE.oracle.docker @src/main/db/ddl_ods_grants_to_incv.sql > ./ddl_ods_grants_to_incv.out')
os.system('rm -rf ddl_csid_grants_to_incv.out ddl_ods_grants_to_incv.out')
