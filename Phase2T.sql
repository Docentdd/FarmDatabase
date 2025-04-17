--Drop Tables
-- DROP TABLE AnimalEmployeeContact;
-- DROP TABLE AnimalCage;
-- DROP TABLE Hired;
-- DROP TABLE EmployeePosition;
-- DROP TABLE Position;
-- DROP TABLE Employee;
-- DROP TABLE AnimalFood;
-- DROP TABLE Food;
-- DROP TABLE Supplier;
-- DROP TABLE Cage;
-- DROP TABLE CageType;
-- DROP TABLE Animal;
-- DROP TABLE AnimalType;

-- Table: AnimalType
-- Table: AnimalType
CREATE TABLE AnimalType (
    id_animal_type integer NOT NULL,
    type NVARCHAR(100) NOT NULL,
    description NVARCHAR(255),
    CONSTRAINT AnimalType_pk PRIMARY KEY (id_animal_type)
);
INSERT INTO AnimalType (id_animal_type, type, description)
VALUES (1, 'Mammal', 'Warm-blooded vertebrate animals');
INSERT INTO AnimalType (id_animal_type, type, description)
VALUES (2, 'Bird', 'Warm-blooded egg-laying vertebrates');
INSERT INTO AnimalType (id_animal_type, type, description)
VALUES (3, 'Reptile', 'Cold-blooded vertebrates with scales');
INSERT INTO AnimalType (id_animal_type, type, description)
VALUES (4, 'Fish', 'Cold-blooded aquatic vertebrates');
INSERT INTO AnimalType (id_animal_type, type, description)
VALUES (5, 'Amphibian', 'Cold-blooded vertebrates that can live both in water and on land');
INSERT INTO AnimalType (id_animal_type, type, description)
VALUES (6, 'Insect', 'Small arthropod animals with six legs');

-- Table: Animal
CREATE TABLE Animal (
    id_animal integer NOT NULL,
    id_animal_type integer NOT NULL,
    date_from date NOT NULL,
    name NVARCHAR(100) NOT NULL,
    CONSTRAINT Animal_pk PRIMARY KEY (id_animal)
);
INSERT INTO Animal (id_animal, id_animal_type, date_from, name)
VALUES (1, 1, CAST('2024-01-01' AS DATE), 'Lion'),
       (2, 2, CAST('2024-01-10' AS DATE), 'Parrot'),
       (3, 3, CAST('2024-01-20' AS DATE), 'Snake'),
       (4, 4, CAST('2024-02-01' AS DATE), 'Goldfish'),
       (5, 5, CAST('2024-02-10' AS DATE), 'Frog'),
       (6, 6, CAST('2024-02-20' AS DATE), 'Butterfly');


-- Table: CageType
CREATE TABLE CageType (
    id_cage_type integer NOT NULL,
    type NVARCHAR(100) NOT NULL,
    description NVARCHAR(255),
    CONSTRAINT CageType_pk PRIMARY KEY (id_cage_type)
);
INSERT INTO CageType (id_cage_type, type, description)
VALUES (1, 'Small', 'Small sized cage');
INSERT INTO CageType (id_cage_type, type, description)
VALUES (2, 'Medium', 'Medium sized cage');
INSERT INTO CageType (id_cage_type, type, description)
VALUES (3, 'Large', 'Large sized cage');
INSERT INTO CageType (id_cage_type, type, description)
VALUES (4, 'Aquarium', 'Enclosure for keeping fish');
INSERT INTO CageType (id_cage_type, type, description)
VALUES (5, 'Terrarium', 'Enclosure for keeping reptiles and amphibians');


-- Table: Cage
CREATE TABLE Cage (
    id_cage integer NOT NULL,
    id_cage_type integer NOT NULL,
    CONSTRAINT Cage_pk PRIMARY KEY (id_cage)
);
INSERT INTO Cage (id_cage, id_cage_type) VALUES (1, 1);
INSERT INTO Cage (id_cage, id_cage_type) VALUES (2, 2);
INSERT INTO Cage (id_cage, id_cage_type) VALUES (3, 3);
INSERT INTO Cage (id_cage, id_cage_type) VALUES (4, 4);
INSERT INTO Cage (id_cage, id_cage_type) VALUES (5, 5);


-- Table: Supplier
CREATE TABLE Supplier (
    id_market integer NOT NULL,
    email_contact NVARCHAR(100) NOT NULL,
    date_from date NOT NULL,
    CONSTRAINT Supplier_pk PRIMARY KEY (id_market)
);
INSERT INTO Supplier (id_market, email_contact, date_from)
VALUES (1, 'supplier1@example.com', CAST('2024-01-01' AS DATE)),
       (2, 'supplier2@example.com', CAST('2024-01-10' AS DATE)),
       (3, 'supplier3@example.com', CAST('2024-01-20' AS DATE)),
       (4, 'supplier4@example.com', CAST('2024-02-01' AS DATE)),
       (5, 'supplier5@example.com', CAST('2024-02-10' AS DATE));


