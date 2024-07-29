-- +migrate Up
USE aztebotBotDb;

CREATE TABLE IF NOT EXISTS GlobalGainRates (
  activityId               VARCHAR(255) NOT NULL,
  multiplierXp             float(5) NOT NULL,
  multiplierCoins          float(5) NOT NULL,
  PRIMARY KEY (`activityId`)
);
INSERT INTO GlobalGainRates
  (activityId, multiplierXp, multiplierCoins)
VALUES
  ('msg_send', 1.0, 2.5),
  ('slash_command_used', 0.75, 2.5),
  ('react_recv', 0.66, 7.5),
  ('in_vc', 0.0033, 0.04),
  ('in_music', 0.00175, 0.003);

-- +migrate Down
DROP TABLE IF EXISTS GlobalGainRates;