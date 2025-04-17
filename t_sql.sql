--------------------------------------------first procedure using cursor--------------------------------------
CREATE PROCEDURE CalculateEmployeeSalaryCosts
    @PositionID INT = NULL -- Specify a role to filter, NULL means all roles
AS
BEGIN
    DECLARE @TotalSalary INT = 0;
    DECLARE @Salary INT;
    DECLARE @TotalEmployees INT, @AverageSalary DECIMAL(10, 2); -- for second instruction

    -- Crete the Cursor to iterate over the EmployeePosition table
    DECLARE SalaryCursor CURSOR FOR
    SELECT salary
    FROM EmployeePosition
    WHERE (@PositionID IS NULL OR position_id_status = @PositionID);

    OPEN SalaryCursor;
    FETCH NEXT FROM SalaryCursor INTO @Salary;
    -- First instruction to output the total value of the Salary
    BEGIN
        SET @TotalSalary = @TotalSalary + @Salary;
        FETCH NEXT FROM SalaryCursor INTO @Salary;
    END;
    -- Second Instruction to have the statistic of the salary
    SELECT
        @TotalEmployees = COUNT(*),
        @AverageSalary = AVG(salary)
    FROM EmployeePosition
    WHERE (@PositionID IS NULL OR position_id_status = @PositionID);
    -- Close the Cursor
    CLOSE SalaryCursor;
    DEALLOCATE SalaryCursor; -- memory management -- correct the cursor lifecycle

    --Third Instruction
    --output for the second instruction
    PRINT CONCAT('Total Employees: ', @TotalEmployees, ', Average Salary: ', @AverageSalary);
    --output for the first Instruction
    PRINT CONCAT('Total Salary of the Employees: ', @TotalSalary);
END;
--Check the procedure
EXEC CalculateEmployeeSalaryCosts;
EXEC CalculateEmployeeSalaryCosts @PositionID = 1;
--Drop the procedure
DROP PROCEDURE CalculateEmployeeSalaryCosts;
--------------------------------------------second procedure--------------------------------------
CREATE PROCEDURE AssignEmployeeToAnimal
    @EmployeeID INT,
    @AnimalID INT,
    @AnimalFoodID INT,
    @ContactType NVARCHAR(100),
    @ContactDate DATE
AS
BEGIN
    -- Instruction 1: Check if the EmployeeID exists
    IF NOT EXISTS (SELECT 1 FROM Employee WHERE id_employee = @EmployeeID)
    BEGIN
        PRINT 'Error: Employee does not exist.';
        RETURN;
    END;
    -- Instruction 2: Check if the AnimalID exists
    IF NOT EXISTS (SELECT 1 FROM Animal WHERE id_animal = @AnimalID)
    BEGIN
        PRINT 'Error: Animal does not exist.';
        RETURN;
    END;
    -- Instruction 3: Check if both Employee and Animal have valid conditions
    IF EXISTS (SELECT 1 FROM Employee WHERE id_employee = @EmployeeID)
       AND EXISTS (SELECT 1 FROM Animal WHERE id_animal = @AnimalID)
    BEGIN
        -- Assign the employee to the animal
        INSERT INTO AnimalEmployeeContact (id_animal_employee, date_contact, type_of_contact, animal_food_id, employee_id_employee)
        VALUES (
            (SELECT ISNULL(MAX(id_animal_employee), 0) + 1 FROM AnimalEmployeeContact),
            @ContactDate,
            @ContactType,
            @AnimalFoodID,
            @EmployeeID
        );
        PRINT 'Employee successfully assigned to the animal.';
    END;
END;
--check to correctly assign the employee to animal
EXEC AssignEmployeeToAnimal
    @EmployeeID = 1,
    @AnimalID = 1,
    @AnimalFoodID = 1,
    @ContactType = 'Feeding',
    @ContactDate = '2024-01-15';
--Error: Employee does not exist.
EXEC AssignEmployeeToAnimal
    @EmployeeID = 99,
    @AnimalID = 1,
    @AnimalFoodID = 1,
    @ContactType = 'Feeding',
    @ContactDate = '2024-01-15';
--Error: Animal does not exist.
EXEC AssignEmployeeToAnimal
    @EmployeeID = 1,
    @AnimalID = 99,
    @AnimalFoodID = 1,
    @ContactType = 'Feeding',
    @ContactDate = '2024-01-15';
