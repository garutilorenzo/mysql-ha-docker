[![GitHub issues](https://img.shields.io/github/issues/garutilorenzo/mysql-ha-docker)](https://github.com/garutilorenzo/mysql-ha-docker/issues)
![GitHub](https://img.shields.io/github/license/garutilorenzo/mysql-ha-docker)
[![GitHub forks](https://img.shields.io/github/forks/garutilorenzo/mysql-ha-docker)](https://github.com/garutilorenzo/mysql-ha-docker/network)
[![GitHub stars](https://img.shields.io/github/stars/garutilorenzo/mysql-ha-docker)](https://github.com/garutilorenzo/mysql-ha-docker/stargazers)

# MySQL HA with ProxySQL Percona Heartbeat and Orchestrator

Basic MySQL HA environment, for advanced and custom configurations see:

* [ProxySQL](https://github.com/sysown/proxysql/wiki) - High performance, high availability, protocol aware proxy for MySQL
* [Heartbeat](https://www.percona.com/doc/percona-toolkit/LATEST/pt-heartbeat.html) - Monitor MySQL replication delay
* [Orchestrator](https://github.com/github/orchestrator/tree/master/docs) - MySQL high availability and replication management tool

## Notes about environment

* MySQL replication is setup with [GTID](https://dev.mysql.com/doc/refman/5.7/en/replication-gtids.html)

## Setting up environment

Start environment with

```
docker-compose build
docker-compose up -d
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
### Clean all data

```
docker-compose down -v
```
