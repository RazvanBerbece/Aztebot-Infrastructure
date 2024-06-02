-- +migrate Up
USE azteMarketDb;

ALTER TABLE Stock MODIFY cost float(2) NOT NULL;

-- +migrate Down
USE azteMarketDb;

ALTER TABLE Stock MODIFY cost INT NOT NULL;