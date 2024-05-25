-- +migrate Up
CREATE DATABASE azteMarketDb;

-- Update the character set and collation for the database
ALTER DATABASE azteMarketDb CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- +migrate Down
DROP DATABASE IF EXISTS azteMarketDb;