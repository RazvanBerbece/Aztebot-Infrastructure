-- +migrate Up
USE aztebotBotDb;

UPDATE Roles SET id = id + 1
WHERE id >= 8 ORDER BY id DESC;

INSERT INTO Roles (id, roleName, displayName, emoji, info)
VALUES (8, 'developer', 'Developer', '', 'Persoană desemnată cu management-ul si construirea boților OTA.');

-- +migrate Down
USE aztebotBotDb;

DELETE FROM Roles WHERE id = 8;

UPDATE Roles SET id = id - 1
WHERE id >= 8 ORDER BY id ASC;