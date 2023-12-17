-- +migrate Up
USE aztebotBotDb;

ALTER TABLE UserStats
  ADD COLUMN lastActivityTimestamp INT NOT NULL DEFAULT 0,
  ADD COLUMN numberActivitiesToday INT NOT NULL DEFAULT 0;

-- +migrate Down
ALTER TABLE UserStats
  DROP COLUMN lastActivityTimestamp,
  DROP COLUMN numberActivitiesToday;