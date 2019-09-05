#!/usr/bin/env python
import os

os.system('figlet -w 160 -f standard "Ready Database for Flyway"')

os.system('sqlplus system/oracle@localhost:1521/EE.oracle.docker @src/main/db/ddl_users.sql > ./ddl_users.out')
os.system('rm -rf ddl_users.out')

