-- +migrate Up
USE aztebotBotDb;

ALTER TABLE UserStats
  ADD COLUMN timeSpentListeningMusic INT NOT NULL DEFAULT 0;

-- +migrate Down
USE aztebotBotDb;
ALTER TABLE UserStats
  DROP COLUMN timeSpentListeningMusic;