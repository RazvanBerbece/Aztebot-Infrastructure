-- +migrate Up
USE aztebotBotDb;

ALTER TABLE Users
  ADD UNIQUE KEY (id);

ALTER TABLE Users
  DROP PRIMARY KEY;

ALTER TABLE Users
  ADD PRIMARY KEY (userId);

-- +migrate Down
USE aztebotBotDb;

ALTER TABLE Users
  DROP PRIMARY KEY;

ALTER TABLE Users
  DROP UNIQUE KEY (id);
  
ALTER TABLE Users
  ADD PRIMARY KEY (id);
