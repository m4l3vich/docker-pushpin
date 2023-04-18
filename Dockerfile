#
# Pushpin Dockerfile
#
# https://github.com/fanout/docker-pushpin
#

# Pull the base image
FROM debian:stable-slim

# Add the "testing" repository
RUN \
  echo 'deb http://deb.debian.org/debian testing main' > /etc/apt/sources.list.d/testing.list && \
  echo 'Package: * \n\
Pin: release a=stable \n\
Pin-Priority: 700 \n\
\n\
Package: * \n\
Pin: release a=testing \n\
Pin-Priority: 650' > /etc/apt/preferences.d/pin

# Install Pushpin
RUN \
  apt-get update && \
  apt-get install -t testing -y pushpin

# Cleanup
RUN \
  apt-get clean && \
  rm -fr /var/lib/apt/lists/* && \
  rm -fr /tmp/*

# Add entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Define default entrypoint and command
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["pushpin", "--merge-output"]

# Expose ports.
# - 7999: HTTP port to forward on to the app
# - 5560: ZMQ PULL for receiving messages
# - 5561: HTTP port for receiving messages and commands
# - 5562: ZMQ SUB for receiving messages
# - 5563: ZMQ REP for receiving commands
EXPOSE 7999
EXPOSE 5560
EXPOSE 5561
EXPOSE 5562
EXPOSE 5563
