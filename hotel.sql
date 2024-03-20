DROP DATABASE IF EXISTS hotel;
CREATE DATABASE hotel;
USE hotel;

CREATE TABLE hotel.room_types(
	id INT AUTO_INCREMENT PRIMARY KEY ,
	type VARCHAR(255) NOT NULL
)Engine = InnoDB;

CREATE TABLE hotel.guest_types(
	id INT AUTO_INCREMENT PRIMARY KEY ,
	type VARCHAR(255) NOT NULL
)Engine = InnoDB;

CREATE TABLE hotel.staff_types(
	id INT AUTO_INCREMENT PRIMARY KEY ,
	type VARCHAR(255) NOT NULL
)Engine = InnoDB;

CREATE TABLE hotel.payment_types(
	id INT AUTO_INCREMENT PRIMARY KEY ,
	type VARCHAR(255) NOT NULL
)Engine = InnoDB;

CREATE TABLE hotel.rooms(
	id INT AUTO_INCREMENT PRIMARY KEY ,
	number INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL CONSTRAINT priceCantBeNegative CHECK(price >=0),
    number_of_beds INT NOT NULL,
    sight VARCHAR(255) NOT NULL,
    isOccupied BOOLEAN NOT NULL DEFAULT 0,
    type_id INT NOT NULL,
	CONSTRAINT FOREIGN KEY (type_id) 
		REFERENCES room_types(id)
)Engine = InnoDB;

CREATE TABLE hotel.images(
	id INT AUTO_INCREMENT PRIMARY KEY ,
	url VARCHAR(255) NOT NULL,
    room_id INT NOT NULL,
	CONSTRAINT FOREIGN KEY (room_id) 
		REFERENCES rooms(id)
)Engine = InnoDB;

CREATE TABLE hotel.guests(
	id INT AUTO_INCREMENT PRIMARY KEY ,
	name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL,
    egn VARCHAR(10) NOT NULL UNIQUE CONSTRAINT guestsEGNcantBeNegative CHECK(CHAR_LENGTH(egn) = 10),
    address VARCHAR(255) NOT NULL,
    type_id INT NOT NULL,
	CONSTRAINT FOREIGN KEY (type_id) 
		REFERENCES guest_types(id)
)Engine = InnoDB;

CREATE TABLE hotel.staff(
	id INT AUTO_INCREMENT PRIMARY KEY ,
	name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL,
    egn VARCHAR(10) NOT NULL UNIQUE CONSTRAINT staffEGNcantBeNegative CHECK(CHAR_LENGTH(egn) = 10),
    address VARCHAR(255) NOT NULL,
    type_id INT NOT NULL,
	CONSTRAINT FOREIGN KEY (type_id) 
		REFERENCES staff_types(id)
)Engine = InnoDB;

CREATE TABLE hotel.bookings(
	id INT AUTO_INCREMENT PRIMARY KEY ,
	checkin DATE NOT NULL,
    checkout DATE NOT NULL,
	price DECIMAL(10, 2) CONSTRAINT bookingPriceCantBeNegative CHECK(price >=0),
    isConfurmed BOOLEAN NOT NULL DEFAULT 0,
    guest_id INT NOT NULL,
	CONSTRAINT FOREIGN KEY (guest_id) 
		REFERENCES guests(id)
)Engine = InnoDB;

CREATE TABLE hotel.payments(
	id INT AUTO_INCREMENT PRIMARY KEY ,
    amount DECIMAL(10, 2) CONSTRAINT amountCantBeNegative CHECK(amount >=0),
    date DATE NOT NULL,
    year YEAR NOT NULL,
    booking_id INT NOT NULL,
    guest_id INT NOT NULL,
    type_id INT NOT NULL,
	CONSTRAINT FOREIGN KEY (booking_id) 
		REFERENCES bookings(id),
	CONSTRAINT FOREIGN KEY (guest_id) 
		REFERENCES guests(id),
	CONSTRAINT FOREIGN KEY (type_id) 
		REFERENCES payment_types(id)
)Engine = InnoDB;

CREATE TABLE hotel.reviews(
	id INT AUTO_INCREMENT PRIMARY KEY ,
	rating TINYINT NOT NULL,
    review TEXT NOT NULL,
    guest_id INT NOT NULL,
	CONSTRAINT FOREIGN KEY (guest_id) 
		REFERENCES guests(id)
)Engine = InnoDB;

