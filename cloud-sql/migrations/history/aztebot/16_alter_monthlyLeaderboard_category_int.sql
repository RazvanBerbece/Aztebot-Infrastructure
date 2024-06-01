-- +migrate Up
USE aztebotBotDb;

ALTER TABLE MonthlyLeaderboard MODIFY category INT NOT NULL;

-- +migrate Down
USE aztebotBotDb;

ALTER TABLE MonthlyLeaderboard MODIFY category BIT NOT NULL;