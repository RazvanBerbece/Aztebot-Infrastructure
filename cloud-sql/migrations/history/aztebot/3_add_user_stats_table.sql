-- +migrate Up
USE aztebotBotDb;

CREATE TABLE IF NOT EXISTS UserStats (
  id                    INT AUTO_INCREMENT NOT NULL,
  userId                VARCHAR(255) NOT NULL,
  messagesSent          INT NOT NULL,
  slashCommandsUsed     INT NOT NULL,
  reactionsReceived     INT NOT NULL,
  activeDayStreak       INT NOT NULL,
  PRIMARY KEY (`id`)
);

-- +migrate Down
DROP TABLE IF EXISTS UserStats;