CREATE TABLE hotel.room_booking(
booking_id INT NOT NULL,
room_id INT NOT NULL,
	CONSTRAINT FOREIGN KEY (room_id) 
		REFERENCES rooms(id),
	CONSTRAINT FOREIGN KEY (booking_id) 
		REFERENCES bookings(id),
		PRIMARY KEY(booking_id, room_id)
)Engine = InnoDB;

CREATE TABLE hotel.booking_staff(
booking_id INT NOT NULL,
staff_id INT NOT NULL,
	CONSTRAINT FOREIGN KEY (staff_id) 
		REFERENCES staff(id),
	CONSTRAINT FOREIGN KEY (booking_id) 
		REFERENCES bookings(id),
	PRIMARY KEY(booking_id, staff_id)
)Engine = InnoDB;

CREATE TABLE payments_log(
id INT AUTO_INCREMENT PRIMARY KEY,
operation ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
old_amount DECIMAL,
new_amount DECIMAL,
old_date DATE,
new_date DATE,
old_year YEAR,
new_year YEAR,
old_booking_id INT,
new_booking_id INT,
old_guest_id INT,
new_guest_id INT,
old_type_id INT,
new_type_id INT,
dateOfLog DATETIME
)Engine = InnoDB;

INSERT INTO room_types
VALUES 	(NULL, 'single') ,
		(NULL, 'twin') ,
		(NULL, 'studio') ,
		(NULL, 'deluxe') ,
        (NULL, 'suit') ,
		(NULL, 'presidential suit');
        
INSERT INTO staff_types
VALUES 	(NULL, 'housekeeper') ,
		(NULL, 'server') ,
		(NULL, 'receptionist') ,
		(NULL, 'portier');
        
INSERT INTO guest_types
VALUES 	(NULL, 'present') ,
		(NULL, 'past');
        
INSERT INTO payment_types
VALUES 	(NULL, 'cash') ,
		(NULL, 'card');
        
INSERT INTO rooms
VALUES (NULL, '101','59.99', '1' , 'land view', '0', '1'),
	   (NULL, '102','89.99', '2' , 'city view', '0', '2'),
       (NULL, '103','99.99', '3' , 'garden view', '0', '3'),
       (NULL, '104','129.99', '2' , 'land view', '0', '4'),
       (NULL, '105','149.99', '4' , 'land view', '0', '5'),
       (NULL, '106','79.99', '1' , 'city view', '0', '1'),
       (NULL, '107','99.99', '2' , 'city view', '0', '2'),
       (NULL, '108','79.99', '3' , 'land view', '0', '3'),
       (NULL, '109','109.99', '2' , 'garden view', '0', '4'),
       (NULL, '201','139.99', '4' , 'garden view', '0', '5'),
       (NULL, '202','79.99', '1' , 'garden view', '0', '1'),
       (NULL, '203','99.99', '2' , 'city view', '0', '2'),
       (NULL, '204','89.99', '3' , 'land view', '0', '3'),
       (NULL, '205','119.99', '2' , 'city view', '0', '4'),
       (NULL, '206','129.99', '4' , 'city view', '0', '5'),
       (NULL, '207','99.99', '1' , 'city view', '0', '1'),
       (NULL, '208','79.99', '2' , 'land view', '0', '2'),
       (NULL, '209','109.99', '3' , 'garden view', '0', '3'),
       (NULL, '301','99.99', '2' , 'land view', '0', '4'),
       (NULL, '302','179.99', '4' , 'land view', '0', '5'),
       (NULL, '303','59.99', '1' , 'land view', '0', '1'),
       (NULL, '304','89.99', '2' , 'garden view', '0', '2'),
       (NULL, '305','119.99', '3' , 'city view', '0', '3'),
       (NULL, '306','109.99', '2' , 'land view', '0', '4'),
       (NULL, '307','139.99', '4' , 'land view', '0', '5'),
       (NULL, '308','339.99', '2' , 'garden view', '0', '6'),
       (NULL, '309','399.99', '2' , 'city view', '0', '6');
       
