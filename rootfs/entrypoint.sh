#!/bin/bash

# [[ ! -f "/user/.profile" ]] && { cp -r /etc/skel/. /user; }

exec su - user -s /bin/bash