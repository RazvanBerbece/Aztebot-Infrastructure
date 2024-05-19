-- +migrate Up
USE aztebotBotDb;

CREATE TABLE IF NOT EXISTS UserRep (
  userId                 VARCHAR(255) NOT NULL,
  rep                    INT NOT NULL,
  PRIMARY KEY (`userId`)
);

-- +migrate Down
DROP TABLE IF EXISTS UserRep;