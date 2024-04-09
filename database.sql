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
    FOREIGN KEY (sender) REFERENCES login (mail),
    FOREIGN KEY (receiver) REFERENCES login (mail)
);

-- Insérer les comptes dans la table login
INSERT INTO login (mail, password)
VALUES ('toto@example.com', '$2b$10$GxqMJNqJO1fe.014TyFiYen8LXNG/glJX6ZoOMuz.TRrx4sJHU7F2'),
       ('mat@example.com', '$2b$10$GxqMJNqJO1fe.014TyFiYen8LXNG/glJX6ZoOMuz.TRrx4sJHU7F2'),
       ('michel@example.com', '$2b$10$GxqMJNqJO1fe.014TyFiYen8LXNG/glJX6ZoOMuz.TRrx4sJHU7F2');

-- Insérer les informations de profil dans la table account
INSERT INTO account (mail, username, name, surname, pp_url)
VALUES ('toto@example.com', 'toto', 'Toto', 'Totor',
        'https://static.wikia.nocookie.net/dc6d3e8b-0582-4a85-b0e5-0c296442223c/scale-to-width/755'),
       ('mat@example.com', 'mat', 'Mat', 'Mathieu',
        'https://static.wikia.nocookie.net/dc6d3e8b-0582-4a85-b0e5-0c296442223c/scale-to-width/755'),
       ('michel@example.com', 'michel', 'Michel', 'Michelson',
        'https://static.wikia.nocookie.net/dc6d3e8b-0582-4a85-b0e5-0c296442223c/scale-to-width/755');

-- Créer des conversations entre les utilisateurs
INSERT INTO messages (sender, receiver, content, date)
VALUES ('toto@example.com', 'mat@example.com', 'Salut Mat, comment ça va ?', '2023-01-14 12:00:00'),
       ('mat@example.com', 'toto@example.com', 'Salut Toto, ça va bien et toi ?', '2023-01-14 12:01:00'),
       ('toto@example.com', 'mat@example.com', 'Ça va aussi. Tu as fait quelque chose de prévu ce week-end ?',
        '2023-01-14 12:02:00'),
       ('mat@example.com', 'toto@example.com', 'Non, je n''ai rien de spécial de prévu. Tu as des idées ?',
        '2023-01-14 12:03:00'),
       ('toto@example.com', 'mat@example.com', 'On pourrait aller voir un film au cinéma.', '2023-01-14 12:04:00'),
       ('mat@example.com', 'toto@example.com', 'Bonne idée ! Tu veux aller voir quel film ?', '2023-01-14 12:05:00'),
       ('toto@example.com', 'mat@example.com', 'Je ne sais pas encore, je vais regarder les horaires et je te dis.',
        '2023-01-14 12:06:00'),
       ('mat@example.com', 'toto@example.com', 'D''accord, tiens-moi au courant.', '2023-01-14 12:07:00'),
       ('toto@example.com', 'mat@example.com',
        'Je viens de regarder, il y a une séance à 15h pour le dernier film Marvel.', '2023-01-14 12:08:00'),
       ('mat@example.com', 'toto@example.com', 'Parfait ! On se retrouve devant le cinéma à 14h45 alors.',
        '2023-01-14 12:09:00'),
       ('toto@example.com', 'michel@example.com', 'Salut Michel, comment ça va ?', '2023-01-14 12:10:00'),
       ('michel@example.com', 'toto@example.com', 'Salut Toto, ça va bien et toi ?', '2023-01-14 12:11:00'),
       ('toto@example.com', 'michel@example.com', 'Tranquille. Tu as des projets pour ce week-end ?',
        '2023-01-14 12:12:00'),
       ('michel@example.com', 'toto@example.com', 'Non, pas vraiment. Peut-être que je vais aller faire une randonnée.',
        '2023-01-14 12:13:00'),
       ('toto@example.com', 'michel@example.com', 'Ça sonne bien. Si tu veux de la compagnie, fais-moi signe.',
        '2023-01-14 12:14:00'),
       ('michel@example.com', 'toto@example.com', 'Ça marche, je te tiendrai au courant.', '2023-01-14 12:15:00');
