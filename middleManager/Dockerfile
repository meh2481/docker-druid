FROM mhutcheson/druid-openshift-base:1.0

# Expose ports:
# - 8081: HTTP (coordinator)
# - 8082: HTTP (broker)
# - 8083: HTTP (historical)
# - 8090: HTTP (overlord)
# - 3306: MySQL
# - 2181 2888 3888: ZooKeeper
# - 8091: middleManager

EXPOSE 8091

# Setup supervisord
COPY supervisord.conf /etc/supervisor/conf.d/middleManager/supervisord.conf

WORKDIR /var/lib/druid

ENTRYPOINT exec /usr/bin/supervisord -c /etc/supervisor/conf.d/middleManager/supervisord.conf

