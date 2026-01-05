# Vehicle Rental System – Database Design & SQL Queries

## Overview
This project implements a simplified **Vehicle Rental System** using PostgreSQL.  
It focuses on database design, entity relationships, and SQL querying using real-world business logic.

The system manages:
- Users (Admins and Customers)
- Vehicles (Cars, Bikes, Trucks)
- Bookings (Vehicle rentals by users)

This repository contains:
- Database schema (tables, enums, keys)
- Sample data
- Required SQL queries using JOIN, EXISTS, WHERE, GROUP BY, and HAVING
- ERD design (submitted separately via Lucidchart link)

---

## Objectives
By completing this assignment, the following concepts are demonstrated:

- ERD design with proper relationships
- Primary keys and foreign keys
- One-to-Many and Many-to-One relationships
- Use of SQL joins and subqueries
- Filtering and aggregation using WHERE, EXISTS, GROUP BY, and HAVING

---

## Database Design

### Tables
The database consists of three core tables:

#### 1. Users
Stores system users with different roles.

**Fields**
- `id` (PK)
- `name`
- `email` (unique)
- `password`
- `phone`
- `role` (`admin`, `customer`)

---

#### 2. Vehicles
Stores all rentable vehicles.

**Fields**
- `id` (PK)
- `vehicle_name`
- `vehicle_model`
- `reg_num` (unique)
- `day_price`
- `status` (`available`, `rented`, `maintenance`)
- `type` (`car`, `bike`, `truck`)

---

#### 3. Bookings
Stores vehicle rental records.

**Fields**
- `id` (PK)
- `user_id` (FK → users.id)
- `vehicle_id` (FK → vehicles.id)
- `rent_start`
- `rent_end`
- `status` (`pending`, `confirmed`, `completed`, `cancelled`)
- `total_cost`

---

## Entity Relationships (ERD)

- **One-to-Many**: One user can make many bookings
- **Many-to-One**: Many bookings can be associated with one vehicle
- **Logical One-to-One**: Each booking links exactly one user and one vehicle

The ERD includes:
- Primary keys
- Foreign keys
- Relationship cardinality
- Status fields

> 📌 **Note:** The ERD is created using **Lucidchart** and submitted as a public shareable link as required.

---

## SQL Features Used
- ENUM types
- PRIMARY KEY and FOREIGN KEY constraints
- UNIQUE constraints
- INNER JOIN
- NOT EXISTS
- WHERE clause
- GROUP BY and HAVING
- Aggregate functions (COUNT)

---

## SQL Queries

### Query 1: Retrieve Booking Information (INNER JOIN)
Retrieves booking details along with customer name and vehicle name.
