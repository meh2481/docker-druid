FROM mhutcheson/druid-openshift-base

# Expose ports:
# - 8081: HTTP (coordinator)
# - 8082: HTTP (broker)
# - 8083: HTTP (historical)
# - 8090: HTTP (overlord)
# - 3306: MySQL
# - 2181 2888 3888: ZooKeeper

EXPOSE 8090

# Setup supervisord
COPY supervisord.conf /etc/supervisor/conf.d/overlord/supervisord.conf
COPY core-site.xml /etc/hadoop/core-site.xml

WORKDIR /var/lib/druid

ENTRYPOINT exec /usr/bin/supervisord -c /etc/supervisor/conf.d/overlord/supervisord.conf

