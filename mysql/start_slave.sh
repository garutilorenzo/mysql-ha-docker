#!/bin/bash
mysql -uroot -p$MYSQL_ROOT_PASSWORD -AN -e "START SLAVE;"