INSERT INTO images
VALUES 	(NULL, 'https://www.agoda.com/l-hotel/hotel/khon-kaen-th.html?cid=1844104', '1') ,
		(NULL, 'https://www.agoda.com/l-hotel/hotel/khon-kaen-th.html?cid=1844105', '2') ,
		(NULL, 'https://www.agoda.com/l-hotel/hotel/khon-kaen-th.html?cid=1844114', '3') ,
		(NULL, 'https://www.agoda.com/l-hotel/hotel/khon-kaen-th.html?cid=1844448', '4') ,
        (NULL, 'https://www.agoda.com/l-hotel/hotel/khon-kaen-th.html?cid=1844155', '5') ,
        (NULL, 'https://www.agoda.com/l-hotel/hotel/khon-kaen-th.html?cid=1844104', '6') ,
		(NULL, 'https://www.agoda.com/l-hotel/hotel/khon-kaen-th.html?cid=1844185', '7') ,
		(NULL, 'https://www.agoda.com/l-hotel/hotel/khon-kaen-th.html?cid=1844456', '8') ,
		(NULL, 'https://www.agoda.com/l-hotel/hotel/khon-kaen-th.html?cid=1844415', '9') ,
        (NULL, 'https://www.agoda.com/l-hotel/hotel/khon-kaen-th.html?cid=1844369', '10') ,
		(NULL, 'https://www.agoda.com/l-hotel/hotel/khon-kaen-th.html?cid=1844104', '11'),
        (NULL, 'https://www.agoda.com/l-hotel/hotel/khon-kaen-th.html?cid=1844100', '12') ,
		(NULL, 'https://www.agoda.com/l-hotel/hotel/khon-kaen-th.html?cid=1844100', '13') ,
		(NULL, 'https://www.agoda.com/l-hotel/hotel/khon-kaen-th.html?cid=1844109', '14') ,
		(NULL, 'https://www.agoda.com/l-hotel/hotel/khon-kaen-th.html?cid=1844107', '15') ,
        (NULL, 'https://www.agoda.com/l-hotel/hotel/khon-kaen-th.html?cid=1844105', '16') ,
		(NULL, 'https://www.agoda.com/l-hotel/hotel/khon-kaen-th.html?cid=1844178', '17') ,
        (NULL, 'https://www.agoda.com/l-hotel/hotel/khon-kaen-th.html?cid=1844106', '18') ,
		(NULL, 'https://www.agoda.com/l-hotel/hotel/khon-kaen-th.html?cid=1844104', '19') ,
		(NULL, 'https://www.agoda.com/l-hotel/hotel/khon-kaen-th.html?cid=1844107', '20') ,
		(NULL, 'https://www.agoda.com/l-hotel/hotel/khon-kaen-th.html?cid=1844104', '21') ,
        (NULL, 'https://www.agoda.com/l-hotel/hotel/khon-kaen-th.html?cid=1844109', '22') ,
		(NULL, 'https://www.agoda.com/l-hotel/hotel/khon-kaen-th.html?cid=1844105', '23') ,
        (NULL, 'https://www.agoda.com/l-hotel/hotel/khon-kaen-th.html?cid=1844107', '24') ,
		(NULL, 'https://www.agoda.com/l-hotel/hotel/khon-kaen-th.html?cid=1844148', '25') ,
		(NULL, 'https://www.agoda.com/l-hotel/hotel/khon-kaen-th.html?cid=1844108', '26') ,
		(NULL, 'https://www.agoda.com/l-hotel/hotel/khon-kaen-th.html?cid=1844128', '27');
        
