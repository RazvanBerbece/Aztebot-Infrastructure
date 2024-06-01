-- +migrate Up
USE aztebotBotDb;

UPDATE Roles SET id = id + 1
WHERE id >= 8 ORDER BY id DESC;

INSERT INTO Roles (id, roleName, displayName, emoji, info)
VALUES (8, 'dominus', 'Dominus', '', 'Persoană desemnată cu sprijinul Arhitecților în management.');

-- +migrate Down
USE aztebotBotDb;

-- First, delete the record inserted in the UP migration
DELETE FROM Roles WHERE id = 8;

-- Next, revert the changes made in the UPDATE statement
UPDATE Roles SET id = id - 1
WHERE id >= 9 ORDER BY id ASC;