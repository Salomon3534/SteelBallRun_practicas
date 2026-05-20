USE sbr;

-- PERSONAS
INSERT INTO person (name, age, country, dni) VALUES
('Carlos Martínez', 28, 'España', '12345678A'),
('Lucía Gómez', 31, 'España', '23456789B'),
('Pierre Dubois', 35, 'Francia', '34567890C'),
('Anna Schmidt', 27, 'Alemania', '45678901D'),
('Marco Rossi', 40, 'Italia', '56789012E'),
('Sofía Navarro', 24, 'España', '67890123F');

-- MONTURAS
INSERT INTO mount (name, type) VALUES
('Relámpago', 'Caballo'),
('Tormenta', 'Caballo'),
('Pegaso', 'Caballo'),
('Titan', 'Mula'),
('Centella', 'Caballo'),
('Rayo', 'Burro');

-- ETAPAS
INSERT INTO stage (name, location, completed) VALUES
('Etapa Pirineos', 'Navarra', TRUE),
('Etapa Sierra Norte', 'Madrid', FALSE),
('Etapa Costa Mediterránea', 'Valencia', FALSE),
('Etapa Montaña Central', 'León', TRUE);

-- CORREDORES
INSERT INTO runner (
    id_person,
    id_mount,
    points,
    km,
    id_stage,
    passkey
) VALUES
(1,1,120,80,1,SHA2('runner123',256)),
(2,2,150,95,1,SHA2('lucia456',256)),
(3,3,100,60,2,SHA2('pierre789',256)),
(4,4,180,120,3,SHA2('anna321',256)),
(5,5,90,50,4,SHA2('marco654',256)),
(6,6,75,45,2,SHA2('sofia987',256));

-- PATROCINADORES
INSERT INTO sponsor (name) VALUES
('Decathlon'),
('Red Bull'),
('Salomon'),
('Garmin'),
('Adidas'),
('Nike');

-- REVISIONES MÉDICAS
INSERT INTO medical_check (
    runner_id,
    passed,
    notes
) VALUES
(1, TRUE, 'Estado físico excelente'),
(2, TRUE, 'Sin incidencias'),
(3, FALSE, 'Necesita revisión cardiovascular'),
(4, TRUE, 'Apto para competición'),
(5, TRUE, 'Pequeña lesión recuperada'),
(6, FALSE, 'Pendiente de análisis');

-- USUARIOS NORMALES
INSERT INTO user (
    username,
    passkey,
    role,
    runner_id
) VALUES
('carlosm', SHA2('Carlos123',256), 'user', 1),
('luciag', SHA2('Lucia123',256), 'user', 2),
('pierred', SHA2('Pierre123',256), 'user', 3),
('annas', SHA2('Anna123',256), 'user', 4),
('marcor', SHA2('Marco123',256), 'user', 5),
('sofian', SHA2('Sofia123',256), 'user', 6);