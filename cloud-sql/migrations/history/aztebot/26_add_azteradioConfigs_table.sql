-- +migrate Up
USE aztebotBotDb;

CREATE TABLE IF NOT EXISTS AzteradioConfigurations (
  guildId                 VARCHAR(255) NOT NULL,
  defaultRadioChannelId   VARCHAR(255) NOT NULL,
  PRIMARY KEY (`guildId`)
);

-- +migrate Down
DROP TABLE IF EXISTS AzteradioConfigurations;