-- Database support project
-- Author: [Kyrylo Zaiets]
-- Purpose : Customer order risk analysis

-- STEP 1: CREATE TABLE 1

CREATE TABLE customers
(
	customer_id serial,
	customer_name varchar(100),
	customer_email varchar(100),
	city varchar(50),

	CONSTRAINT PK_customer_customer_id PRIMARY KEY(customer_id)
);

-- STEP 2: CREATE TABLE 2

CREATE TABLE orders
(
	order_id serial,
	customer_id int,
	order_date date,
	order_amount DECIMAL(10,2),
	order_status varchar(20),

	CONSTRAINT PK_order_order_id PRIMARY KEY(order_id),
	CONSTRAINT FK_customer FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);

-- STEP 3: ADD data to the customers table

INSERT INTO customers(customer_name, customer_email, city)
VALUES
('Anna Nowak', 'anna.nowak@example.com', 'Warsaw'),
('Piotr Kowalski', 'piotr.k@example.com', 'Krakow'),
('Maria Zielinska', 'm.zielinska@example.com', 'Gdansk'),
('Tomasz Wójcik', 't.wojcik@example.com', 'Wroclaw'),
('Olga Lewandowska', 'olga.lew@example.com', 'Warsaw'),
('Kacper Nowicki', 'kacper.n@example.com', 'Poznan');

-- STEP 4: ADD data to the orders table

INSERT INTO orders(customer_id, order_date, order_amount, order_status)
VALUES
(1, '2024-01-15', 150.00, 'completed'),
(2, '2024-02-20', 200.00, 'pending'),
(3, '2024-03-05', 300.00, 'completed'),
(1, '2024-04-10', 50.00, 'pending'),
(2, '2024-04-15', 120.00, 'completed'),
(4, '2024-05-01', 90.00, 'cancelled'),
(5, '2024-05-12', 500.00, 'completed'),
(5, '2024-05-20', 180.00, 'pending');

-- STEP 5: View specific customer

SELECT * FROM customers
WHERE customer_id = 1;

-- STEP 6: Calculate total order amount per customer

SELECT SUM(order_amount) AS total_amount
FROM orders
GROUP BY customer_id;

-- STEP 7: Count orders by status

SELECT COUNT(*)
FROM orders
GROUP BY order_status;

-- STEP 8: Create a summary view

CREATE VIEW customers_orders_summary AS
SELECT customers.customer_id, customers.customer_name,
COUNT(orders.order_id) AS total_orders,
SUM(orders.order_amount) AS total_amount
FROM customers
LEFT JOIN orders USING(customer_id)
GROUP BY customers.customer_id, customers.customer_name;



