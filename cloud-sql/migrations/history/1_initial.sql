-- +migrate Up
USE aztebotBotDb;

-- Update the character set and collation for the database
ALTER DATABASE aztebotBotDb CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS Roles (
  id                    INT AUTO_INCREMENT NOT NULL,
  roleName              VARCHAR(255) NOT NULL,
  displayName           VARCHAR(255) NOT NULL,
  emoji                 VARCHAR(255),
  info                  VARCHAR(510),
  PRIMARY KEY (`id`)
);
INSERT INTO Roles
  (id, roleName, displayName, emoji, info)
VALUES 
  (1, 'aztec', 'Aztec', '', 'Membru oficial al acestei comunități.'),
  (2, 'server_booster', 'Server Booster', '', 'Cei care au boostat serverul. (Vă mulțumim frumos)'),
  (3, 'moderator', 'Moderator', '', 'Moderatorii comunității.'),
  (4, 'top_contribuitori', 'Top Contribuitori', '', 'Cei care au contribuit cel mai mult la dezvoltarea server-ului prin sugestiile si ideile pe care le-au exprimat si avut.'),
  (5, 'administrator', 'Administrator', '', 'Administratorii comunității.'),
  (6, 'senior_administrator', 'Senior Administrator', '', 'Administratorii seniori ai comunității.'),
  (7, 'consul', 'Consul', '', 'Persoana ce se ocupă cu îndrumarea staff-ului.'),
  (8, 'zelator', 'Zelator', '🔗', ''),
  (9, 'theoricus', 'Theoricus', '📖', ''),
  (10, 'practicus', 'Practicus', '🎩', ''),
  (11, 'philosophus', 'Philosophus', '📿', ''),
  (12, 'adeptus_minor', 'Adeptus Minor', '🔮', ''),
  (13, 'adeptus_major', 'Adeptus Major', '〽️', ''),
  (14, 'adeptus_exemptus', 'Adeptus Exemptus', '🧿', ''),
  (15, 'magister_templi', 'Magister Templi', '☀️', ''),
  (16, 'magus', 'Magus', '🧙🏼', ''),
  (17, 'ipsissimus', 'Ipsissimus', '⚔️', ''),
  (18, 'arhitect', '👁‍🗨 Arhitect', '👁‍🗨', 'Fondatorii comunității.');


CREATE TABLE IF NOT EXISTS Users (
  id                   INT AUTO_INCREMENT NOT NULL,
  discordTag           VARCHAR(255) NOT NULL,
  userId               VARCHAR(255) NOT NULL,
  currentRoleIds       VARCHAR(255) NOT NULL,
  currentCircle        VARCHAR(255) NOT NULL,   -- INNER/OUTER
  currentInnerOrder    INT,                     -- CAN BE NULL IF USER NOT IN THE INNER CIRCLE, NUMERAL OTHERWISE (1-3)
  currentLevel         INT NOT NULL,
  currentExperience    INT NOT NULL,            -- CUMULATION OF POINTS DRIVEN BY CONTRIBUTIONS, HOURS SPENT, ETC.
  createdAt            INT NOT NULL,            -- UNIX TIMESTAMP AT VERIFICATION (`Aztec`) TIME
  PRIMARY KEY (`id`)
);
INSERT INTO Users
  (id, discordTag, userId, currentRoleIds, currentCircle, currentInnerOrder, currentLevel, currentExperience, createdAt)
VALUES
  (1, 'antoniozrd', '573659533361020941', '1,6,7,16', 'INNER', 3, 99, 0, 1696978799),
  (2, 'lordvixxen1337', '1077147870655950908', '1,2,17,18', 'INNER', 3, 100, 999, 1696978799),
  (3, 'aztegramul', '526512064794066945', '1,2,7,17,18', 'INNER', 3, 100, 999, 1696978799);

-- +migrate Down
DROP TABLE IF EXISTS Roles;
DROP TABLE IF EXISTS Users;