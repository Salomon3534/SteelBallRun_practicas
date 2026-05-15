USE sbr;

DROP PROCEDURE IF EXISTS genTestData;
DELIMITER //
CREATE PROCEDURE genTestData ()
BEGIN
    DECLARE counter INT DEFAULT 1;

    -- Inserción de datos fijos en la tabla person
    INSERT INTO person (id, name, surnames, age, dni) VALUES
    (1, 'Johnny', 'Joestar', 19, '12345678A'),
    (2, 'Gyro', 'Zeppeli', 24, '87654321B'),
    (3, 'Diego', 'Brando', 20, '11223344C'),
    (4, 'Pocoloco', NULL, 21, '55667788D'),
    (5, 'Sandman', 'Soundman', 18, '99001122E'),
    (6, 'Mountain', 'Tim', 38, '33445566F'),
    (7, 'Hot', 'Pants', 23, '77889900G'),
    (8, 'Wekapipo', NULL, 31, '44556677H'),
    (9, 'Funny', 'Valentine', 48, '00000001P'),
    (10, 'Lucy', 'Steel', 14, '99999999Z'),
    (11, 'Steven', 'Steel', 51, '88888888X'),
    (12, 'Blackmore', NULL, 30, '20202020L'),
    (13, 'Ringo', 'Roadagain', 33, '10101010K'),
    (14, 'Magent', 'Magent', 24, '66778899I'),
    (15, 'Dot', 'Han', 25, '22334455J'),
    (16, 'Oyecomova', NULL, 26, '55443322M'),
    (17, 'Axl', 'RO', 25, '12121212N'),
    (18, 'Mike', 'O.', 35, '34343434O'),
    (19, 'Pork Pie', 'Hat Kid', 14, '56565656Q'),
    (20, 'Urmd', 'Avdol', 35, '78787878R');

    -- Generación masiva de 300 monturas
    WHILE counter <= 300 DO
        INSERT INTO mount (name, type) VALUES (
            CONCAT('Horse_', counter),
            ELT(FLOOR(1 + (RAND() * 3)), 'Horse', 'Camello', 'Valkyrie')
        );
        SET counter = counter + 1;
    END WHILE;

    -- Restablecer el contador para los corredores
    SET counter = 1;

    -- Generación masiva de 300 corredores
    WHILE counter <= 300 DO
        INSERT INTO runner (id, name, surnames, age, nationality, mount_id, current_place, total_points) VALUES (
            counter,
            CONCAT('Runner_', counter),
            CONCAT('Surname_', counter),
            FLOOR(18 + (RAND() * 40)),
            ELT(FLOOR(1 + (RAND() * 5)), 'USA', 'UK', 'Italy', 'Japan', 'Spain'),
            counter, -- Relación uno a uno simulada con mount_id
            counter,
            FLOOR(RAND() * 100)
        );
        SET counter = counter + 1;
    END WHILE;

    -- Verificación de datos insertados
    SELECT COUNT(*) AS total_persons FROM person;
    SELECT COUNT(*) AS total_mounts FROM mount;
    SELECT COUNT(*) AS total_runners FROM runner;
END //
DELIMITER ;