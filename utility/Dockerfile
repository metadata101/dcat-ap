ARG GN_VERSION=4.4.9
FROM geonetwork:4.4.9

USER jetty

# Remove the existing vanilla GeoNetwork
RUN rm -rf /opt/geonetwork/*

# Replace it with GeoNetwork with DCAT-ap plugin
COPY geonetwork.war /opt/geonetwork/geonetwork.war
RUN cd /opt/geonetwork && \
    unzip -q geonetwork.war && \
    rm geonetwork.war \
