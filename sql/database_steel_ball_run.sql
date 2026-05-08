DROP DATABASE IF EXISTS steel_ball_run;
CREATE DATABASE IF NOT EXISTS steel_ball_run;
USE steel_ball_run;

-- Tabla de Caballos
CREATE TABLE caballos (
    id_caballo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    raza VARCHAR(100)
);

-- Tabla de Corredores
CREATE TABLE corredores (
    id_corredor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    nacionalidad VARCHAR(50),
    id_caballo INT NULL,
    puntos_totales INT DEFAULT 0,
    FOREIGN KEY (id_caballo) REFERENCES caballos(id_caballo)
);

-- Tabla de Etapas
CREATE TABLE etapas (
    id_etapa INT AUTO_INCREMENT PRIMARY KEY,
    numero_etapa INT NOT NULL,
    nombre_etapa VARCHAR(100),
    distancia_km DECIMAL(10, 2),
    inicio VARCHAR(100),
    fin VARCHAR(100)
);

-- Tabla de Resultados por Etapa
CREATE TABLE resultados_etapa (
    id_resultado INT AUTO_INCREMENT PRIMARY KEY,
    id_etapa INT,
    id_corredor INT,
    puesto INT,
    puntos_obtenidos INT,
    FOREIGN KEY (id_etapa) REFERENCES etapas(id_etapa),
    FOREIGN KEY (id_corredor) REFERENCES corredores(id_corredor)
);

-- --------------------------------------------------------
-- INSERCIÓN DE DATOS: CABALLOS
-- --------------------------------------------------------
INSERT INTO caballos (nombre, raza) VALUES 
('Slow Dancer', 'Appaloosa'),
('Valkyrie', 'Stock Horse Australiano'),
('Silver Bullet', 'Purasangre Árabe'),
('Ghost Rider', 'Mustang'),
('Hey Ya!', 'Quarter Horse'),
('Gets Up', 'Hanoveriano'),
('#1', 'Boulonnais'),
('Foxy Lady', 'Quarter Horse'),
('Europe Express', 'Trakehner'),
('Crosstown Traffic', 'Quarter Horse'),
('Little Wing', 'Appaloosa'),
('El Condor Pasa', 'Desconocida'),
('Pegasus', 'Desconocida'),
('Moon Flower', 'Andaluz'),
('Love Unlimited', 'Mustang'),
('Natalie', 'Palomino'),
('Nut Rocker', 'Desconocida');

-- --------------------------------------------------------
-- INSERCIÓN DE DATOS: CORREDORES EXHAUSTIVA
-- --------------------------------------------------------
INSERT INTO corredores (nombre, nacionalidad, id_caballo, puntos_totales) VALUES 
('Johnny Joestar', 'Estados Unidos', 1, 0),
('Gyro Zeppeli', 'Reino de Nápoles', 2, 0),
('Diego Brando', 'Reino Unido', 3, 0),
('Mountain Tim', 'Estados Unidos', 4, 0),
('Pocoloco', 'Estados Unidos', 5, 0),
('Sandman', 'Nativo Americano', NULL, 0), -- Corre a pie
('Hot Pants', 'Vaticano / Nápoles', 6, 0),
('Dot Han', 'China', 7, 0),
('Andre Boom Boom', 'Estados Unidos', 8, 0),
('Fritz von Stroheim', 'Alemania', 9, 0),
('Benjamin Boom Boom', 'Estados Unidos', 10, 0),
('Urmd Avdol', 'Egipto', NULL, 0), -- Monta un camello
('L.A. Boom Boom', 'Estados Unidos', 11, 0),
('Mrs. Robinson', 'México', 12, 0),
('Gaucho', 'España', 13, 0),
('Caravan Serai', 'México', 14, 0),
('Billy White', 'Estados Unidos', 15, 0),
('Iglesias', 'España', 16, 0),
('Zenyatta Mondatta', 'Estados Unidos', 17, 0),
('Oyecomova', 'Reino de Nápoles', NULL, 0),
('Sloop John B', 'Desconocido', NULL, 0),
('Dixie Chicken', 'Desconocido', NULL, 0),
('Ringo Roadagain', 'Estados Unidos', NULL, 0),
('Blackmore', 'Estados Unidos', NULL, 0),
('Pork Pie Hat Kid', 'Desconocido', NULL, 0),
('Dr. Ferdinand', 'Desconocido', NULL, 0);

