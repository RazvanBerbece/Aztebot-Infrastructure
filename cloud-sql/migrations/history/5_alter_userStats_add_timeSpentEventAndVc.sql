-- +migrate Up
USE aztebotBotDb;

ALTER TABLE UserStats
  ADD COLUMN timeSpentInVoiceChannels INT NOT NULL DEFAULT 0,
  ADD COLUMN timeSpentInEvents INT NOT NULL DEFAULT 0;

-- +migrate Down
USE aztebotBotDb;
ALTER TABLE UserStats
  DROP COLUMN timeSpentInVoiceChannels,
  DROP COLUMN timeSpentInEvents;