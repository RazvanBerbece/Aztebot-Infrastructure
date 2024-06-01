-- +migrate Up
USE aztebotBotDb;

ALTER TABLE Jail
  ADD COLUMN roleIdsBeforeJail VARCHAR(255) NOT NULL DEFAULT ",";

-- +migrate Down
USE aztebotBotDb;

ALTER TABLE Jail
  DROP COLUMN roleIdsBeforeJail;