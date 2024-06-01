-- +migrate Up
USE aztebotBotDb;

UPDATE Roles SET id = id + 1
WHERE id >= 3 ORDER BY id DESC;

INSERT INTO Roles (id, roleName, displayName, emoji, info)
VALUES (3, 'trial_moderator', 'Trial Moderator', '', '');

-- +migrate Down
USE aztebotBotDb;

DELETE FROM Roles WHERE id = 3;

UPDATE Roles SET id = id - 1
WHERE id >= 3 ORDER BY id ASC;