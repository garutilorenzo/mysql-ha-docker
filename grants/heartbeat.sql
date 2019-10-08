CREATE DATABASE IF NOT EXISTS percona;
CREATE TABLE IF NOT EXISTS percona.heartbeat (
  ts                    varchar(26) NOT NULL,
  server_id             int unsigned NOT NULL PRIMARY KEY,
  file                  varchar(255) DEFAULT NULL,    -- SHOW MASTER STATUS
  position              bigint unsigned DEFAULT NULL, -- SHOW MASTER STATUS
  relay_master_log_file varchar(255) DEFAULT NULL,    -- SHOW SLAVE STATUS
  exec_master_log_pos   bigint unsigned DEFAULT NULL  -- SHOW SLAVE STATUS
);
