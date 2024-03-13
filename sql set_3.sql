-- set 3

/* 1-Write a stored procedure that accepts the month and year as inputs and prints the ordernumber, orderdate and status 
   of the orders placed in that month. 
   Example:  call order_status(2005, 11); */

select * from orders;

DELIMITER //
CREATE PROCEDURE order_status1(IN t_year INT, IN t_month INT)
BEGIN
    SELECT orderNumber, orderDate, status
    FROM orders
    WHERE YEAR(orderDate) = t_year AND MONTH(orderDate) = t_month;
END //
DELIMITER ;

call order_status1(2005, 4);

/* 2. a. Write function that takes the customernumber as input and returns the purchase_status based on the 
 following criteria . [table:Payments] */

/* if the total purchase amount for the customer is < 25000 status = Silver, amount between 25000 and 50000, status = Gold
   if amount > 50000 Platinum */

DELIMITER //

CREATE FUNCTION paystatus24(customerno INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE p_status VARCHAR(20);
    DECLARE p_amount DECIMAL(10, 2);
    
    SELECT amount INTO p_amount
    FROM payments
    WHERE customerNumber = customerno 
    LIMIT 1;
    
    IF p_amount IS NULL THEN
        RETURN NULL;
    ELSEIF p_amount < 25000 THEN
        SET p_status = 'silver';
    ELSEIF p_amount >= 25000 AND p_amount <= 50000 THEN
        SET p_status = 'gold';
    ELSE
        SET p_status = 'platinum';
    END IF;
    
    RETURN p_status;
END //

DELIMITER ;

SELECT paystatus24(145) AS status;

SELECT * FROM payments;


*/ 3. Replicate the functionality of 'on delete cascade' and 'on update cascade' using triggers on movies and rentals tables. 
 Note: Both tables - movies and rentals - don't have primary or foreign keys. Use only triggers to implement the above */

DELIMITER //
CREATE TRIGGER delete_cascade
  AFTER DELETE on movies
    FOR EACH ROW 
    BEGIN
      UPDATE rentals
        SET movieid = NULL
          WHERE movieid
                       NOT IN
            ( SELECT distinct id
              from movies );
    END //
DELIMITER ;

drop trigger if exists delete_cascade;

select *
  from movies;

INSERT INTO movies Values( 11,'The Dark Knight','Action/Adventure');

INSERT INTO rentals Values(8,'Priti','Vartak', 25 );

delete from movies
  where id = 11;

SELECT id
  from movies;

SELECT *
  from rentals;

DELIMITER //
CREATE TRIGGER update_cascade
  AFTER UPDATE on movies
    FOR EACH ROW 
    BEGIN
      UPDATE rentals
        SET movieid = new.id
          WHERE movieid = old.id;
    END //
DELIMITER ;

DROP trigger if exists update_cascade;

INSERT INTO movies ( id,             title,          category )
      Values ( 12, 'The Dark Knight', 'Action/Adventure'); 

UPDATE rentals
  SET movieid = 12
    WHERE memid = 9;

UPDATE movies
  SET id = 11
    WHERE title regexp 'Dark Knight';

select *
  from movies;

select *
  from rentals;
  
  
-- 4. Select the first name of the employee who gets the third highest salary. [table: employee] --

select * from employee; 

 SELECT * FROM employee ORDER BY salary DESC LIMIT 1 OFFSET 2;
 
 /* 5. Assign a rank to each employee  based on their salary. The person having the highest salary has rank 1. 
    [table: employee] */
 
SELECT *, DENSE_RANK() OVER (ORDER BY salary DESC) AS Rank_salary
FROM employee;