INSERT INTO guests
VALUES  (NULL, 'Maria Viktorova','maria@gmail.com', '0898565565' , '8012035696', 'Sofia-Mladost 1', '1'),
		(NULL, 'Nikol Dimitrova','nikol@gmail.com', '0878585565' , '9905052665', 'Sofia-Mladost 2', '1'),
        (NULL, 'Maya Stoyanova','maya@gmail.com', '0845784487' , '0044548999', 'Sofia-Mladost 1', '1'),
        (NULL, 'Lily Georgieva','lily@gmail.com', '0888256451' , '9812125566', 'Sofia-Mladost 2', '1'),
        (NULL, 'Ivan Ivanov','ivan@gmail.com', '0899454722' , '6611102558', 'Sofia-Mladost 3', '1'),
        (NULL, 'Georgi Todorov','georgi@gmail.com', '0896541141' , '7704145522', 'Sofia-Mladost 4', '2'),
        (NULL, 'Dimo Dimitrov','dimo@gmail.com', '0878545545' , '9602030011', 'Sofia-Mladost 3', '2'),
        (NULL, 'Desislava Styoyanova','desislava@gmail.com', '0887323333' , '7914456336', 'Sofia-Mladost 4', '2'),
        (NULL, 'Gabriela Viktorova','gabriela@gmail.com', '0888525332' , '8502015566', 'Sofia-Liylin 7', '2'),
        (NULL, 'Martin Ivanov','martin@gmail.com', '0886323111' , '7908085414', 'Sofia-Liylin 7', '2'),
        (NULL, 'Elena Petrova','elena@gmail.com', '0899451154' , '0245124545', 'Sofia-Liylin 5', '2'),
        (NULL, 'Viktoria Marinova','viktoria@gmail.com', '0887363333' , '9512124547', 'Sofia-Liylin 5', '2'),
        (NULL, 'Petur Dimitrov','petur@gmail.com', '0899444333' , '9906065458', 'Sofia-Mladost 1', '2'),
        (NULL, 'Georgi Georgiev','georgi@gmail.com', '0877333258' , '7704011232', 'Sofia-Mladost 1', '2'),
        (NULL, 'Lyubomir Stoyanov','lybo@gmail.com', '0899555444' , '9806098899', 'Blagoevgrad', '2'),
        (NULL, 'Kristina Stoyanova','kristina@gmail.com', '0877454444' , '9606035454', 'Plovdiv', '2'),
        (NULL, 'Tanya Ivanova','tanya@gmail.com', '0888222159' , '9707085599', 'Blagoevgrad', '2'),
        (NULL, 'Vasil Vasilev','vasil@gmail.com', '0888544463' , '9903063322', 'Plovdiv', '2'),
        (NULL, 'Georgi Todorov','georgi@gmail.com', '0888544474' , '7702022552', 'Sofia-Liylin 3', '2'),
        (NULL, 'Ivo Ivanov','ivo@gmail.com', '0877777666' , '0043035665', 'Sofia-Liylin 6', '2');
        
INSERT INTO bookings
VALUES  (NULL, '2023-01-10', '2023-01-13', '299.97', '1', '6'),
		(NULL, '2023-01-13', '2023-01-16', '359.97', '1', '7'),
        (NULL, '2023-01-13', '2023-01-19', '299.97', '1', '8'),
        (NULL, '2023-01-05', '2023-01-08', '269.97', '1', '9'),
        (NULL, '2023-01-08', '2023-01-11', '449.97', '1', '10'),
        (NULL, '2023-02-01', '2023-02-03', '239.97', '1', '11'),
        (NULL, '2023-02-03', '2023-02-06', '539.97', '1', '12'),
        (NULL, '2023-02-06', '2023-02-09', '299.97', '1', '13'),
        (NULL, '2023-02-09', '2023-02-12', '299.97', '1', '14'),
        (NULL, '2023-02-12', '2023-02-15', '329.97', '1', '15'),
        (NULL, '2023-02-15', '2023-02-18', '389.97', '1', '16'),
        (NULL, '2023-02-18', '2023-02-21', '329.97', '1', '17'),
        (NULL, '2023-03-02', '2023-03-05', '299.97', '1', '18'),
        (NULL, '2023-03-10', '2023-03-13', '389.97', '1', '19'),
        (NULL, '2023-03-12', '2023-03-15', '239.97', '1', '20'),
        (NULL, '2023-03-16', '2023-03-19', '449.97', '1', '6'),
        (NULL, '2023-04-05', '2023-04-08', '299.97', '1', '7'),
        (NULL, '2023-01-09', '2022-01-12', '239.97', '1', '8'),
        (NULL, '2023-04-20', '2023-04-23', '299.97', '1', '9'),
        (NULL, '2023-04-25', '2023-04-28', '189.99', '1', '10');