-- --------------------------------------------------------
-- INSERCIÓN DE DATOS: ETAPAS
-- --------------------------------------------------------
INSERT INTO etapas (numero_etapa, nombre_etapa, distancia_km, inicio, fin) VALUES 
(1, 'Stage 1: San Diego Beach', 15.00, 'San Diego', 'Santa Maria'),
(2, 'Stage 2: Arizona Desert', 1200.00, 'Santa Maria', 'Monument Valley'),
(3, 'Stage 3: Rocky Mountains', 500.00, 'Monument Valley', 'Canon City'),
(4, 'Stage 4: Kansas Highlights', 1250.00, 'Canon City', 'Kansas City'),
(5, 'Stage 5: Illinois Skyline', 800.00, 'Kansas City', 'Chicago'),
(6, 'Stage 6: Michigan Lakeshore', 690.00, 'Chicago', 'Mackinaw City'),
(7, 'Stage 7: Philadelphia', 1300.00, 'Mackinaw City', 'Philadelphia'),
(8, 'Stage 8: New Jersey', 140.00, 'Philadelphia', 'New Jersey'),
(9, 'Stage 9: New York', 15.00, 'New Jersey', 'Trinity Church (New York)');

-- --------------------------------------------------------
-- INSERCIÓN DE DATOS: RESULTADOS DE ETAPA Y PUNTOS
-- --------------------------------------------------------
-- Resultados ampliados de la Etapa 1
INSERT INTO resultados_etapa (id_etapa, id_corredor, puesto, puntos_obtenidos) VALUES 
(1, 6, 1, 100), -- Sandman
(1, 3, 2, 50),  -- Diego Brando
(1, 1, 3, 40),  -- Johnny Joestar
(1, 5, 4, 35),  -- Pocoloco
(1, 7, 5, 30),  -- Hot Pants
(1, 8, 6, 25),  -- Dot Han
(1, 16, 7, 20), -- Caravan Serai
(1, 17, 8, 15), -- Billy White
(1, 14, 9, 10), -- Mrs. Robinson
(1, 13, 10, 5), -- L.A. Boom Boom
(1, 2, 21, 0),  -- Gyro Zeppeli (Relegado por penalización)
(1, 12, 99, 0); -- Urmd Avdol (Retirado)

-- Resultados ampliados de la Etapa 2
INSERT INTO resultados_etapa (id_etapa, id_corredor, puesto, puntos_obtenidos) VALUES 
(2, 3, 1, 100), -- Diego Brando
(2, 2, 2, 50),  -- Gyro Zeppeli
(2, 5, 3, 40),  -- Pocoloco
(2, 1, 4, 35),  -- Johnny Joestar
(2, 6, 5, 30),  -- Sandman
(2, 15, 6, 25), -- Gaucho
(2, 18, 7, 20), -- Iglesias
(2, 19, 8, 15), -- Zenyatta Mondatta
(2, 21, 9, 10), -- Sloop John B
(2, 4, 10, 5);  -- Mountain Tim

-- Resultados ampliados de la Etapa 3
INSERT INTO resultados_etapa (id_etapa, id_corredor, puesto, puntos_obtenidos) VALUES 
(3, 7, 1, 100), -- Hot Pants
(3, 2, 2, 50),  -- Gyro Zeppeli
(3, 3, 3, 40),  -- Diego Brando
(3, 1, 4, 35),  -- Johnny Joestar
(3, 22, 5, 30); -- Dixie Chicken

-- --------------------------------------------------------
-- ACTUALIZACIÓN DE PUNTOS TOTALES
-- --------------------------------------------------------
SET SQL_SAFE_UPDATES = 0;
UPDATE corredores c
SET puntos_totales = (
    SELECT COALESCE(SUM(puntos_obtenidos), 0)
    FROM resultados_etapa r
    WHERE r.id_corredor = c.id_corredor
);
SET SQL_SAFE_UPDATES = 1;