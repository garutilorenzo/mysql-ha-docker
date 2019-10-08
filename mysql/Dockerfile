FROM mysql:5.7.26 as base
RUN apt-get update \
    && apt-get install -y --no-install-recommends percona-toolkit \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
    

COPY ./init_slave.sh /usr/local/bin/init_slave
COPY ./show_slave_status.sh /usr/local/bin/show_slave_status
COPY ./start_slave.sh /usr/local/bin/start_slave
