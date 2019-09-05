#!/usr/bin/env python
import os

os.system('figlet -w 160 -f standard "Destroy Oracle Container"')
os.system('docker-compose -f dockercompose-oracle-11g.yml down')
os.system('docker volume prune --force')