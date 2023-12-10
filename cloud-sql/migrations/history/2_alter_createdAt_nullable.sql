-- +migrate Up
USE aztebotBotDb;

ALTER TABLE Users
MODIFY COLUMN createdAt INT NULL;

-- +migrate Down
USE aztebotBotDb;

ALTER TABLE Users
MODIFY COLUMN createdAt INT NOT NULL;