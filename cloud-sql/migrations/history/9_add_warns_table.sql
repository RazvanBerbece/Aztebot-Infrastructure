-- +migrate Up
USE aztebotBotDb;

CREATE TABLE IF NOT EXISTS Warns (
  id                    INT AUTO_INCREMENT NOT NULL,
  userId                VARCHAR(255) NOT NULL,
  reason                VARCHAR(500) NOT NULL,
  creationTimestamp     INT NOT NULL,
  PRIMARY KEY (`id`)
);

-- +migrate Down
DROP TABLE IF EXISTS Warns;