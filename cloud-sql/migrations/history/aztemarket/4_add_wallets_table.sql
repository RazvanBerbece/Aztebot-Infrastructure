-- +migrate Up
USE azteMarketDb;

CREATE TABLE IF NOT EXISTS Wallets (
  userId                VARCHAR(255) NOT NULL,
  id                    VARCHAR(255) NOT NULL,
  funds                 DECIMAL(13, 2),
  inventory             VARCHAR(4096) NOT NULL,
  PRIMARY KEY (userId)
);

-- +migrate Down
DROP TABLE IF EXISTS Wallets;