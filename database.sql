CREATE DATABASE IF NOT EXISTS whatsup;

USE whatsup;

DROP TABLE IF EXISTS messages;
DROP TABLE IF EXISTS account;
DROP TABLE IF EXISTS login;

CREATE TABLE login
(
    id       INT AUTO_INCREMENT PRIMARY KEY,
    mail     VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255)        NOT NULL
);

CREATE TABLE account
(
    mail     VARCHAR(255) PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    name     VARCHAR(50),
    surname  VARCHAR(50),
    pp_url   VARCHAR(2000),
    FOREIGN KEY (mail) REFERENCES login (mail)
);

CREATE TABLE messages
(
    id       INT AUTO_INCREMENT PRIMARY KEY,
    sender   VARCHAR(255),
    receiver VARCHAR(255),
    content  TEXT,
    date     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    room_id  VARCHAR(6),
    FOREIGN KEY (sender) REFERENCES login (mail),
    FOREIGN KEY (receiver) REFERENCES login (mail)
);

-- Insert accounts into the login table
INSERT INTO login (mail, password)
VALUES
    ('toto@example.com', '$2a$10$stt7COZZD3BcAPK.e0p1l.062TGeWuHeUX7oVPDQWcvqnTaLc47YS'),
    ('mat@example.com', '$2a$10$stt7COZZD3BcAPK.e0p1l.062TGeWuHeUX7oVPDQWcvqnTaLc47YS'),
    ('michel@example.com', '$2a$10$stt7COZZD3BcAPK.e0p1l.062TGeWuHeUX7oVPDQWcvqnTaLc47YS'),
    ('alice@example.com', '$2a$10$stt7COZZD3BcAPK.e0p1l.062TGeWuHeUX7oVPDQWcvqnTaLc47YS'),
    ('bob@example.com', '$2a$10$stt7COZZD3BcAPK.e0p1l.062TGeWuHeUX7oVPDQWcvqnTaLc47YS');

-- Insert profile information into the account table
INSERT INTO account (mail, username, name, surname, pp_url)
VALUES
    ('toto@example.com', 'toto', 'Toto', 'Totor', 'https://static.wikia.nocookie.net/dc6d3e8b-0582-4a85-b0e5-0c296442223c/scale-to-width/755'),
    ('mat@example.com', 'mat', 'Mat', 'Mathieu', 'https://static.wikia.nocookie.net/dc6d3e8b-0582-4a85-b0e5-0c296442223c/scale-to-width/755'),
    ('michel@example.com', 'michel', 'Michel', 'Michelson', 'https://static.wikia.nocookie.net/dc6d3e8b-0582-4a85-b0e5-0c296442223c/scale-to-width/755'),
    ('alice@example.com', 'alice', 'Alice', 'Wonder', 'https://static.wikia.nocookie.net/dc6d3e8b-0582-4a85-b0e5-0c296442223c/scale-to-width/755'),
    ('bob@example.com', 'bob', 'Bob', 'Builder', 'https://static.wikia.nocookie.net/dc6d3e8b-0582-4a85-b0e5-0c296442223c/scale-to-width/755');

-- Insert conversations between users with room_id
INSERT INTO messages (sender, receiver, content, date, room_id)
VALUES
-- Conversations between Toto and Mat
('toto@example.com', 'mat@example.com', 'Salut Mat, comment ça va ?', '2023-01-14 12:00:00', 'ROOM01'),
('mat@example.com', 'toto@example.com', 'Salut Toto, ça va bien et toi ?', '2023-01-14 12:01:00', 'ROOM01'),
('toto@example.com', 'mat@example.com', 'Ça va aussi. Tu as fait quelque chose de prévu ce week-end ?', '2023-01-14 12:02:00', 'ROOM01'),
('mat@example.com', 'toto@example.com', 'Non, je n''ai rien de spécial de prévu. Tu as des idées ?', '2023-01-14 12:03:00', 'ROOM01'),
('toto@example.com', 'mat@example.com', 'On pourrait aller voir un film au cinéma.', '2023-01-14 12:04:00', 'ROOM01'),
('mat@example.com', 'toto@example.com', 'Bonne idée ! Tu veux aller voir quel film ?', '2023-01-14 12:05:00', 'ROOM01'),
('toto@example.com', 'mat@example.com', 'Je ne sais pas encore, je vais regarder les horaires et je te dis.', '2023-01-14 12:06:00', 'ROOM01'),
('mat@example.com', 'toto@example.com', 'D''accord, tiens-moi au courant.', '2023-01-14 12:07:00', 'ROOM01'),
('toto@example.com', 'mat@example.com', 'Je viens de regarder, il y a une séance à 15h pour le dernier film Marvel.', '2023-01-14 12:08:00', 'ROOM01'),
('mat@example.com', 'toto@example.com', 'Parfait ! On se retrouve devant le cinéma à 14h45 alors.', '2023-01-14 12:09:00', 'ROOM01'),

