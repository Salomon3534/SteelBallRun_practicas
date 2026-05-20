DROP DATABASE IF EXISTS sbr;
CREATE DATABASE IF NOT EXISTS sbr CHARACTER SET utf8mb4;
USE sbr;

CREATE TABLE person (
    id      INT AUTO_INCREMENT PRIMARY KEY,
    name    VARCHAR(100) NOT NULL,
    age     INT NOT NULL CHECK (age >= 16),
    country VARCHAR(100) NOT NULL,
    dni     VARCHAR(9) NOT NULL
);

CREATE TABLE mount (
    id   INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(100) NOT NULL
);

CREATE TABLE runner (
    bib       INT AUTO_INCREMENT PRIMARY KEY,
    id_person INT NOT NULL,
    id_mount  INT NOT NULL,
    image     LONGBLOB,
    points    INT,
    km        INT,
    id_stage  INT,
    passkey   VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_person) REFERENCES person(id) ON DELETE CASCADE,
    FOREIGN KEY (id_mount)  REFERENCES mount(id)  ON DELETE CASCADE
);

CREATE TABLE sponsor (
    id   INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE stage (
    id        INT AUTO_INCREMENT PRIMARY KEY,
    name      VARCHAR(150) NOT NULL,
    location  VARCHAR(200),
    completed BOOLEAN DEFAULT FALSE,
    image     LONGBLOB
);

CREATE TABLE medical_check (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    runner_id  INT NOT NULL,
    check_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    passed     BOOLEAN,
    notes      TEXT,
    FOREIGN KEY (runner_id) REFERENCES runner(bib) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS user (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    username   VARCHAR(100) NOT NULL UNIQUE,
    passkey    VARCHAR(64)  NOT NULL,
    role       ENUM('admin','user') NOT NULL DEFAULT 'user',
    runner_id  INT,
    FOREIGN KEY (runner_id) REFERENCES runner(bib) ON DELETE SET NULL
);

-- Default admin (passkey plain text: AdminSBR1890)
INSERT IGNORE INTO user (username, passkey, role, runner_id)
VALUES ('admin', SHA2('AdminSBR1890', 256), 'admin', NULL);
