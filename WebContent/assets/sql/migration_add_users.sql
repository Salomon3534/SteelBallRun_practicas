-- ============================================================
-- MIGRATION: add user table with roles
-- Run this AFTER the main database_steel_ball_run.sql
-- ============================================================
USE sbr;

CREATE TABLE IF NOT EXISTS user (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    username   VARCHAR(100) NOT NULL UNIQUE,
    passkey    VARCHAR(64)  NOT NULL,  -- SHA-256 hex
    role       ENUM('admin','user') NOT NULL DEFAULT 'user',
    runner_id  INT,
    FOREIGN KEY (runner_id) REFERENCES runner(bib) ON DELETE SET NULL
);

-- Default admin account
-- username: admin
-- passkey (plain text): AdminSBR1890
-- passkey (SHA-256): run `echo -n "AdminSBR1890" | sha256sum` to verify
INSERT IGNORE INTO user (username, passkey, role, runner_id)
VALUES (
    'admin',
    SHA2('AdminSBR1890', 256),
    'admin',
    NULL
);
