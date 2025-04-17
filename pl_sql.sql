--------------------------------------------first procedure using the cursor--------------------------------------
CREATE OR REPLACE PROCEDURE AddAnimal (
    p_id_animal IN NUMBER,
    p_id_animal_type IN NUMBER,
    p_date_from IN DATE,
    p_name IN NVARCHAR2
) AS
    v_type_count NUMBER := 0;
    v_animal_count NUMBER := 0;
    CURSOR animal_cursor IS
        SELECT COUNT(*) AS type_count
        FROM AnimalType
        WHERE id_animal_type = p_id_animal_type;
BEGIN
    -- Open and fetch the cursor
    OPEN animal_cursor;
    FETCH animal_cursor INTO v_type_count;
     -- Check if the type exists
     IF v_type_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Animal type does not exist');
    END IF;
    CLOSE animal_cursor;

    DBMS_OUTPUT.PUT_LINE('v_type_count: ' || v_type_count);


    -- Check if the animal already exists
    SELECT COUNT(*) INTO v_animal_count
    FROM Animal
    WHERE name = p_name;

    DBMS_OUTPUT.PUT_LINE('v_animal_count: ' || v_animal_count);

    IF v_animal_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Animal name already exists');
    END IF;

    -- Add the animal if conditions are met
    IF v_type_count > 0 AND v_animal_count = 0 THEN
        INSERT INTO Animal (id_animal, id_animal_type, date_from, name)
        VALUES (p_id_animal, p_id_animal_type, p_date_from, p_name);
        DBMS_OUTPUT.PUT_LINE('Animal added successfully.');
    END IF;
END;
/
BEGIN
    AddAnimal(100, 100, TO_DATE('2025-01-01', 'YYYY-MM-DD'), 'Dima'); -- raise custom error messages
END;
/
DROP PROCEDURE AddAnimal;
--------------------------------------------second procedure--------------------------------------
CREATE OR REPLACE PROCEDURE DeleteAnimal (
    p_id_animal IN NUMBER
) AS
    v_animal_exists NUMBER; -- Variable to check if the animal exists
    v_cage_assignment_count NUMBER; -- Variable to check if the animal is assigned to a cage
BEGIN
    -- first instructions
    -- check if the animal exists
    SELECT COUNT(*) INTO v_animal_exists
    FROM Animal
    WHERE id_animal = p_id_animal;
    -- raise an error if the first instructions is not okay
    IF v_animal_exists = 0 THEN
        RAISE_APPLICATION_ERROR(-20005, 'Animal does not exist.');
    END IF;

    -- second instruction
    -- check if the animal is assigned to a cage
    --it's mandatory because I can create an orphaned record
    SELECT COUNT(*) INTO v_cage_assignment_count
    FROM AnimalCage
    WHERE animal_id_animal = p_id_animal;

    IF v_cage_assignment_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20006, 'Animal is assigned to a cage');
    END IF;

    -- third instructions
    -- delete the animal
    DELETE FROM Animal
    WHERE id_animal = p_id_animal;

    DBMS_OUTPUT.PUT_LINE('Animal with ID ' || p_id_animal || ' has been successfully deleted.');
END;
/
BEGIN
    DeleteAnimal(100); -- raise custom error messages
END;
/
DROP PROCEDURE DeleteAnimal;
--------------------------------------------first triger--------------------------------------
CREATE OR REPLACE TRIGGER AddAnimalTriger
BEFORE INSERT or delete or update ON Animal
FOR EACH ROW
DECLARE
    v_animal_count number;
BEGIN
    --first instructions that the mammal animal can't be added
    IF :NEW.id_animal_type = 1 THEN
        RAISE_APPLICATION_ERROR(-20099, 'Cannot add an animal of type Mammal.');
    END IF;
    -- second instructions that the name should be unique
    IF UPDATING AND :old.name <> :new.name THEN
            :new.name := :old.name;
        end if;
    --output the statistics
    SELECT COUNT(*) INTO v_animal_count
    FROM Animal
    WHERE id_animal_type = :NEW.id_animal_type;
    DBMS_OUTPUT.PUT_LINE('Total number of animals for type ' || :NEW.id_animal_type || ': ' || v_animal_count);
end;
--Testing--
-- do not insert the animal with type mammal -- raise an error
BEGIN
    INSERT INTO Animal (id_animal, id_animal_type, name)
    VALUES (101, 1, 'Elephant'); -- 1 Mammal
END;
-- update the names of the animal(the same name) -- raise an error
BEGIN
    INSERT INTO Animal (id_animal, id_animal_type, date_from, name)
    VALUES (107, 2, TO_DATE('2024-01-01', 'YYYY-MM-DD'), 'Parrot');

    UPDATE Animal
    SET name = 'Parrot'
    WHERE id_animal = 107;
END;
--Drop Trigger
DROP TRIGGER ADDANIMALTRIGER;
--------------------------------------------second triger--------------------------------------
CREATE OR REPLACE TRIGGER DelAnimalTriger
BEFORE delete ON Animal
FOR EACH ROW
DECLARE
    v_animal_count number;
    v_remaining_count number;
BEGIN
    -- first instructions
    -- can't delete the animals with ID < 3
    IF :OLD.id_animal < 3 THEN
        RAISE_APPLICATION_ERROR(-20008, 'Cannot delete an animal with ID less than 3.');
    END IF;
    -- second instructions
    -- forbiden deleting the last animal of the same type
    SELECT COUNT(*) INTO v_remaining_count
    FROM Animal
    WHERE id_animal_type = :OLD.id_animal_type
      AND id_animal != :OLD.id_animal;
    IF v_remaining_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20009, '`Trying to delete the last animal of the type`');
    END IF;
    --output the statistics
    SELECT COUNT(*) INTO v_animal_count
    FROM Animal
    WHERE id_animal_type = :NEW.id_animal_type;
    DBMS_OUTPUT.PUT_LINE('Total number of animals for type ' || :NEW.id_animal_type || ': ' || v_animal_count);
end;
--Testing
--raise an error
BEGIN
    DELETE FROM Animal
    WHERE id_animal = 1;
END;
--
BEGIN
    DELETE FROM Animal
    WHERE id_animal = 107;
END;
select * from ANIMAL
-- Drop
DROP TRIGGER DELANIMALTRIGER;