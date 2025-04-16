FROM ubuntu:24.04

# DRM website: https://www.dell.com/support/home/en-us/drivers/driversdetails?driverId=JKGDG

# Install needed tools, clean up, download and install DRM, clean up
RUN apt-get update && \
    apt-get install -y wget socat file && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    wget -U drm -O drm.bin https://downloads.dell.com/FOLDER12894273M/1/DRMInstaller_3.4.8.1086.bin && \
    sh drm.bin -i silent && \
    rm -rf /tmp/*

# Run socat and DRM as unprivileged user
USER drmuser

# Create a volume to hold the downloaded objects
VOLUME ["/var/dell/drm/"]

# Expose port forwarded from socat
EXPOSE 8091

# Install start script
COPY start.sh /opt/dell/dellrepositorymanager/

# Start script to run DRM and socat
CMD ["/opt/dell/dellrepositorymanager/start.sh"]
