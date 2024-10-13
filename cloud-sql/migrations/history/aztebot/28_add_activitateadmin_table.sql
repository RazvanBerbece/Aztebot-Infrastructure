-- +migrate Up
USE aztebotBotDb;


CREATE TABLE IF NOT EXISTS ActivitateAdmin (
    admin_id VARCHAR(255) PRIMARY KEY,
    timeout_count INT DEFAULT 0
);


-- +migrate Down
DROP TABLE IF EXISTS ActivitateAdmin;