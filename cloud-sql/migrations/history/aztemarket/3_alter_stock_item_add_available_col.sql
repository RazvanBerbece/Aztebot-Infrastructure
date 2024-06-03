-- +migrate Up
USE azteMarketDb;

ALTER TABLE Stock
  ADD COLUMN numAvailable INT NOT NULL DEFAULT 0;

-- +migrate Down
USE azteMarketDb;

ALTER TABLE Users
  DROP COLUMN numAvailable;