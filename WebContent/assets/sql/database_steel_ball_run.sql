DROP DATABASE IF EXISTS sbr;
CREATE DATABASE IF NOT EXISTS sbr CHARACTER SET utf8mb4;
USE sbr;

CREATE TABLE person (
    id      INT AUTO_INCREMENT PRIMARY KEY,
    name    VARCHAR(100) NOT NULL,
    age     INT NOT NULL CHECK (age >= 16),
    country VARCHAR(100) NOT NULL,
    dni     CHAR(9) NOT NULL
);

CREATE TABLE mount (
    id   INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(100) NOT NULL
);

CREATE TABLE stage (
    id        INT AUTO_INCREMENT PRIMARY KEY,
    name      VARCHAR(150) NOT NULL,
    location  VARCHAR(200),
    completed BOOLEAN DEFAULT FALSE,
    image     LONGBLOB
);

CREATE TABLE runner (
    bib       INT AUTO_INCREMENT PRIMARY KEY,
    id_person INT NOT NULL,
    id_mount  INT NOT NULL,
    image     LONGBLOB,
    points    INT DEFAULT 0,
    km        INT DEFAULT 0,
    id_stage  INT,
    status    ENUM('active', 'retired', 'disqualified') NOT NULL DEFAULT 'active',
    FOREIGN KEY (id_person) REFERENCES person(id)  ON DELETE CASCADE,
    FOREIGN KEY (id_mount)  REFERENCES mount(id)   ON DELETE CASCADE,
    FOREIGN KEY (id_stage)  REFERENCES stage(id)   ON DELETE SET NULL
);

CREATE TABLE medical_check (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    runner_id  INT NOT NULL,
    check_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    passed     BOOLEAN NOT NULL DEFAULT TRUE,
    notes      TEXT,
    FOREIGN KEY (runner_id) REFERENCES runner(bib) ON DELETE CASCADE
);

-- chequeo médico suspendido, corredor retirado automáticamente
DELIMITER //
CREATE TRIGGER trg_medical_check_fail
AFTER INSERT ON medical_check
FOR EACH ROW
BEGIN
    IF NEW.passed = 0 THEN
        UPDATE runner
           SET status = 'retired'
         WHERE bib = NEW.runner_id
           AND status = 'active';
    END IF;
END//
DELIMITER ;

CREATE TABLE sponsor (
    id   INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE user (
    id        INT AUTO_INCREMENT PRIMARY KEY,
    username  VARCHAR(100) NOT NULL UNIQUE,
    passkey   VARCHAR(64)  NOT NULL,
    role      ENUM('admin','user') NOT NULL DEFAULT 'user',
    runner_id INT,
    FOREIGN KEY (runner_id) REFERENCES runner(bib) ON DELETE SET NULL
);

-- Usuario administrador por defecto  (contraseña: AdminSBR1890)
INSERT INTO user (username, passkey, role, runner_id)
VALUES ('admin', SHA2('AdminSBR1890', 256), 'admin', NULL);
