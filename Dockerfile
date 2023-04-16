FROM python:3-slim


# Install mopidy
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y sudo gpg wget \
  && sudo mkdir -p /etc/apt/keyrings \
  && sudo wget -q -O /etc/apt/keyrings/mopidy-archive-keyring.gpg https://apt.mopidy.com/mopidy.gpg \
  && sudo wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/bullseye.list \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    mopidy \
    mopidy-spotify \
    mopidy-soundcloud \
    mopidy-mpd \
    mopidy-local \
  && pip install -U \
  # Mopidy WebUI extensions
    Mopidy-Iris \
    Mopidy-Moped \
  # Mopidy music source extensions
    Mopidy-GMusic \
    Mopidy-Pandora \
    Mopidy-RadioNet \
    Mopidy-TuneIn \
    Mopidy-YouTube \
    youtube-dl \
    pyopenssl \
  # Cleanup
  && pip cache purge \
  && apt-get purge --auto-remove -y \
    gcc \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache

# Switch to user mopidy with group audio.
USER mopidy:audio

# Expose Ports
EXPOSE 6600 6680 5555/udp

# Run start script
CMD ["/usr/bin/mopidy"]

HEALTHCHECK --interval=5s --timeout=2s --retries=20 \
    CMD curl --connect-timeout 5 --silent --show-error --fail http://localhost:6680/ || exit 1
