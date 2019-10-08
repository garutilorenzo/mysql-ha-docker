FROM debian:stretch-slim

RUN apt-get update && apt-get install -y --no-install-recommends netcat percona-toolkit && rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat

## Launch the wait tool and then your application
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["pt-heartbeat"]
