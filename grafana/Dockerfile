FROM grafana/grafana:latest
LABEL MAINTAINER = "HRM Dev Team"

USER root

#================================================================================================================================================================================
# Grafana launch
#================================================================================================================================================================================
# Entrypoint has same signature as "command" command
# Set global PATH such that "grafana" command is found
# Add Grafana to the Path
# Set Grafana Home
#================================================================================================================================================================================

COPY --chmod=0755 /grafana/data/ /var/lib/grafana
COPY --chmod=0755 /grafana/conf/ /etc/grafana