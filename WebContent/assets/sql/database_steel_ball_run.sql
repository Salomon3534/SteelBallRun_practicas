DROP DATABASE IF EXISTS sbr;

CREATE DATABASE IF NOT EXISTS sbr
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE sbr;

-- Tabla de monturas
CREATE TABLE mount (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(100)
);

-- Tabla de sponsors
CREATE TABLE sponsor (
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100)
);

-- Tabla de corredores
CREATE TABLE runner (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    surnames VARCHAR(200),
    age INT,
    nationality VARCHAR(50),
    mount_id INT,
    bib INT AUTO_INCREMENT UNIQUE,
    current_place INT,
    total_points INT DEFAULT 0
);

CREATE TABLE person (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    surnames VARCHAR(200),
    age INT,
    dni VARCHAR(20) UNIQUE NOT NULL
);