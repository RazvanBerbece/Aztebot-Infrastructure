-- +migrate Up
USE aztebotBotDb;

ALTER TABLE Users
  ADD COLUMN gender INT NOT NULL DEFAULT -1;

-- +migrate Down
USE aztebotBotDb;

ALTER TABLE Users
  DROP COLUMN gender;