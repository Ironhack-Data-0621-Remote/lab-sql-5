-- 1. Drop column `picture` from `staff`.
-- ALTER TABLE staff
-- DROP COLUMN picture;


-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
-- insert into staff (staff_id ,first_name ,last_name ,address_id ,picture ,email , store_id ,active ,username ,password ,last_update)
-- values (3,'Tammy','Sanders',5,0,'Tammy.Sanders@sakilastaff.com',2,1,'Tammy',100,0);

-- insert into customer (customer_id ,store_id ,first_name ,last_name ,email ,address_id ,active ,create_date ,last_update)
-- values (600 ,2 ,'Tammy','Sanders','Tammy.Sanders@sakilastaff.com',5,1,0 ,0);


-- 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the `rental_date` column in the `rental` table.
   -- **Hint**: Check the columns in the table rental and see what information you would need to add there. 
   -- You can query those pieces of information. 
   -- For eg., you would notice that you need `customer_id` information as well.
   -- To get that you can use the following query:

-- insert into rental (rental_id ,rental_date ,inventory_id ,customer_id ,return_date ,staff_id ,last_update)
-- values (16050 ,'2021-06-24' ,1 ,130 ,0 ,1 ,'2021-06-24 22:53:30');

-- Use similar method to get `inventory_id`, `film_id`, and `staff_id`.

-- select customer_id from sakila.customer
-- where first_name = 'CHARLOTTE' and last_name = 'HUNTER';

-- select inventory_id from sakila.inventory
-- where film_id = 1 and store_id = 1;

-- select film_id from sakila.film
-- where title = 'Academy Dinosaur';

-- select staff_id from sakila.staff
-- where first_name = 'MIKE' and last_name = 'Hillyer';


   

-- 4. Delete non-active users, but first, create a _backup table_ `deleted_users` to store `customer_id`, `email`, and the `date` for the users that would be deleted. Follow these steps:

   -- 4.1 Check if there are any non-active users
   -- select count(active)
   -- from customer
   -- where active = 0;
   
   
   -- 4.2 Create a table _backup table_ as suggested
-- CREATE TABLE backup_customer LIKE customer; 

   
   -- 4.3 Insert the non active users in the table _backup table_
-- INSERT INTO backup_customer SELECT * FROM customer where active = 0; 
   
   -- 4.4 Delete the non active users from the table _customer_
 
   -- delete from customer 
   -- where customer.active = 0;
   