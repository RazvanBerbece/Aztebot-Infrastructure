-- +migrate Up
USE azteMarketDb;

ALTER DATABASE azteMarketDb CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS CurrencySystemState (
  guildId                 VARCHAR(255) NOT NULL,
  currencyName            VARCHAR(255) NOT NULL,
  totalCurrencyAvailable  DECIMAL(13, 2),
  totalCurrencyInFlow     DECIMAL(13, 2),
  dateOfLastReplenish     INT NOT NULL,
  PRIMARY KEY (guildId)
);

INSERT INTO CurrencySystemState
  (guildId, currencyName, totalCurrencyAvailable, totalCurrencyInFlow, dateOfLastReplenish)
VALUES
  ("1099254930075832330", "AzteCoin 🪙", 5000000, NULL, 1724512894);

-- +migrate Down
DROP TABLE IF EXISTS CurrencySystemState;