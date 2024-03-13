-- set 2

-- 1. select all employees in department 10 whose salary is greater than 3000. [table: employee] --

select * from employee 
where salary > 3000 and deptno =10;

select * from employee;

-- 2. The grading of students based on the marks they have obtained is done as follows:

-- 40 to 50 -> Second Class
-- 50 to 60 -> First Class
-- 60 to 80 -> First Class
-- 80 to 100 -> Distinctions

select * from students;

select *,
case
when marks between 40 and 49.99 then 'Second Class'
when marks between 50 and 59.99 then 'First Class'
when marks between 60 and 79.99 then 'First Class'
when marks between 80 and 99.99 then 'Distinctions'
Else 'Failed'
End as Grade
from students where Id in (11,
12,
13,
14,
15,
16,
17,
18,
19,
21,
27,
29,
31,
32,
34,
37,
38,
41,
51,
61,
71,
76,
81,
91,
96);

-- a. How many students have graduated with first class? --

Alter table students
add column Grade varchar(25) after marks;

describe students;

Update students 
Set Grade = 
Case 
when marks between 40 and 49.99 then 'Third Class'
when marks between 50 and 59.99 then 'Second Class'
when marks between 60 and 79.99 then 'First Class'
when marks between 80 and 100 then 'Distinction'
Else 'Failed'
End
where Id in (11,
12,
13,
14,
15,
16,
17,
18,
19,
21,
27,
29,
31,
32,
34,
37,
38,
41,
51,
61,
71,
76,
81,
91,
96);

select count(Grade) as 'Students graduated with First Class'
	from students
		where Grade regexp 'First';
        
-- b. How many students have obtained distinction? [table: students] --


select count(Grade) as 'Students graduated with Distinction'
	from students
		where Grade regexp 'Distinction';
        
-- 3. Get a list of city names from station with even ID numbers only. Exclude duplicates from your answer.[table: station] --
  
select * from station;

select *  from students 
where id % 2 = 0;

select *,count(*) as cnt from station 
where id % 2=0  
group by id,city,state,lat_n,long_1 
having cnt=1;

select * from station 
where id % 2 = 0
group by id, city,state,lat_n,long_1
having count(*) = 1;


/* 4. Find the difference between the total number of city entries in the table and the number of distinct city entries in the table.
     In other words, if N is the number of city entries in station, and N1 is the number of distinct city names in station, 
     write a query to find the value of N-N1 from station.[table: station] */


select count(city) as 'count of all cities'
from station;

select count(distinct city) as 'distinct of all cities'
from station;

select count(city) - count(distinct city) as 'difference between no of distinct and all cities'
from station;

/* 5. Answer the following
 a. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates. [Hint: Use RIGHT() / LEFT() methods ] */

select * from station;

select distinct city from station 
where upper(left(city,1)) in('a','e','i','o','u');

/* b. Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. 
   Your result cannot contain duplicates */

select distinct city from station
where upper(left(city,1)) in ('a','e','i','o','u') and upper(right(city,1)) in ('a','e','i','o','u');

-- c. Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates --

select distinct city from station 
where upper(left(city,1)) not in('a','e','i','o','u');

/* Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels.
   Your result cannot contain duplicates.[table: station] */

select distinct city from station
where upper(left(city,1)) not in ('a','e','i','o','u') and upper(right(city,1)) not in ('a','e','i','o','u');

/* 6. Write a query that prints a list of employee names having a salary greater than $2000 per month who have been 
 employed for less than 36 months. Sort your result by descending order of salary. [table: emp] */
 
select * from emp;

select current_timestamp(), current_date() emp;

select Concat(first_name, ' ', last_name) as Employee,
       Concat(salary, '$') as 'Salary($)',
       hire_date,
      timestampdiff(MONTH, hire_date, current_date()) as 'Total_Months_Joined'
	from emp
		where salary > 2000
			having Total_Months_Joined < 36
				order by salary desc;
                
               
               
-- 7. How much money does the company spend every month on salaries for each department? [table: employee] --

SELECT deptno, SUM(salary) AS total_salary
FROM employee
GROUP BY deptno;

-- 8. How many cities in the CITY table have a Population larger than 100000. [table: city] --


select count(name) as city from city
where population > 100000 order by city desc;

 -- 9. What is the total population of California? [table: city] --
 
 select * from city;

select district,sum(population) 
from city where district='California';

-- 10. What is the average population of the districts in each country? [table: city] --

select * from city;

select avg(population),district
from city 
group by district;

-- 11. Find the ordernumber, status, customernumber, customername and comments for all orders that are ‘Disputed=  [table: orders, customers] --

SELECT orders.orderNumber, orders.status, customers.customerNumber, customers.customerName,orders.comments
FROM orders
INNER JOIN customers ON orders.customerNumber = customers.customerNumber where status='Disputed';