-- Conversations between Toto and Michel
('toto@example.com', 'michel@example.com', 'Salut Michel, comment ça va ?', '2023-01-14 12:10:00', 'ROOM02'),
('michel@example.com', 'toto@example.com', 'Salut Toto, ça va bien et toi ?', '2023-01-14 12:11:00', 'ROOM02'),
('toto@example.com', 'michel@example.com', 'Tranquille. Tu as des projets pour ce week-end ?', '2023-01-14 12:12:00', 'ROOM02'),
('michel@example.com', 'toto@example.com', 'Non, pas vraiment. Peut-être que je vais aller faire une randonnée.', '2023-01-14 12:13:00', 'ROOM02'),
('toto@example.com', 'michel@example.com', 'Ça sonne bien. Si tu veux de la compagnie, fais-moi signe.', '2023-01-14 12:14:00', 'ROOM02'),
('michel@example.com', 'toto@example.com', 'Ça marche, je te tiendrai au courant.', '2023-01-14 12:15:00', 'ROOM02'),

-- Conversations between Alice and Bob
('alice@example.com', 'bob@example.com', 'Salut Bob, tu fais quoi ?', '2023-01-14 12:16:00', 'ROOM03'),
('bob@example.com', 'alice@example.com', 'Salut Alice, je suis en train de travailler sur un nouveau projet.', '2023-01-14 12:17:00', 'ROOM03'),
('alice@example.com', 'bob@example.com', 'Ça a l''air intéressant ! C''est quoi le projet ?', '2023-01-14 12:18:00', 'ROOM03'),
('bob@example.com', 'alice@example.com', 'Je construis une nouvelle maison pour une famille.', '2023-01-14 12:19:00', 'ROOM03'),
('alice@example.com', 'bob@example.com', 'Super ! Bon courage pour ça.', '2023-01-14 12:20:00', 'ROOM03'),
('bob@example.com', 'alice@example.com', 'Merci Alice, à bientôt.', '2023-01-14 12:21:00', 'ROOM03'),

-- Conversations between Mat and Michel
('mat@example.com', 'michel@example.com', 'Salut Michel, quoi de neuf ?', '2023-01-14 12:22:00', 'ROOM04'),
('michel@example.com', 'mat@example.com', 'Salut Mat, pas grand-chose. Et toi ?', '2023-01-14 12:23:00', 'ROOM04'),
('mat@example.com', 'michel@example.com', 'Je viens de finir un gros projet.', '2023-01-14 12:24:00', 'ROOM04'),
('michel@example.com', 'mat@example.com', 'Félicitations ! C''était difficile ?', '2023-01-14 12:25:00', 'ROOM04'),
('mat@example.com', 'michel@example.com', 'Oui, mais ça en valait la peine.', '2023-01-14 12:26:00', 'ROOM04'),
('michel@example.com', 'mat@example.com', 'Content pour toi. Bon repos maintenant.', '2023-01-14 12:27:00', 'ROOM04'),

-- Conversations between Toto and Alice
('toto@example.com', 'alice@example.com', 'Salut Alice, comment ça va ?', '2023-01-14 12:28:00', 'ROOM05'),
('alice@example.com', 'toto@example.com', 'Salut Toto, ça va bien et toi ?', '2023-01-14 12:29:00', 'ROOM05'),
('toto@example.com', 'alice@example.com', 'Ça va aussi. Tu as fait quelque chose de prévu ce week-end ?', '2023-01-14 12:30:00', 'ROOM05'),
('alice@example.com', 'toto@example.com', 'Oui, je vais voir un film.', '2023-01-14 12:31:00', 'ROOM05'),
('toto@example.com', 'alice@example.com', 'Super ! Quel film ?', '2023-01-14 12:32:00', 'ROOM05'),
('alice@example.com', 'toto@example.com', 'Le dernier Marvel.', '2023-01-14 12:33:00', 'ROOM05'),
('toto@example.com', 'alice@example.com', 'J''ai entendu dire qu''il était bien.', '2023-01-14 12:34:00', 'ROOM05'),
('alice@example.com', 'toto@example.com', 'Oui, j''ai hâte de le voir.', '2023-01-14 12:35:00', 'ROOM05');