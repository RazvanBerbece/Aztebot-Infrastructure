-- +migrate Up
USE aztebotBotDb;

ALTER TABLE MonthlyLeaderboard MODIFY xpEarnedInCurrentMonth float(5) NOT NULL;

-- +migrate Down
USE aztebotBotDb;

ALTER TABLE MonthlyLeaderboard MODIFY xpEarnedInCurrentMonth INT NOT NULL;