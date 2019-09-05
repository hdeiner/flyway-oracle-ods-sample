#!/usr/bin/env python
import os
import subprocess
import time

os.system('figlet -w 160 -f standard "Create Oracle Container"')
os.system('docker-compose -f dockercompose-oracle-11g.yml up -d')

print("waiting for Oracle to start")
ready = False
while not ready:
    process = subprocess.Popen(["curl","-s","localhost:8081"], stdout=subprocess.PIPE)
    while True and not ready:
        line = process.stdout.readline()
        if not line:
            break
        ready = '<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">' in line.decode('utf-8')
    time.sleep(1)

# Oracle 12.2.0.1
#while not ready:
#process = subprocess.Popen(["docker","ps"], stdout=subprocess.PIPE)
#while True and not ready:
#    line = process.stdout.readline()
#    if not line:
#        break
#    ready = "(healthy)" in line.decode('utf-8') and "oracle" in line.decode('utf-8')
#time.sleep(1)