INSERT INTO payments
VALUES  (NULL, '299.97', '2023-01-10', '2023', '1', '6','1'),
		(NULL, '359.97', '2023-01-14', '2023', '2', '7','2'),
        (NULL, '299.97', '2023-01-10', '2023', '3', '8','1'),
        (NULL, '269.97', '2023-01-03', '2023', '4', '1','2'),
        (NULL, '449.97', '2023-01-10', '2023', '5', '10','1'),
        (NULL, '239.97', '2023-02-01', '2023', '6', '11','2'),
        (NULL, '539.97', '2023-02-02', '2023', '7', '12','1'),
        (NULL, '299.97', '2023-02-02', '2023', '8', '13','2'),
        (NULL, '299.97', '2023-02-01', '2023', '9', '14','1'),
        (NULL, '329.97', '2023-02-01', '2023', '10', '15','2'),
        (NULL, '389.97', '2023-02-03', '2023', '11', '16','1'),
        (NULL, '329.97', '2023-02-15', '2023', '12', '17','2'),
        (NULL, '299.97', '2023-03-03', '2023', '13', '18','1'),
        (NULL, '389.97', '2023-03-01', '2023', '14', '19','2'),
        (NULL, '239.97', '2023-03-10', '2023', '15', '20','1'),
        (NULL, '449.97', '2023-03-15', '2023', '16', '6','2'),
        (NULL, '299.97', '2023-04-06', '2023', '17', '18','1'),
        (NULL, '239.97', '2022-04-06', '2023', '18', '3','2'),
        (NULL, '299.97', '2023-04-02', '2023', '19', '1','1'),
        (NULL, '189.99', '2023-04-03', '2023', '20', '10','2');
        
INSERT INTO room_booking
VALUES  ('1', '16'),
		('2', '14'),
        ('3', '15'),
        ('4', '2'),
        ('5', '6'),
        ('6', '17'),
        ('7', '20'),
        ('8', '1'),
        ('9', '7'),
        ('10', '18'),
        ('11', '4'),
        ('12', '9'),
        ('13', '12'),
        ('14', '13'),
        ('15', '8'),
        ('16', '5'),
        ('17', '19'),
        ('18', '11'),
        ('19', '3'),
        ('20', '10');

INSERT INTO staff
VALUES  (NULL, 'Velislava Viktorova','veli@gmail.com', '0888123456' , '8012038596', 'Sofia-Mladost 1', '1'),
		(NULL, 'Rositsa Dimitrova','rosi@gmail.com', '0899123456' , '9905059665', 'Sofia-Mladost 2', '1'),
        (NULL, 'Dayana Stoyanova','dayana@gmail.com', '0877123456' , '0044548599', 'Sofia-Mladost 1', '1'),
        (NULL, 'Elena Georgieva','elena@gmail.com', '0885123456' , '9812126566', 'Sofia-Mladost 2', '1'),
        (NULL, 'Maria Ivanova','maria@gmail.com', '0898123456' , '6611102448', 'Sofia-Mladost 3', '1'),
        (NULL, 'Angel Todorov','angel@gmail.com', '0875123456' , '7704145742', 'Sofia-Mladost 4', '2'),
        (NULL, 'Nikolay Dimitrov','niki@gmail.com', '0882123456' , '9602032211', 'Sofia-Mladost 3', '2'),
        (NULL, 'Emily Styoyanova','emily@gmail.com', '0896123456' , '7914456416', 'Sofia-Mladost 4', '2'),
        (NULL, 'Valentin Viktorov','valentin@gmail.com', '0878123456' , '8502019366', 'Sofia-Liylin 7', '2'),
        (NULL, 'Iliya Ivanov','iliya@gmail.com', '0886123456' , '7908081214', 'Sofia-Liylin 7', '2'),
        (NULL, 'Maria Marinova','maria@gmail.com', '0892123456' , '0245124005', 'Sofia-Liylin 5', '3'),
        (NULL, 'Elena Marinova','elena@gmail.com', '0876123456' , '9512124417', 'Sofia-Liylin 5', '3'),
        (NULL, 'Ivana Dimitrova','ivana@gmail.com', '0884123456' , '9906064158', 'Sofia-Mladost 1', '3'),
        (NULL, 'Nadya Georgieva','nadya@gmail.com', '0895123456' , '7704013232', 'Sofia-Mladost 1', '3'),
        (NULL, 'Stefan Stoyanov','stefan@gmail.com', '0874123456' , '9806094899', 'Blagoevgrad', '3'),
        (NULL, 'Tanya Stoyanova','tanya@gmail.com', '0881123456' , '9606034554', 'Plovdiv', '4'),
        (NULL, 'Petya Ivanova','petya@gmail.com', '0893123456' , '9707088899', 'Blagoevgrad', '4'),
        (NULL, 'Miroslav Vasilev','miroslav@gmail.com', '0872123456' , '9903064522', 'Plovdiv', '4'),
        (NULL, 'Anna Todorova','anna@gmail.com', '0883123456' , '7702024552', 'Sofia-Liylin 3', '4'),
        (NULL, 'Radoslav Ivanov','radi@gmail.com', '0890123456' , '0043035325', 'Sofia-Liylin 6', '4');
        
