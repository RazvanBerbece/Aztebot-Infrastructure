-- +migrate Up
USE azteMarketDb;

CREATE TABLE IF NOT EXISTS Stock (
  id                     VARCHAR(255) NOT NULL,
  displayName            VARCHAR(255) NOT NULL,
  details                VARCHAR(1024) NOT NULL,
  cost                   INT NOT NULL,
  PRIMARY KEY (`id`)
);

-- +migrate Down
DROP TABLE IF EXISTS Stock;