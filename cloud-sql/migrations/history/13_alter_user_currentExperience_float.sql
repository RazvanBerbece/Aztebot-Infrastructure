-- +migrate Up
USE aztebotBotDb;

ALTER TABLE Users MODIFY currentExperience float(5) NOT NULL;

-- +migrate Down
USE aztebotBotDb;

ALTER TABLE Users MODIFY currentExperience INT NOT NULL;