INSERT INTO booking_staff
VALUES  ('1', '1'),
		('2', '2'),
        ('3', '3'),
        ('4', '4'),
        ('5', '5'),
        ('6', '1'),
        ('7', '2'),
        ('8', '3'),
        ('9', '4'),
        ('10', '5'),
        ('11', '1'),
        ('12', '2'),
        ('13', '3'),
        ('14', '4'),
        ('15', '5'),
        ('16', '1'),
        ('17', '2'),
        ('18', '3'),
        ('19', '4'),
        ('20', '5'),
        ('1', '6'),
		('2', '7'),
        ('3', '8'),
        ('4', '9'),
        ('5', '10'),
        ('6', '6'),
        ('7', '7'),
        ('8', '8'),
        ('9', '9'),
        ('10', '10'),
        ('11', '6'),
        ('12', '7'),
        ('13', '8'),
        ('14', '9'),
        ('15', '10'),
        ('16', '6'),
        ('17', '7'),
        ('18', '8'),
        ('19', '9'),
        ('20', '10'),
        ('1', '11'),
		('2', '12'),
        ('3', '13'),
        ('4', '14'),
        ('5', '15'),
        ('6', '11'),
        ('7', '12'),
        ('8', '13'),
        ('9', '14'),
        ('10', '15'),
        ('11', '11'),
        ('12', '12'),
        ('13', '13'),
        ('14', '14'),
        ('15', '15'),
        ('16', '11'),
        ('17', '12'),
        ('18', '13'),
        ('19', '14'),
        ('20', '15'),
        ('1', '16'),
		('2', '17'),
        ('3', '18'),
        ('4', '19'),
        ('5', '20'),
        ('6', '16'),
        ('7', '17'),
        ('8', '18'),
        ('9', '19'),
        ('10', '20'),
        ('11', '16'),
        ('12', '17'),
        ('13', '18'),
        ('14', '19'),
        ('15', '20'),
        ('16', '16'),
        ('17', '17'),
        ('18', '18'),
        ('19', '19'),
        ('20', '20');
        
