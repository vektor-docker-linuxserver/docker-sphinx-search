#!/bin/bash
mkdir -p /config/etc /config/log /config/cron /var/run/sphinx /var/lib/sphinxsearch/data

if [ ! -f "/config/etc/sphinx.conf" ]; then
    cp /defaults/pgsql.sphinx.conf /config/etc/sphinx.conf
fi

if [ ! -f "/config/cron/cron-sphinx" ]; then
    cp /defaults/cron-sphinx /config/cron/cron-sphinx
fi
cp -f /config/cron/cron-sphinx /etc/cron.d/cron-sphinx
chmod 600 /etc/cron.d/cron-sphinx
chown root:root

chown -R abc:abc /config
chown -R abc:abc /var/run/sphinx
chown -R abc:abc /var/lib/sphinxsearch/data

[ -f /var/run/sphinx/searchd.pid ] && rm /var/run/sphinx/searchd.pid

if [ ! -d "/config/data" ]; then
    mkdir -p /config/data
    chown -R abc:abc /config/data
    setuser abc /usr/bin/indexer --all --config /config/etc/sphinx.conf
fi

exit 0
