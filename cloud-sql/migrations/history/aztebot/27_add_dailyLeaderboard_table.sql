-- +migrate Up
USE aztebotBotDb;

CREATE TABLE IF NOT EXISTS DailyLeaderboard (
  userId                    VARCHAR(255) NOT NULL,
  xpEarnedInCurrentDay      float(5) NOT NULL,
  category                  INT NOT NULL,
  PRIMARY KEY (`userId`)
);

-- +migrate Down
DROP TABLE IF EXISTS DailyLeaderboard;