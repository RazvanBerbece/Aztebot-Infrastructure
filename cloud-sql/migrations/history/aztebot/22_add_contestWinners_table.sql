-- +migrate Up
USE aztebotBotDb;

CREATE TABLE IF NOT EXISTS ArcadeLadder (
  userId                 VARCHAR(255) NOT NULL,
  wins                   INT NOT NULL,
  PRIMARY KEY (`userId`)
);

-- +migrate Down
DROP TABLE IF EXISTS ArcadeLadder;