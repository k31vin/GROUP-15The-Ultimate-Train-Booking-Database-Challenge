CREATE database TrainBooking;
USE TrainBooking;

-- Table: Users
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(15),
    password VARCHAR(255) NOT NULL
);


-- Table: Passenger
CREATE TABLE Passenger (
    passenger_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    age INT,
    gender ENUM('Male', 'Female', 'Other'),
    contact VARCHAR(150),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Table: Train
CREATE TABLE Train (
    train_id INT PRIMARY KEY AUTO_INCREMENT,
    train_name VARCHAR(100) NOT NULL,
    train_type ENUM('Express', 'Local', 'Freight') NOT NULL,
    total_seats INT NOT NULL
);

-- Table: TrainSchedule
CREATE TABLE TrainSchedule (
    schedule_id INT PRIMARY KEY AUTO_INCREMENT,
    train_id INT NOT NULL,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    source VARCHAR(100) NOT NULL,
    destination VARCHAR(100) NOT NULL,
    available_seats INT NOT NULL,
    FOREIGN KEY (train_id) REFERENCES Train(train_id)
);

-- Table: FareDetails
CREATE TABLE FareDetails (
    fare_id INT PRIMARY KEY AUTO_INCREMENT,
    schedule_id INT NOT NULL,
    base_fare DECIMAL(10, 2) NOT NULL,
    class_type ENUM('Sleeper', 'AC', 'FirstClass', 'SecondClass') NOT NULL,
    tax_rate DECIMAL(5, 2) NOT NULL,
    FOREIGN KEY (schedule_id) REFERENCES TrainSchedule(schedule_id)
);

-- Table: Booking
CREATE TABLE Booking (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    passenger_id INT NOT NULL,
    schedule_id INT NOT NULL,
    booking_date DATETIME NOT NULL,
    status ENUM('Confirmed', 'Pending', 'Cancelled') NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (passenger_id) REFERENCES Passenger(passenger_id),
    FOREIGN KEY (schedule_id) REFERENCES TrainSchedule(schedule_id)
);

-- Table: PNRDetails
CREATE TABLE PNRDetails (
    pnr_number VARCHAR(20) PRIMARY KEY,
    booking_id INT NOT NULL,
    seat_number VARCHAR(10),
    booking_status ENUM('Confirmed', 'RAC', 'Waiting List') NOT NULL,
    journey_date DATETIME NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

-- Table: Payment
CREATE TABLE Payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date DATETIME NOT NULL,
    payment_status ENUM('Success', 'Failed') NOT NULL,
    payment_method ENUM('Online', 'Offline') NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

-- Table: RefundRules
CREATE TABLE RefundRules (
    rule_id INT PRIMARY KEY AUTO_INCREMENT,
    cancellation_window VARCHAR(50) NOT NULL,
    refund_percentage DECIMAL(5, 2) NOT NULL,
    conditions TEXT
);

-- Table: Refunds
CREATE TABLE Refunds (
    refund_id INT PRIMARY KEY AUTO_INCREMENT,
    pnr_number VARCHAR(20) NOT NULL,
    rule_id INT NOT NULL,
    refund_amount DECIMAL(10, 2) NOT NULL,
    refund_date DATETIME NOT NULL,
    status ENUM('Pending', 'Approved', 'Rejected') NOT NULL,
    FOREIGN KEY (pnr_number) REFERENCES PNRDetails(pnr_number),
    FOREIGN KEY (rule_id) REFERENCES RefundRules(rule_id)
);
-- Insert into Users
INSERT INTO Users (name, email, phone, password) VALUES
('Ben Hulio', 'ben.hulio@example.com', '1234567890', 'password123'),
('Jane Smith', 'jane.smith@example.com', '0987654321', 'securepass'),
('Alex Johnson', 'alex.j@example.com', '1122334455', 'alexpass'),
('Emily Davis', 'emily.d@example.com', '1212121212', 'emily123'),
('Michael Brown', 'michael.b@example.com', '2323232323', 'mikepass'),
('Sarah Wilson', 'sarah.w@example.com', '3434343434', 'sarah2023'),
('Chris Lee', 'chris.l@example.com', '4545454545', 'chris2023'),
('Anna Walker', 'anna.w@example.com', '5656565656', 'annapass'),
('David Taylor', 'david.t@example.com', '6767676767', 'davidpass'),
('Sophia Martinez', 'sophia.m@example.com', '7878787878', 'sophia123');

-- Insert into Passenger
INSERT INTO Passenger (user_id, name, age, gender, contact) VALUES
(1, 'Ben Hulio', 30, 'Male', '1234567890'),
(2, 'Jane Smith', 28, 'Female', '0987654321'),
(3, 'Alex Johnson', 35, 'Other', '1122334455'),
(4, 'Emily Davis', 25, 'Female', '1212121212'),
(5, 'Michael Brown', 40, 'Male', '2323232323'),
(6, 'Sarah Wilson', 29, 'Female', '3434343434'),
(7, 'Chris Lee', 33, 'Male', '4545454545'),
(8, 'Anna Walker', 27, 'Female', '5656565656'),
(9, 'David Taylor', 36, 'Male', '6767676767'),
(10, 'Sophia Martinez', 31, 'Female', '7878787878');

-- Insert into Train
INSERT INTO Train (train_name, train_type, total_seats) VALUES
('Nairobi Express', 'Express', 100),
('Coastal Local', 'Local', 120),
('Nanyuki Fast', 'Express', 100),
('Bomet Line', 'Local', 100),
('Limuru Shuttle', 'Express', 120),
('Kisumu Connector', 'Express', 100),
('Kajiado Trail', 'Local', 100),
('Voi Comet', 'Express', 100),
('Entebbe Flyer', 'Express', 100),
('Thika Rapid', 'Local', 120);

-- Insert into TrainSchedule
INSERT INTO TrainSchedule (schedule_id,train_id, departure_time, arrival_time, source, destination, available_seats) VALUES
(1, 1, '2025-01-15 09:00:00', '2025-01-15 13:00:00', 'Nairobi', 'Mombasa', 45),
(2, 2, '2025-01-15 08:00:00', '2025-01-15 10:00:00', 'Mombasa', 'Arusha', 28),
(3, 3, '2025-01-16 07:00:00', '2025-01-16 11:00:00', 'Nanyuki', 'Nairobi', 50),
(4, 4, '2025-01-17 12:00:00', '2025-01-17 16:00:00', 'Eldoret', 'Bomet', 42),
(5, 5, '2025-01-18 10:00:00', '2025-01-18 14:00:00', 'Nairobi', 'Limuru', 37),
(6, 6, '2025-01-19 06:00:00', '2025-01-19 09:00:00', 'Kisumu', 'Nairobi', 70),
(7, 7, '2025-01-20 15:00:00', '2025-01-20 18:00:00', 'Kajiado', 'Nairobi', 37),
(8, 8, '2025-01-21 14:00:00', '2025-01-21 17:00:00', 'Mombasa', 'Voi', 50),
(9, 9, '2025-01-22 05:00:00', '2025-01-22 09:00:00', 'Bungoma', 'Entebbe', 60),
(10, 10, '2025-01-23 13:00:00', '2025-01-23 18:00:00', 'Nairobi', 'Thika', 30);


-- Insert into FareDetails
INSERT INTO FareDetails (schedule_id, base_fare, class_type, tax_rate) VALUES
(1, 500.00, 'Sleeper', 5.00),
(1, 750.00, 'AC', 10.00),
(2, 800.00, 'SecondClass', 3.00),
(2, 450.00, 'FirstClass', 8.00),
(3, 600.00, 'Sleeper', 4.00),
(4, 100.00, 'AC', 12.00),
(5, 700.00, 'FirstClass', 10.00),
(6, 250.00, 'SecondClass', 2.50),
(7, 900.00, 'AC', 8.50),
(8, 550.00, 'Sleeper', 6.00);

-- Insert into Booking
INSERT INTO Booking (passenger_id, schedule_id, booking_date, status, total_amount) VALUES
(1, 1, '2025-01-10 12:00:00', 'Confirmed', 550.00),
(2, 2, '2025-01-10 13:00:00', 'Pending', 230.00),
(3, 3, '2025-01-10 14:00:00', 'Confirmed', 300.00),
(4, 4, '2025-01-11 10:00:00', 'Cancelled', 120.00),
(5, 5, '2025-01-12 09:00:00', 'Confirmed', 660.00),
(6, 6, '2025-01-13 08:00:00', 'Pending', 250.50),
(7, 7, '2025-01-14 07:00:00', 'Confirmed', 970.50),
(8, 8, '2025-01-15 06:00:00', 'Cancelled', 550.50),
(9, 9, '2025-01-16 05:00:00', 'Confirmed', 360.50),
(10, 10, '2025-01-17 04:00:00', 'Pending', 280.00);

-- Insert into PNRDetails
INSERT INTO PNRDetails (pnr_number, booking_id, seat_number, booking_status, journey_date) VALUES
('PNR123456', 1, 'A1-23', 'Confirmed', '2025-01-15 09:00:00'),
('PNR123457', 2, 'B2-10', 'Waiting List', '2025-01-15 08:00:00'),
('PNR123458', 3, 'C3-15', 'Confirmed', '2025-01-16 07:00:00'),
('PNR123459', 4, 'D4-05', 'RAC', '2025-01-17 12:00:00'),
('PNR123460', 5, 'E5-30', 'Confirmed', '2025-01-18 10:00:00'),
('PNR123461', 6, 'F6-12', 'Waiting List', '2025-01-19 06:00:00'),
('PNR123462', 7, 'G7-20', 'Confirmed', '2025-01-20 15:00:00'),
('PNR123463', 8, 'H8-08', 'RAC', '2025-01-21 14:00:00'),
('PNR123464', 9, 'I9-14', 'Confirmed', '2025-01-22 05:00:00'),
('PNR123465', 10, 'J10-25', 'Waiting List', '2025-01-23 13:00:00'),
('PNR123466', 1, 'K11-33', 'Confirmed', '2025-01-15 09:00:00'),
('PNR123467', 2, 'L12-40', 'RAC', '2025-01-15 08:00:00'),
('PNR123468', 3, 'M13-50', 'Confirmed', '2025-01-16 07:00:00');

-- Insert into Payment
INSERT INTO Payment (booking_id, amount, payment_date, payment_status, payment_method) VALUES
(1, 55.00, '2025-01-10 12:15:00', 'Success', 'Online'),
(2, 23.00, '2025-01-10 13:20:00', 'Failed', 'Offline'),
(3, 30.00, '2025-01-10 14:10:00', 'Success', 'Online'),
(4, 120.00, '2025-01-11 10:30:00', 'Success', 'Online'),
(5, 66.00, '2025-01-12 09:45:00', 'Failed', 'Offline'),
(6, 25.50, '2025-01-13 08:00:00', 'Success', 'Offline'),
(7, 97.50, '2025-01-14 07:15:00', 'Success', 'Online'),
(8, 55.50, '2025-01-15 06:05:00', 'Failed', 'Online'),
(9, 36.50, '2025-01-16 05:45:00', 'Success', 'Offline'),
(10, 28.00, '2025-01-17 04:30:00', 'Success', 'Online');

-- Insert into RefundRules
INSERT INTO RefundRules (cancellation_window, refund_percentage, conditions) VALUES
('24 hours before departure', 90.00, 'Full refund minus 10% cancellation charge'),
('12-24 hours before departure', 75.00, 'Refund minus 25% cancellation charge'),
('6-12 hours before departure', 50.00, 'Refund minus 50% cancellation charge'),
('Less than 6 hours before departure', 0.00, 'No refund'),
('On the day of departure', 0.00, 'Non-refundable'),
('48 hours before departure', 95.00, 'Refund minus 5% charge for sleeper class only'),
('3 days before departure', 85.00, 'Partial refund for AC class'),
('1 week before departure', 100.00, 'Full refund with no cancellation fee'),
('10 days before departure', 80.00, 'Discounted tickets not eligible for refund'),
('14 days before departure', 100.00, 'Flexible ticket refund allowed');

-- Insert into Refunds
INSERT INTO Refunds (pnr_number, rule_id, refund_amount, refund_date, status) VALUES
('PNR123456', 1, 49.50, '2025-01-10 15:00:00', 'Approved'),
('PNR123457', 2, 17.25, '2025-01-10 15:30:00', 'Rejected'),
('PNR123458', 3, 15.00, '2025-01-11 10:00:00', 'Approved'),
('PNR123459', 4, 0.00, '2025-01-11 12:00:00', 'Rejected'),
('PNR123460', 5, 0.00, '2025-01-12 08:00:00', 'Approved'),
('PNR123461', 6, 24.22, '2025-01-13 09:30:00', 'Pending'),
('PNR123462', 7, 82.88, '2025-01-14 07:30:00', 'Approved'),
('PNR123463', 8, 50.00, '2025-01-15 08:00:00', 'Pending'),
('PNR123464', 9, 28.00, '2025-01-16 06:00:00', 'Approved'),
('PNR123465', 10, 75.00, '2025-01-17 07:00:00', 'Rejected');

SELECT * FROM Users;
SELECT * FROM Passenger;
SELECT * FROM TrainSchedule;
SELECT * FROM FareDetails;
SELECT * FROM Booking;
SELECT * FROM PNRDetails;
SELECT * FROM Payment;
SELECT * FROM RefundRules;
SELECT * FROM Refunds;

SHOW TABLES;
SELECT DATABASE();




