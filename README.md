# MySQL HA with ProxySQL Percona Heartbeat and Orchestrator

Basic MySQL HA environment, for advanced and custom configurations see:

* [ProxySQL](https://github.com/sysown/proxysql/wiki) - High performance, high availability, protocol aware proxy for MySQL
* [Heartbeat](https://www.percona.com/doc/percona-toolkit/LATEST/pt-heartbeat.html) - Monitor MySQL replication delay
* [Orchestrator](https://github.com/github/orchestrator/tree/master/docs) - MySQL high availability and replication management tool

## Notes about environment

* MySQL replication is setup with [GTID](https://dev.mysql.com/doc/refman/5.7/en/replication-gtids.html)
* MySQL slave doesn't start automatically

## Setting up environment

First we need to clone Orchestrator repository:

```
cd <PROJECT_DIR>
git clone https://github.com/github/orchestrator
```

Start environment with

```
docker-compose build
docker-compose up -d
```

and wait until MySQL servers are ready

Initialize slave with:

```
docker-compose exec mysqlslave init_slave
```

### Show cluster status

**ProxySQL**

Via console:

```
docker-compose exec proxyqsl bash
root@proxysql:/#  mysql -u admin -pproxysql -h 127.0.0.1 -P6032
select * from stats_mysql_connection_pool;
```

**Orchestrator**

Via web Browser:

http://localhost:3000

**Heartbeat**

Via console:

```
docker-compose exec proxyqsl bash
root@proxysql:/# mysql -u super -Ap -h 127.0.0.1 -P3306
Enter password:
select * from percona.heartbeat;
```

### Add replica to MySQL cluster

Edit docker-compose.yaml and add a new mysql replica, for example:

```
...
mysqlslavebis:
  hostname: mysqlslavebis
  image: mysql-percona-toolkit:5.7.26
  build:
   context: mysql/
   args:
     - http_proxy=$http_proxy
     - https_proxy=$http_proxy
  environment:
     MYSQL_ROOT_PASSWORD: password
     MYSQL_MASTER_HOST: mysqlmaster
     MYSQL_REPLICATION_USER: repl
     MYSQL_REPLICATION_PASSWORD: repl
  volumes:
    - ./data/mysql-slave-bis:/var/lib/mysql/
    - ./config/mysql-slave-bis:/etc/mysql/conf.d/ # <- Remember to create the config and change server-id and report-host variables
  networks:
     cluster:
        ipv4_address: 172.56.0.X
...
```

Initialize the new replica with:

```
docker-compose up -d
docker-compose exec mysqlslavebis init_slave
```

Then:
* Adjust ProxySQL settings in config/proxysql/proxysql.cnf and restart the container
* add the new host in Orchestrator via web interface

### Clean all data

```
docker-compose down
rm -rf data/*
```