-- Table: Food
CREATE TABLE Food (
    id_food integer NOT NULL,
    type_of_food NVARCHAR(100) NOT NULL,
    id_market integer NOT NULL,
    price integer NOT NULL,
    CONSTRAINT Food_pk PRIMARY KEY (id_food)
);
INSERT INTO Food (id_food, type_of_food, id_market, price)
VALUES (1, 'Meat', 1, 100);
INSERT INTO Food (id_food, type_of_food, id_market, price)
VALUES (2, 'Seeds', 2, 50);
INSERT INTO Food (id_food, type_of_food, id_market, price)
VALUES (3, 'Insects', 3, 80);
INSERT INTO Food (id_food, type_of_food, id_market, price)
VALUES (4, 'Algae', 4, 30);
INSERT INTO Food (id_food, type_of_food, id_market, price)
VALUES (5, 'Fruits', 5, 70);


-- Table: AnimalFood
CREATE TABLE AnimalFood (
    id_animal_food integer NOT NULL,
    animal_id_animal integer NOT NULL,
    food_id_food integer NOT NULL,
    CONSTRAINT AnimalFood_pk PRIMARY KEY (id_animal_food)
);
INSERT INTO AnimalFood (id_animal_food, animal_id_animal, food_id_food)
VALUES (1, 1, 1);
INSERT INTO AnimalFood (id_animal_food, animal_id_animal, food_id_food)
VALUES (2, 2, 2);
INSERT INTO AnimalFood (id_animal_food, animal_id_animal, food_id_food)
VALUES (3, 3, 3);
INSERT INTO AnimalFood (id_animal_food, animal_id_animal, food_id_food)
VALUES (4, 4, 4);
INSERT INTO AnimalFood (id_animal_food, animal_id_animal, food_id_food)
VALUES (5, 5, 5);
INSERT INTO AnimalFood (id_animal_food, animal_id_animal, food_id_food)
VALUES (6, 6, 3);


-- Table: Employee
CREATE TABLE Employee (
    id_employee integer NOT NULL,
    name NVARCHAR(100) NOT NULL,
    surname NVARCHAR(100) NOT NULL,
    age integer NOT NULL,
    email NVARCHAR(100) NOT NULL,
    CONSTRAINT Employee_pk PRIMARY KEY (id_employee)
);
INSERT INTO Employee (id_employee, name, surname, age, email)
VALUES (1, 'John', 'Doe', 30, 'john.doe@example.com');
INSERT INTO Employee (id_employee, name, surname, age, email)
VALUES (2, 'Jane', 'Smith', 25, 'jane.smith@example.com');
INSERT INTO Employee (id_employee, name, surname, age, email)
VALUES (3, 'Mike', 'Johnson', 35, 'mike.johnson@example.com');
INSERT INTO Employee (id_employee, name, surname, age, email)
VALUES (4, 'Sarah', 'Connor', 29, 'sarah.connor@example.com');
INSERT INTO Employee (id_employee, name, surname, age, email)
VALUES (5, 'Kyle', 'Reese', 31, 'kyle.reese@example.com');


-- Table: Position
CREATE TABLE Position (
    id_status integer NOT NULL,
    position_name NVARCHAR(100) NOT NULL,
    CONSTRAINT Position_pk PRIMARY KEY (id_status)
);
INSERT INTO Position (id_status, position_name)
VALUES (1, 'Veterinarian');
INSERT INTO Position (id_status, position_name)
VALUES (2, 'Caretaker');
INSERT INTO Position (id_status, position_name)
VALUES (3, 'Trainer');
INSERT INTO Position (id_status, position_name)
VALUES (4, 'Manager');
INSERT INTO Position (id_status, position_name)
VALUES (5, 'Cleaner');


-- Table: EmployeePosition
CREATE TABLE EmployeePosition (
    id_postion_employee integer NOT NULL,
    position_id_status integer NOT NULL,
    employee_id_employee integer NOT NULL,
    date_from date NULL,
    salary integer NOT NULL,
    CONSTRAINT EmployeePosition_pk PRIMARY KEY (id_postion_employee)
);
INSERT INTO EmployeePosition (id_postion_employee, position_id_status, employee_id_employee, date_from, salary)
VALUES (1, 1, 1, CAST('2024-01-01' AS DATE), 60000),
       (2, 2, 2, CAST('2024-01-10' AS DATE), 40000),
       (3, 3, 3, CAST('2024-01-20' AS DATE), 50000),
       (4, 4, 4, CAST('2024-02-01' AS DATE), 75000),
       (5, 5, 5, CAST('2024-02-10' AS DATE), 30000);


