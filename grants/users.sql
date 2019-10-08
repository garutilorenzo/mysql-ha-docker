/*  REPLICA */
CREATE USER 'repl'@'172.56.0.%' IDENTIFIED BY 'repl';
GRANT REPLICATION SLAVE ON *.* TO 'repl'@'172.56.0.%';

/* USER */ 
CREATE USER 'super'@'172.56.0.%' IDENTIFIED BY 'superLuser';
GRANT ALL PRIVILEGES ON *.* TO 'super'@'172.56.0.%';

/* PROXYSQL */ 
CREATE USER 'proxysql'@'172.56.0.%' IDENTIFIED BY 'ProxySQL';
GRANT REPLICATION CLIENT ON  *.* TO 'proxysql'@'172.56.0.%';

/* ORCHESTRATOR */ 
CREATE USER 'orc_client_user'@'172.56.0.%' IDENTIFIED BY 'orc_client_password';
GRANT SUPER, PROCESS, REPLICATION SLAVE, REPLICATION CLIENT, RELOAD ON *.* TO 'orc_client_user'@'172.56.0.%';
GRANT SELECT ON mysql.slave_master_info TO 'orc_client_user'@'172.56.0.%';
GRANT SELECT ON meta.* TO 'orc_client_user'@'172.56.0.%';

/* HEARTBEAT */ 