INSERT INTO reviews
		VALUES 	(NULL,'5', 'Прекрасен хотел! Настанахме се в страхотна стая,
която беше изключително чиста и удобна. Обслужването от персонала беше отлично,
винаги бяха на разположение за всякакви нужди.
Имахме вкусна закуска и вечеря в ресторанта на място. С удоволствие бихме се върнали!', '1') ,
		(NULL,'5', 'Несъмнено един от най-добрите хотели, в които съм
бил! Изключително чисти стаи с прекрасна гледка към морето.
Ресторантът на хотела предлага богат избор от ястия и напитки,
а обслужването е отлично. Препоръчвам го на всички, които търсят качество и комфорт!', '2') ,
		(NULL,'5','Много добър хотел с отлично местоположение! Стаите бяха чисти и удобни,
а персоналът беше много любезен и отзивчив. Имахме чудесна закуска в ресторанта и
удоволствие наблюдавахме красивата гледка от терасата.
С удоволствие бихме се върнали отново!', '3') ,
		(NULL,'5', 'Препоръчвам този хотел на всички, които искат да посетят това място.
Стаите бяха много чисти и удобни, а персоналът беше много любезен и отзивчив.
Имахме прекрасна закуска и вечеря в ресторанта на място, където обслужването беше отлично.
Бихме се върнали отново!', '4') ,
        (NULL,'5', 'Много хубав хотел с прекрасна гледка! Стаите бяха чисти и удобни,
а персоналът беше много любезен и отзивчив. Ресторантът на място предлага вкусна храна,
а обслужването беше отлично. Препоръчвам го на всички, които искат да се почувстват като у дома си!', '5') ,
		(NULL,'5', 'Прекрасен хотел! Настанахме се в страхотна стая,
която беше изключително чиста и удобна. Обслужването от персонала беше отлично,
винаги бяха на разположение за всякакви нужди.
Имахме вкусна закуска и вечеря в ресторанта на място. С удоволствие бихме се върнали!', '6') ,
		(NULL,'5', 'Несъмнено един от най-добрите хотели, в които съм
бил! Изключително чисти стаи с прекрасна гледка към морето.
Ресторантът на хотела предлага богат избор от ястия и напитки,
а обслужването е отлично. Препоръчвам го на всички, които търсят качество и комфорт!', '7') ,
		(NULL,'5','Много добър хотел с отлично местоположение! Стаите бяха чисти и удобни,
а персоналът беше много любезен и отзивчив. Имахме чудесна закуска в ресторанта и
удоволствие наблюдавахме красивата гледка от терасата.
С удоволствие бихме се върнали отново!', '8') ,
		(NULL,'5', 'Препоръчвам този хотел на всички, които искат да посетят това място.
Стаите бяха много чисти и удобни, а персоналът беше много любезен и отзивчив.
Имахме прекрасна закуска и вечеря в ресторанта на място, където обслужването беше отлично.
Бихме се върнали отново!', '9') ,
        (NULL,'5', 'Много хубав хотел с прекрасна гледка! Стаите бяха чисти и удобни,
а персоналът беше много любезен и отзивчив. Ресторантът на място предлага вкусна храна,
а обслужването беше отлично. Препоръчвам го на всички, които искат да се почувстват като у дома си!', '10') ,
		(NULL,'5', 'Прекрасен хотел! Настанахме се в страхотна стая,
която беше изключително чиста и удобна. Обслужването от персонала беше отлично,
винаги бяха на разположение за всякакви нужди.
Имахме вкусна закуска и вечеря в ресторанта на място. С удоволствие бихме се върнали!', '11') ,
		(NULL,'5', 'Несъмнено един от най-добрите хотели, в които съм
бил! Изключително чисти стаи с прекрасна гледка към морето.
Ресторантът на хотела предлага богат избор от ястия и напитки,
а обслужването е отлично. Препоръчвам го на всички, които търсят качество и комфорт!', '12') ,
		(NULL,'5','Много добър хотел с отлично местоположение! Стаите бяха чисти и удобни,
а персоналът беше много любезен и отзивчив. Имахме чудесна закуска в ресторанта и 
удоволствие наблюдавахме красивата гледка от терасата.
С удоволствие бихме се върнали отново!', '13') ,
		(NULL,'5', 'Препоръчвам този хотел на всички, които искат да посетят това място.
Стаите бяха много чисти и удобни, а персоналът беше много любезен и отзивчив.
Имахме прекрасна закуска и вечеря в ресторанта на място, където обслужването беше отлично.
Бихме се върнали отново!', '14') ,
        (NULL,'5', 'Много хубав хотел с прекрасна гледка! Стаите бяха чисти и удобни,
а персоналът беше много любезен и отзивчив. Ресторантът на място предлага вкусна храна,
а обслужването беше отлично. Препоръчвам го на всички, които искат да се почувстват като у дома си!', '15') ,
        (NULL,'5', 'Прекрасен хотел! Настанахме се в страхотна стая,
която беше изключително чиста и удобна. Обслужването от персонала беше отлично,
винаги бяха на разположение за всякакви нужди.
Имахме вкусна закуска и вечеря в ресторанта на място. С удоволствие бихме се върнали!', '16') ,
		(NULL,'5', 'Несъмнено един от най-добрите хотели, в които съм
бил! Изключително чисти стаи с прекрасна гледка към морето.
Ресторантът на хотела предлага богат избор от ястия и напитки,
а обслужването е отлично. Препоръчвам го на всички, които търсят качество и комфорт!', '17') ,
		(NULL,'5','Много добър хотел с отлично местоположение! Стаите бяха чисти и удобни,
а персоналът беше много любезен и отзивчив. Имахме чудесна закуска в ресторанта и
удоволствие наблюдавахме красивата гледка от терасата.
С удоволствие бихме се върнали отново!', '18') ,
		(NULL,'5', 'Препоръчвам този хотел на всички, които искат да посетят това място.
Стаите бяха много чисти и удобни, а персоналът беше много любезен и отзивчив.
Имахме прекрасна закуска и вечеря в ресторанта на място, където обслужването беше отлично.
Бихме се върнали отново!', '19') ,
        (NULL,'5', 'Много хубав хотел с прекрасна гледка! Стаите бяха чисти и удобни,
а персоналът беше много любезен и отзивчив. Ресторантът на място предлага вкусна храна,
а обслужването беше отлично. Препоръчвам го на всички, които искат да се почувстват като у дома си!', '20') ;