-- Table: Hired
CREATE TABLE Hired (
    id_hired integer NOT NULL,
    employee_id_employee integer NOT NULL,
    hire_date date NOT NULL,
    CONSTRAINT Hired_pk PRIMARY KEY (id_hired)
);
INSERT INTO Hired (id_hired, employee_id_employee, hire_date)
VALUES (1, 1, CAST('2024-01-01' AS DATE)),
       (2, 2, CAST('2024-01-10' AS DATE)),
       (3, 3, CAST('2024-01-20' AS DATE)),
       (4, 4, CAST('2024-02-01' AS DATE)),
       (5, 5, CAST('2024-02-10' AS DATE));


-- Table: AnimalCage
CREATE TABLE AnimalCage (
    id_animal_cage integer NOT NULL,
    animal_id_animal integer NOT NULL,
    date_from date NOT NULL,
    cage_id_cage integer NOT NULL,
    CONSTRAINT AnimalCage_pk PRIMARY KEY (id_animal_cage)
);
INSERT INTO AnimalCage (id_animal_cage, animal_id_animal, date_from, cage_id_cage)
VALUES (1, 1, CAST('2024-01-01' AS DATE), 1),
       (2, 2, CAST('2024-01-10' AS DATE), 2),
       (3, 3, CAST('2024-01-20' AS DATE), 3),
       (4, 5, CAST('2024-02-01' AS DATE), 4),
       (5, 6, CAST('2024-02-10' AS DATE), 5);


-- Table: AnimalEmployeeContact
CREATE TABLE AnimalEmployeeContact (
    id_animal_employee integer NOT NULL,
    date_contact date NOT NULL,
    type_of_contact NVARCHAR(100) NOT NULL,
    animal_food_id integer NOT NULL,
    employee_id_employee integer NOT NULL,
    CONSTRAINT AnimalEmployeeContact_pk PRIMARY KEY (id_animal_employee)
);
INSERT INTO AnimalEmployeeContact (id_animal_employee, date_contact, type_of_contact, animal_food_id, employee_id_employee)
VALUES (1, CAST('2024-01-01' AS DATE), 'Feeding', 1, 1),
       (2, CAST('2024-01-10' AS DATE), 'Training', 2, 2),
       (3, CAST('2024-01-20' AS DATE), 'Medical Check', 3, 3),
       (4, CAST('2024-02-01' AS DATE), 'Feeding', 4, 4),
       (5, CAST('2024-02-10' AS DATE), 'Training', 5, 5);


-- Foreign Key Constraints
ALTER TABLE Animal ADD CONSTRAINT Animal_animal_info
    FOREIGN KEY (id_animal_type)
    REFERENCES AnimalType (id_animal_type);

ALTER TABLE EmployeePosition ADD CONSTRAINT Table_15_Employee
    FOREIGN KEY (employee_id_employee)
    REFERENCES Employee (id_employee);

ALTER TABLE EmployeePosition ADD CONSTRAINT Table_15_position
    FOREIGN KEY (position_id_status)
    REFERENCES Position (id_status);

ALTER TABLE Cage ADD CONSTRAINT Table_16_cage_type
    FOREIGN KEY (id_cage_type)
    REFERENCES CageType (id_cage_type);

ALTER TABLE Hired ADD CONSTRAINT Table_17_Employee
    FOREIGN KEY (employee_id_employee)
    REFERENCES Employee (id_employee);

ALTER TABLE AnimalFood ADD CONSTRAINT aniaml_food_Animal
    FOREIGN KEY (animal_id_animal)
    REFERENCES Animal (id_animal);

ALTER TABLE AnimalFood ADD CONSTRAINT aniaml_food_Food
    FOREIGN KEY (food_id_food)
    REFERENCES Food (id_food);

ALTER TABLE AnimalEmployeeContact ADD CONSTRAINT anim_empl_cont_Employee
    FOREIGN KEY (employee_id_employee)
    REFERENCES Employee (id_employee);

ALTER TABLE AnimalEmployeeContact ADD CONSTRAINT anim_empl_cont_aniaml_food
    FOREIGN KEY (animal_food_id)
    REFERENCES AnimalFood (id_animal_food);

ALTER TABLE AnimalCage ADD CONSTRAINT animal_cage_Animal
    FOREIGN KEY (animal_id_animal)
    REFERENCES Animal (id_animal);

ALTER TABLE AnimalCage ADD CONSTRAINT animal_cage_Table_16
    FOREIGN KEY (cage_id_cage)
    REFERENCES Cage (id_cage);

ALTER TABLE Food ADD CONSTRAINT food_market
    FOREIGN KEY (id_market)
    REFERENCES Supplier (id_market);