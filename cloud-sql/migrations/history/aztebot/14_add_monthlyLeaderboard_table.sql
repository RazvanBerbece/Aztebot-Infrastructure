-- +migrate Up
USE aztebotBotDb;

CREATE TABLE IF NOT EXISTS MonthlyLeaderboard (
  userId                    VARCHAR(255) NOT NULL,
  xpEarnedInCurrentMonth    INT NOT NULL,
  category                  BIT NOT NULL,
  PRIMARY KEY (`userId`)
);

-- +migrate Down
DROP TABLE IF EXISTS MonthlyLeaderboard;