-- SQL LAB 3.01

USE sakila_cp;

-- 1. Drop column picture from staff.
ALTER TABLE staff
DROP COLUMN picture;

SELECT * FROM staff;

-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. 
-- Update the database accordingly.
INSERT INTO staff
SELECT 
	3, 
	lower(first_name), 
	lower(last_name), 
	address_id, 
	'tammy.sanders@sakilastaff.com', 
	store_id, 
	active, 
	lower(first_name), 
	NULL, 
	last_update
FROM customer
WHERE customer_id = 75;

SELECT * FROM staff;

/*
Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
You can use current date for the rental_date column in the rental table. 
Hint: Check the columns in the table rental and see what information you would need to add there. 
You can query those pieces of information. For eg., you would notice that you need customer_id information as well. 
To get that you can use the following query:

select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER'; */

-- ALTER TABLE rental AUTO_INCREMENT = 1; 

INSERT INTO rental (inventory_id, customer_id, staff_id)
SELECT inventory.inventory_id, customer.customer_id, staff.staff_id
FROM inventory, customer, staff
WHERE (inventory.film_id = 1 AND inventory.inventory_id = 4 AND inventory.store_id = 1) 
AND (customer.first_name = 'CHARLOTTE' and customer.last_name = 'HUNTER')
AND (staff.first_name = 'Mike' and staff.last_name = 'Hillyer');

SELECT * FROM rental;

-- ACTIVITY 2: PijuanAmelia_LAB 3.1_Schema / PDF LAB 3.1 SCHEMA
