-- Create database
CREATE DATABASE rentel;

-- Create users table
CREATE TYPE user_role AS enum('admin', 'customer');
CREATE TABLE users (
    id serial PRIMARY KEY,
    name varchar(50),
    email varchar(100) UNIQUE,
    password varchar(255),
    phone varchar(13),
    role user_role NOT NULL
)

-- Create vehicles table
CREATE TYPE vehicle_status AS enum('available', 'rented', 'maintenance');

CREATE TYPE vehicle_type AS enum('car', 'bike', 'truck');

CREATE TABLE vehicles (
    id serial PRIMARY KEY,
    vehicle_name varchar(100),
    vehicle_model varchar(50),
    reg_num varchar(50) UNIQUE,
    day_price int,
    status vehicle_status NOT NULL,
    type vehicle_type NOT NULL
)

-- Create bookings table
CREATE TYPE booking_status AS enum('pending', 'confirmed', 'completed', 'cancelled');

CREATE TABLE bookings (
    id serial PRIMARY KEY,
    user_id int REFERENCES users (id),
    vehicle_id int REFERENCES vehicles (id),
    rent_start date,
    rent_end date,
    status booking_status NOT NULL,
    total_cost decimal(10, 2)
)

-- Insert data into users table 
INSERT INTO
  users (name, email, password, phone, role)
VALUES
  (
    'Alice',
    'alice@example.com',
    'hashed_pass_1',
    '12345678901',
    'customer'
  ),
  (
    'Bob',
    'bob@example.com',
    'hashed_pass_2',
    '12345678902',
    'admin'
  ),
  (
    'Charlie Brown',
    'charlie@example.com',
    'hashed_pass_3',
    '12345678903',
    'admin'
  ),
  (
    'Charlie',
    'Charlie@example.com',
    'hashed_pass_4',
    '12345678904',
    'customer'
  );


-- Insert data into vehicles table 

  INSERT INTO
  vehicles ( vehicle_name, vehicle_model, reg_num, day_price, status, type )
VALUES
  (
    'Toyota Corolla',
    '2022',
    'ABC-123',
    50,
    'available',
    'car'
  ),
  (
    'Honda Civic',
    '2021',
    'DEF-456',
    60,
    'rented',
    'car'
  ),
  (
    'Yamaha R15',
    '2023',
    'GHI-789',
    30,
    'available',
    'bike'
  ),
  (
    'Ford F-150',
    '2020',
    'JKL-012',
    100,
    'maintenance',
    'truck'
  );

  -- Insert data into bookings table 
  INSERT INTO bookings ( user_id, vehicle_id, rent_start, rent_end, status, total_cost )
VALUES
  (
    1,
    2,
    '2023-10-01',
    '2023-10-05',
    'completed',
    240
  ),
  (
    1,
    2,
    '2023-11-01',
    '2023-11-03',
    'completed',
    120
  ),
  (
    3,
    2,
    '2023-12-01',
    '2023-12-02',
    'confirmed',
    60
  ),
  (
    1,
    1,
    '2023-12-10',
    '2023-12-12',
    'pending',
    100
  );



  -- Query 1: Retrieve booking information with customer and vehicle name (Inner Join)
 SELECT
  bookings.id AS booking_id,
  users.name AS customer_name,
  vehicles.vehicle_name,
  bookings.rent_start,
  bookings.rent_end,
  bookings.status
FROM
  bookings
  INNER JOIN users ON bookings.user_id = users.id
  INNER JOIN vehicles ON bookings.user_id = vehicles.id

  --Query 2 : Find all vehicles that have never been booked (Exists)
SELECT
  vehicles.id as vehicle_id,
  vehicles.vehicle_name,
  vehicles.type,
  vehicles.vehicle_model,
  vehicles.reg_num as registration_number,
  vehicles.day_price as rental_price,
  vehicles.status
FROM
  vehicles
WHERE
  NOT EXISTS (
    SELECT 1
    FROM bookings
    WHERE bookings.vehicle_id = vehicles.id
  )

-- Query 3 : Retrieve all available vehicles of a specific type (e.g. cars)
SELECT
  *
FROM
  vehicles
WHERE
  status = 'available'
  AND type = 'car'


-- Query 4 : Find the total number of bookings for each vehicle and display only those vehicles that have more than 2 bookings.
SELECT
  vehicles.vehicle_name,
  COUNT(bookings.id) AS total_bookings
FROM
  vehicles
  JOIN bookings ON vehicles.id = bookings.vehicle_id
GROUP BY
  vehicles.id,
  vehicles.vehicle_name
HAVING
  COUNT(bookings.id) > 2;