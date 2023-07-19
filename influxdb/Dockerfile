FROM influxdb:2.0
LABEL MAINTAINER = "HRM Dev Team"

USER root

#================================================================================================================================================================================
# influxdb launch
#================================================================================================================================================================================
# Entrypoint has same signature as "command" command
# Set global PATH such that "influxdb" command is found
# Add influxdb to the Path
# Set influxdb Home
#================================================================================================================================================================================

COPY --chmod=0755 /influxdb/data/ /var/lib/influxdb2
COPY --chmod=0755 /influxdb/data/ /root/.influxdbv2