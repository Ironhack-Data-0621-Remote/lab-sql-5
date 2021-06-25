-- 1. Drop column `picture` from `staff`.
USE sakila;
ALTER TABLE staff
DROP COLUMN pitcure;

SELECT * from staff;

-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
select * from customer
where first_name = 'TAMMY' AND last_name = 'SANDERS';

-- to change default values of the columns, checking the data types of each column 
SELECT column_name, COLUMN_TYPE
FROM information_schema.COLUMNS
WHERE TABLE_NAME = 'staff';

-- changing the default of some columns into NULL
ALTER TABLE staff MODIFY store_id tinyint unsigned DEFAULT NULL;
ALTER TABLE staff MODIFY username varchar(16) DEFAULT NULL;
ALTER TABLE staff MODIFY password varchar(40) DEFAULT NULL;

-- adding new staff info by copying from customer table, at the same time changing the format of the data type
INSERT INTO staff (first_name, last_name, address_id, email, store_id, username)
SELECT concat(left(first_name,1), lower(substr(first_name,2))), concat(left(last_name,1), lower(substr(last_name,2))), address_id, email, 2, concat(left(first_name,1), lower(substr(first_name,2)))
FROM customer
WHERE first_name = 'TAMMY' AND last_name = 'SANDERS';

select * from staff;

-- 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the `rental_date` column in the `rental` table.
    -- **Hint**: Check the columns in the table rental and see what information you would need to add there. 
    -- You can query those pieces of information. 
    -- For eg., you would notice that you need `customer_id` information as well.
    -- To get that you can use the following query:
    -- Use similar method to get `inventory_id`, `film_id`, and `staff_id`.

select * from film
where title = 'Academy Dinosaur';

-- first, add inventory id of new rental
INSERT INTO inventory (film_id, store_id)
SELECT film_id, 1 from film where title = 'Academy Dinosaur';
select * from inventory;

-- incert rental info
INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id)
SELECT NOW(), inventory_id, customer_id, staff_id
from inventory, customer, staff
where inventory.inventory_id = 483
and customer.first_name = 'CHARLOTTE' and customer.last_name = 'HUNTER'
and staff.first_name = 'Mike' and staff.last_name = 'Hillyer';

-- 4. Delete non-active users, but first, create a _backup table_ `deleted_users` to store `customer_id`, `email`, and the `date` for the users that would be deleted. Follow these steps:

-- 4.1 Check if there are any non-active users
select count(customer_id)
from customer
group by active;

-- 4.2 Create a table _backup table_ as suggested
-- 4.3 Insert the non active users in the table _backup table_

Create table backup_table as select customer_id,email,create_date from customer
where active = 0;

-- 4.4 Delete the non active users from the table _customer_
delete from customer
where active = 0;

-- could not find out how to chanage the constraint 

