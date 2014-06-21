#!/bin/bash

# Populate Varnish config. with proper Environment info.
/parse_vcl.sh

# Start varnish and log
varnishd -F -f /etc/varnish/default.vcl -s malloc,${VARNISH_MEM} -a 0.0.0.0:${VARNISH_PORT}
# varnishlog