-- Drop the procedure
DROP PROCEDURE AssignEmployeeToAnimal;
--------------------------------------------first trigger--------------------------------------
CREATE TRIGGER BeforeSalaryUpdate
ON EmployeePosition
INSTEAD OF UPDATE
AS
BEGIN
    DECLARE
        @OldSalary INT,
        @NewSalary INT,
        @EmployeeID INT;
    SELECT
        @OldSalary = e.salary,
        @NewSalary = i.salary,
        @EmployeeID = i.employee_id_employee
    FROM
        EmployeePosition e
        JOIN INSERTED i ON e.id_postion_employee = i.id_postion_employee;

    -- Instruction 1: Check if the EmployeeID exists
    IF NOT EXISTS (SELECT 1 FROM Employee WHERE id_employee = @EmployeeID)
    BEGIN
        PRINT CONCAT('Error: Employee ID ', @EmployeeID, ' does not exist.');
        RETURN;
    END;

    -- Instruction 2: Check if the salary is less than 4000
    IF @NewSalary < 4000
    BEGIN
        PRINT CONCAT('Old Salary: ', @OldSalary, ', Attempted New Salary: ', @NewSalary, '. Salary must be at least 4000.');
        RETURN;
    END;

    -- Instruction 3: Output successful update message if conditions are met
    PRINT CONCAT('Employee ID: ', @EmployeeID, ' - Old Salary: ', @OldSalary, ', New Salary: ', @NewSalary);

    -- Proceed with the update if all conditions are satisfied
    UPDATE EmployeePosition
    SET salary = i.salary
    FROM EmployeePosition e
    JOIN INSERTED i ON e.id_postion_employee = i.id_postion_employee;

    PRINT 'Salary updated successfully.';
END;
    --Employee ID: 1 - Old Salary: 60000, New Salary: 4500
    --Salary updated successfully.
UPDATE EmployeePosition
SET salary = 4500
WHERE id_postion_employee = 1;
    -- Old Salary: 4500, Attempted New Salary: 3500. Salary must be at least 4000.
UPDATE EmployeePosition
SET salary = 3500
WHERE id_postion_employee = 1;
--Drop
DROP TRIGGER BeforeSalaryUpdate;

--------------------------------------------second trigger--------------------------------------
CREATE TRIGGER BeforeCageUpdate
ON Cage
INSTEAD OF UPDATE
AS
BEGIN
    DECLARE
        @CageID INT,
        @OldCageTypeID INT,
        @NewCageTypeID INT;
    --Instruction 1: Check is the CageID exist
    SELECT
        @CageID = i.id_cage,
        @NewCageTypeID = i.id_cage_type
    FROM INSERTED i;

    IF NOT EXISTS (SELECT 1 FROM Cage WHERE id_cage = @CageID)
    BEGIN
        PRINT CONCAT('Error: Cage ID ', @CageID, ' does not exist.');
        RETURN; -- Prevent further processing
    END;
    -- Instruction 2: Check if the cage contains animals
    SELECT
        @CageID = i.id_cage,
        @NewCageTypeID = i.id_cage_type,
        @OldCageTypeID = c.id_cage_type
    FROM Cage c
    JOIN INSERTED i ON c.id_cage = i.id_cage;
    IF EXISTS (SELECT 1 FROM AnimalCage WHERE cage_id_cage = @CageID)
    BEGIN
        -- Error output
        PRINT CONCAT(
            'Error: Cannot change the cage type for Cage ID: ', @CageID,
            '. Animals are currently housed in this cage.'
        );
        RETURN;  -- stop the execution
    END;
    -- Instruction 3 - Update the cage, if no animals
    UPDATE Cage
    SET id_cage_type = i.id_cage_type
    FROM Cage c
    JOIN INSERTED i ON c.id_cage = i.id_cage;
    --Instruction 4 - Output the details of the updated cage
    PRINT CONCAT(
        'Cage updated successfully. Cage ID: ', @CageID,
        ', Old Cage Type: ', @OldCageTypeID,
        ', New Cage Type: ', @NewCageTypeID
    );

    PRINT 'Cage type updated successfully.';
END;
--Error:
-- Cannot change the cage type for Cage ID: 1.
-- Animals are currently housed in this cage.
UPDATE Cage
SET id_cage_type = 2
WHERE id_cage = 1;
-- Error: Cage ID  does not exist.
UPDATE Cage
SET id_cage_type = 2
WHERE id_cage = 6;

--Cage updated successfully. Cage ID: 5, Old Cage Type: 5, New Cage Type: 2
--Cage type updated successfully.
UPDATE Cage
SET id_cage_type = 2
WHERE id_cage = 6;

INSERT INTO Cage (id_cage, id_cage_type) VALUES (6, 1);
--Drop the Trigger
DROP TRIGGER BeforeCageUpdate;