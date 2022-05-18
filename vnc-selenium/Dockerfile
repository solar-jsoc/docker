FROM solarjsoc/selenium:vnc-base-1.0.0-20220518

USER root

#======================================
# Add Grid check script
#======================================
COPY check-grid.sh start-selenium-node.sh /opt/bin/

#==========
# Selenium & relaxing permissions for OpenShift and other non-sudo environments
#==========
RUN  mkdir -p /opt/selenium /opt/selenium/assets \
  && touch /opt/selenium/config.toml \
  && chmod -R 777 /opt/selenium /opt/selenium/assets \
  && wget --no-verbose https://github.com/SeleniumHQ/selenium/releases/download/selenium-4.1.0/selenium-server-4.1.4.jar \
    -O /opt/selenium/selenium-server.jar \
  && chgrp -R 0 /opt/selenium /opt/selenium/assets \
  && chmod -R g=u /opt/selenium /opt/selenium/assets

#==============================
# Supervisor configuration file
#==============================
COPY selenium.conf /etc/supervisor/conf.d/

# Path to the Configfile
ENV CONFIG_FILE=/opt/selenium/config.toml
ENV GENERATE_CONFIG true
# Drain the Node after N sessions.
# A value higher than zero enables the feature
ENV DRAIN_AFTER_SESSION_COUNT 0

#========================
# Selenium Configuration
#========================
# As integer, maps to "max-concurrent-sessions"
ENV SE_NODE_MAX_SESSIONS 1
# As integer, maps to "session-timeout" in seconds
ENV SE_NODE_SESSION_TIMEOUT 300
# As boolean, maps to "override-max-sessions"
ENV SE_NODE_OVERRIDE_MAX_SESSIONS false

# Following line fixes https://github.com/SeleniumHQ/docker-selenium/issues/87
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null

# Copying configuration script generator
COPY generate_config /opt/bin/generate_config