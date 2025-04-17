--SELECT statement that joins at least two tables and contains WHERE clause (3 queries)
-- List all employees and their positions.
SELECT e.name AS employee_name,e.surname AS employee_surname,p.position_name
FROM Employee e
JOIN EmployeePosition ep ON e.id_employee = ep.employee_id_employee
JOIN Position p ON ep.position_id_status = p.id_status
WHERE ep.salary > 0;

--Retrieve the employees who were hired after January 15, 2024 and have salary greater than 100.
SELECT e.name, e.surname, ep.salary, h.hire_date
FROM Employee e
JOIN Hired h ON e.id_employee = h.employee_id_employee
JOIN EmployeePosition ep ON e.id_employee = ep.employee_id_employee
WHERE h.hire_date > TO_DATE('2024-01-15', 'YYYY-MM-DD') AND ep.salary > 100;

-- Retrieve the cages that contain reptiles.
SELECT c.id_cage, ct.type
FROM Cage c
JOIN CageType ct ON c.id_cage_type = ct.id_cage_type
JOIN AnimalCage ac ON c.id_cage = ac.cage_id_cage
JOIN Animal a ON ac.animal_id_animal = a.id_animal
JOIN AnimalType at ON a.id_animal_type = at.id_animal_type
WHERE at.type = 'Reptile';

--SELECT statement that joins at least two tables and contains GROUP BY and HAVING clauses (3 queries)
--Count the number of employees per position, displaying only positions with a total salary over 100,000.
SELECT p.position_name,COUNT(e.id_employee) AS employee_count,SUM(ep.salary) AS total_salary
FROM Employee e
JOIN EmployeePosition ep ON e.id_employee = ep.employee_id_employee
JOIN Position p ON ep.position_id_status = p.id_status
GROUP BY p.position_name
HAVING SUM(ep.salary) > 50000;
--Find the average age of employees per position, displaying only positions with an average age greater than 30. 
SELECT  p.position_name, AVG(e.age) AS average_age
FROM Employee e
JOIN EmployeePosition ep ON e.id_employee = ep.employee_id_employee
JOIN Position p ON ep.position_id_status = p.id_status
GROUP BY p.position_name
HAVING AVG(e.age) > 30;
--Find the maximum price of food supplied by each supplier, displaying only suppliers with a maximum price above 70. 
SELECT s.email_contact AS supplier_email, MAX(f.price) AS max_price
FROM Food f
JOIN Supplier s ON f.id_market = s.id_market
JOIN AnimalFood af ON f.id_food = af.food_id_food
GROUP BY s.email_contact
HAVING MAX(f.price) > 70;

--SELECT statement with subquery (2 queries)
--List employees who have the highest salary.
SELECT  e.name AS employee_name,e.surname AS employee_surname,ep.salary
FROM Employee e
JOIN  EmployeePosition ep ON e.id_employee = ep.employee_id_employee
WHERE ep.salary = (SELECT MAX(ep2.salary) FROM EmployeePosition ep2);
--List employees whose salary is greater than the average salary of all employees.
SELECT e.name AS employee_name, e.surname AS employee_surname, ep.salary
FROM Employee e
JOIN EmployeePosition ep ON e.id_employee = ep.employee_id_employee
WHERE  ep.salary > (SELECT AVG(ep2.salary)
                    FROM 
                    EmployeePosition ep2);
--SELECT statement with correlated subquery (2 queries)
--List animals that have been fed the most expensive food relative to the other foods they have been fed.
SELECT a.name AS animal_name, f.price AS food_price
FROM Animal a
JOIN AnimalFood af ON a.id_animal = af.animal_id_animal
JOIN Food f ON af.food_id_food = f.id_food
WHERE f.price = (SELECT MAX(f2.price)
                FROM AnimalFood af2
                JOIN Food f2 ON af2.food_id_food = f2.id_food
                WHERE af2.animal_id_animal = a.id_animal);
--List suppliers who supply food that is cheaper than the average price of all foods.
SELECT s.email_contact AS supplier_email, f.price AS food_price
FROM Supplier s
JOIN Food f ON s.id_market = f.id_market
WHERE f.price < (SELECT AVG(f2.price)
                FROM 
                Food f2);





