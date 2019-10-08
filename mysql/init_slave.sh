#!/bin/bash

mysqldump --all-databases -flush-privileges --single-transaction --flush-logs --triggers --routines --events -hex-blob --host=$MYSQL_MASTER_HOST --port=3306 --user=root  --password=$MYSQL_ROOT_PASSWORD > /dump/mysqlbackup_dump.sql
mysql -uroot -p$MYSQL_ROOT_PASSWORD < /dump/mysqlbackup_dump.sql

mysql -uroot -p$MYSQL_ROOT_PASSWORD -AN -e "RESET MASTER;"
mysql -uroot -p$MYSQL_ROOT_PASSWORD -AN -e "RESET SLAVE;"

mysql -uroot -p$MYSQL_ROOT_PASSWORD -AN -e "CHANGE MASTER TO MASTER_HOST='$MYSQL_MASTER_HOST', MASTER_USER='$MYSQL_REPLICATION_USER', MASTER_PASSWORD='$MYSQL_REPLICATION_PASSWORD', MASTER_AUTO_POSITION = 1;"
mysql -uroot -p$MYSQL_ROOT_PASSWORD -AN -e "START SLAVE;"
mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "SHOW SLAVE STATUS\G;"
