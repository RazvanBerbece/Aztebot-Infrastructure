-- +migrate Up
USE aztebotBotDb;

CREATE TABLE IF NOT EXISTS Jail (
  userId                    VARCHAR(255) NOT NULL,
  reason                    VARCHAR(500) NOT NULL,
  task                      VARCHAR(500) NOT NULL,
  jailedAt                  INT NOT NULL,
  PRIMARY KEY (`userId`)
);

-- +migrate Down
DROP TABLE IF EXISTS Jail;