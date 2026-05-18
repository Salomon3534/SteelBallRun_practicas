USE sbr;

DROP PROCEDURE IF EXISTS genTestData;
DELIMITER //

CREATE PROCEDURE genTestData ()
BEGIN
    SET SQL_SAFE_UPDATES = 0;
    DELETE FROM runner;
    DELETE FROM mount;
    DELETE FROM person;
    DELETE FROM sponsor;
    
    ALTER TABLE mount AUTO_INCREMENT = 1;
    ALTER TABLE runner AUTO_INCREMENT = 1;
    ALTER TABLE sponsor AUTO_INCREMENT = 1;

	INSERT INTO sponsor (name) VALUES
    ('East and West Tribune'),
    ('B & C Meat Company'),
    ('Horizontal Continental Railway Company'),
	('Marlboro'),
    ('Speedwagon Oil Company');
    
    INSERT INTO person (id, name, surnames, age, dni) VALUES
    (1, 'Johnny', 'Joestar', 19, '12345678A'),
    (2, 'Gyro', 'Zeppeli', 24, '87654321B'),
    (3, 'Diego', 'Brando', 20, '11223344C'),
    (4, 'Pocoloco', NULL, 21, '55667788D'),
    (5, 'Sandman', NULL, 18, '99001122E'),
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
    (18, 'Mike', 'O', 35, '34343434O'),
    (19, 'Pork Pie', 'Hat Kid', 14, '56565656Q'),
    (20, 'Urmd', 'Avdol', 35, '78787878R');

    INSERT INTO mount (id, name, type) VALUES
    (1, 'Slow Dancer', 'Appaloosa'),
    (2, 'Valkyrie', 'Stock Horse'),
    (3, 'Silver Bullet', 'Arabian Thoroughbred'),
    (4, 'Hey! Ya!', 'Quarter Horse'),
    (5, 'Ghost Rider in the Sky', 'Mustang'),
    (6, 'Gets Up', 'Mustang'),
    (7, 'Hono', 'Bavarian Warmblood'),
    (8, '♯1', 'Boulonnais'),
    (9, 'El Condor Pasa', 'Appaloosa'),
    (10, 'Europe Express', 'Trakehner'),
    (11, 'Urmd\'s Camel', 'Camel'),
    (12, 'Foxy Lady', 'Quarter Horse'),
    (13, 'Crosstown Traffic', 'Quarter Horse'),
    (14, 'Little Wing', 'Quarter Horse'),
    (15, 'Peg', 'Criollo'),
    (16, 'Love Unlimited', 'Mustang'),
    (17, 'Natalie', 'Palomino'),
    (18, 'Roxanne', 'Arab'),
    (19, 'Moon Flower', 'Andalusian'),
    (20, 'Nut Rocker', 'Arab'),
    (21, 'Country Grammar', 'Quarter Horse'),
    (22, 'Catch a Wave', 'Quarter Horse'),
    (23, 'Ramblin\' Man', 'Pinto'),
    (24, 'Oyecomova\'s Horse', 'Horse'),
    (25, 'Kanye\'s Horse', 'Horse'),
    (26, 'Shigechi\'s Horse', 'Horse'),
    (27, 'Tarkus\'s Horse', 'Horse'),
    (28, 'Mack\'s Horse', 'Horse'),
    (29, 'Rotters\' Horse', 'Horse'),
    (30, 'Nightfly\'s Horse', 'Horse'),
    (31, 'Mister\'s Horse', 'Horse'),
    (32, 'Roocatugo\'s Horse', 'Horse'),
    (33, 'Becker\'s Horse', 'Horse'),
    (34, 'Hagen\'s Horse', 'Horse'),
    (35, 'Lukather\'s Horse', 'Horse'),
    (36, 'Georgy Porgy\'s Horse', 'Horse');

    INSERT INTO runner (id, name, surnames, age, nationality, mount_id, total_points) VALUES
    (1, 'Johnny', 'Joestar', 19, 'USA', 1, 80),
    (2, 'Gyro', 'Zeppeli', 24, 'Italy', 2, 36),
    (3, 'Diego', 'Brando', 20, 'UK', 3, 342),
    (4, 'Pocoloco', NULL, 21, 'USA', 4, 53),
    (5, 'Sandman', 'Soundman', 18, 'USA', NULL, 100),
    (6, 'Mountain', 'Tim', 31, 'USA', 5, 35),
    (7, 'Hot', 'Pants', 23, 'Italy', 6, 55),
    (8, 'Norisuke', 'Higashikata', 68, 'Japan', 7, 353),
    (9, 'Dot', 'Han', 25, 'Mongolia', 8, 21),
    (10, 'Mrs.', 'Robinson', 30, 'Mexico', 9, 0),
    (11, 'Fritz', 'von Stroheim', 28, 'Germany', 10, 20),
    (12, 'Urmd', 'Avdol', 35, 'Egypt', 11, 0),
    (13, 'Andre', 'Boomboom', 20, 'USA', 12, 0),
    (14, 'Benjamin', 'Boomboom', 45, 'USA', 13, 0),
    (15, 'L.A.', 'Boomboom', 18, 'USA', 14, 0),
    (16, 'Gaucho', NULL, 28, 'Mexico', 15, 17),
    (17, 'Billy', 'White', 24, 'USA', 16, 0),
    (18, 'Iglesias', NULL, 30, 'Spain', 17, 11),
    (19, 'Zenyatta', 'Mondatta', 27, 'India', 18, 30),
    (20, 'Caravan', 'Serai', 29, 'Egypt', 19, 0),
    (21, 'Baba', 'Yaga', 33, 'Russia', 20, 0),
    (22, 'Nellyville', NULL, 26, 'USA', 21, 0),
    (23, 'Sloop', 'John B', 25, 'USA', 22, 14),
    (24, 'Dixie', 'Chicken', 24, 'USA', 23, 15),
    (25, 'Oyecomova', NULL, 26, 'Italy', 24, 0),
    (26, 'Kanye', NULL, 28, 'USA', 25, 0),
    (27, 'Shigechi', NULL, 15, 'Japan', 26, 0),
    (28, 'Tarkus', NULL, 35, 'UK', 27, 0),
    (29, 'Mack', 'the Knife', 32, 'USA', 28, 0),
    (30, 'Rotters', 'Club', 29, 'UK', 29, 0),
    (31, 'Nightfly', NULL, 27, 'USA', 30, 0),
    (32, 'Mister', NULL, 31, 'USA', 31, 0),
    (33, 'Baron', 'Roocatugo', 42, 'Italy', 32, 0),
    (34, 'Mark', 'Becker', 26, 'Germany', 33, 0),
    (35, 'David', 'Hagen', 28, 'Germany', 34, 0),
    (36, 'Paul', 'Lukather', 30, 'USA', 35, 0),
    (37, 'Georgy', 'Porgy', 25, 'UK', 36, 0);
    
    SET SQL_SAFE_UPDATES = 1;
END //
DELIMITER ;