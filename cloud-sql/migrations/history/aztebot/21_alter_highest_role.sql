-- +migrate Up
USE aztebotBotDb;

UPDATE Roles SET displayName = 'Arhitect'
WHERE roleName = 'arhitect';

-- +migrate Down
USE aztebotBotDb;

UPDATE Roles SET displayName = '👁‍🗨 Arhitect'
WHERE roleName = 'arhitect';