-- +migrate Up
USE azteMarketDb;

ALTER DATABASE azteMarketDb CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS CurrencySystemState (
  guildId                 VARCHAR(255) NOT NULL,
  currencyName            VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  totalCurrencyAvailable  DECIMAL(13, 2) NOT NULL,
  totalCurrencyInFlow     DECIMAL(13, 2),
  dateOfLastReplenish     INT NOT NULL,
  PRIMARY KEY (guildId)
);

ALTER TABLE CurrencySystemState CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- +migrate Down
DROP TABLE IF EXISTS CurrencySystemState;