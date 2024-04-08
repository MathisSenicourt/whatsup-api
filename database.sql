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