FROM debian:stretch-slim

RUN apt-get update && apt-get install -y --no-install-recommends mysql-client percona-toolkit && rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat

## Launch the wait tool and then your application
ENTRYPOINT ["docker-entrypoint.sh"]

ENV TZ=Europe/Rome
ENV LANG C.UTF-8
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ARG UID=1000
ARG GID=1000
RUN groupadd -g ${GID} percona 
RUN useradd -u ${UID} -g ${GID} -m -d /app -s /bin/bash percona
USER percona

CMD ["pt-heartbeat"]
