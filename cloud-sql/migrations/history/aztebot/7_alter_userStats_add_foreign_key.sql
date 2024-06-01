-- +migrate Up
USE aztebotBotDb;

ALTER TABLE UserStats
  ADD FOREIGN KEY (userId) REFERENCES Users(userId);

-- +migrate Down
USE aztebotBotDb;

ALTER TABLE Users
  DROP FOREIGN KEY;
