-- +migrate Up
USE azteMarketDb;

CREATE TABLE IF NOT EXISTS Wallets (
  id                    VARCHAR(255) NOT NULL,
  userId                VARCHAR(255) NOT NULL,
  funds                 VARCHAR(255) NOT NULL,
  inventory             VARCHAR(4096) NOT NULL,
  PRIMARY KEY (`id`, `userId`)
);

-- +migrate Down
DROP TABLE IF EXISTS Wallets;