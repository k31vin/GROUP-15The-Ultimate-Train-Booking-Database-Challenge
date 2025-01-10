# GROUP-15-The-Ultimate-Train-Booking-Database-Challenge


## Train Booking System Database Schema

This project implements a database schema for a train booking system. The schema includes tables and relationships to manage users, passengers, trains, schedules, bookings, payments, refunds, and more. It is designed to handle real-world scenarios trainbooking systems.

---

## Features
1. **User Management**:
   - Register and log in to the system.
   - Manage user and passenger details.
   
2. **Train Schedule**:
   - Store train details, routes, schedules, and seat availability.

3. **Booking System**:
   - Reserve tickets, generate PNRs, and handle payments.
   - Cancel tickets and process refunds.

4. **Payment and Refund**:
   - Manage payments with online and offline options.
   - Implement refund rules for cancellations.

---

## Database Schema
The schema uses the following tables:

### 1. Users
Stores user account information.
- **Columns**:
  - `user_id` (Primary Key)
  - `name`
  - `email`
  - `phone`
  - `password`

### 2. Passenger
Details of passengers associated with users.
- **Columns**:
  - `passenger_id` (Primary Key)
  - `user_id` (Foreign Key to `Users`)
  - `name`
  - `age`
  - `gender`
  - `contact`

### 3. Train
Stores train details.
- **Columns**:
  - `train_id` (Primary Key)
  - `train_name`
  - `train_type`
  - `total_seats`

### 4. TrainSchedule
Details about train schedules.
- **Columns**:
  - `schedule_id` (Primary Key)
  - `train_id` (Foreign Key to `Train`)
  - `departure_time`
  - `arrival_time`
  - `source`
  - `destination`
  - `available_seats`

### 5. FareDetails
Details of fare by class, zone, and train schedule.
- **Columns**:
  - `fare_id` (Primary Key)
  - `schedule_id` (Foreign Key to `TrainSchedule`)
  - `base_fare`
  - `class_type`
  - `tax_rate`

### 6. Booking
Stores reservation details for passengers.
- **Columns**:
  - `booking_id` (Primary Key)
  - `passenger_id` (Foreign Key to `Passenger`)
  - `schedule_id` (Foreign Key to `TrainSchedule`)
  - `booking_date`
  - `status`
  - `total_amount`

### 7. PNRDetails
Details of the PNR generated for bookings.
- **Columns**:
  - `pnr_number` (Primary Key)
  - `booking_id` (Foreign Key to `Booking`)
  - `seat_number`
  - `booking_status`
  - `journey_date`

### 8. Payment
Details of payment for bookings.
- **Columns**:
  - `payment_id` (Primary Key)
  - `booking_id` (Foreign Key to `Booking`)
  - `amount`
  - `payment_date`
  - `payment_status`
  - `payment_method`

### 9. RefundRules
Rules governing ticket cancellation refunds.
- **Columns**:
  - `rule_id` (Primary Key)
  - `cancellation_window`
  - `refund_percentage`
  - `conditions`

### 10. Refunds
Details of processed refunds.
- **Columns**:
  - `refund_id` (Primary Key)
  - `pnr_number` (Foreign Key to `PNRDetails`)
  - `rule_id` (Foreign Key to `RefundRules`)
  - `refund_amount`
  - `refund_date`
  - `status`

---

## Entity-Relationship Diagram (ERD)
Below is the ERD representation:

```plaintext
Users ||--o{ Passenger : has
Passenger ||--o{ Booking : makes
Train ||--o{ TrainSchedule : has
TrainSchedule ||--o{ Booking : includes
FareDetails ||--o{ TrainSchedule : determines
Booking ||--|| PNRDetails : generates
Booking ||--|| Payment : requires
RefundRules ||--o{ Refunds : governs
PNRDetails ||--o{ Refunds : initiates

```
### Here is the link to the drawio where we drew the ERD diagram: 
https://drive.google.com/file/d/1XZJnyjveydIdmyyHQWDcldwuSjI6uMsC/view?usp=sharing
