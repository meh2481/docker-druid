#!/bin/bash

sed -i.bak s/localhost/$1/g /var/lib/druid/server.json
/usr/local/druid/bin/tranquility server -configFile /var/lib/druid/server.json
