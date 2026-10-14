
/*
PROJECT: Company Employee Hierarchy Database
FILE: 02_insert_sample_data.sql

Run after 01_create_tables.sql.
Sample data assumes the tables are empty.
*/

-- INSERT DEPARTMENTS
INSERT INTO CEH26_OrgUnitRegistry
    (Department_Name, Location)
VALUES
    ('Executive', 'New York'),
    ('Engineering', 'San Francisco'),
    ('Human Resources', 'Chicago'),
    ('Finance', 'New York');

-- INSERT JOB TITLES
INSERT INTO CEH26_PositionCatalog
    (Title_Name, Min_Salary, Max_Salary)
VALUES
    ('CEO', 150000, 300000),
    ('Engineering Manager', 100000, 180000),
    ('Senior Software Engineer', 90000, 150000),
    ('Software Engineer', 60000, 110000),
    ('HR Manager', 80000, 140000),
    ('HR Specialist', 45000, 80000),
    ('Finance Manager', 90000, 160000),
    ('Financial Analyst', 55000, 100000);

-- INSERT THE CEO FIRST
INSERT INTO CEH26_WorkforceLedger
    (First_Name, Last_Name, Email,
     Dept_ID, Position_ID, Reports_To, Salary)
VALUES
    ('Olivia', 'Carter', 'olivia.carter@company.com',
     1, 1, NULL, 250000);

-- INSERT DEPARTMENT MANAGERS
-- These employees report directly to the CEO.
INSERT INTO CEH26_WorkforceLedger
    (First_Name, Last_Name, Email,
     Dept_ID, Position_ID, Reports_To, Salary)
VALUES
    ('James', 'Wilson', 'james.wilson@company.com',
     2, 2, 1, 160000),
    ('Sophia', 'Brown', 'sophia.brown@company.com',
     3, 5, 1, 120000),
    ('Liam', 'Taylor', 'liam.taylor@company.com',
     4, 7, 1, 135000);

-- INSERT OTHER EMPLOYEES
-- They report to their respective department managers.
INSERT INTO CEH26_WorkforceLedger
    (First_Name, Last_Name, Email,
     Dept_ID, Position_ID, Reports_To, Salary)
VALUES
    ('Noah', 'Davis', 'noah.davis@company.com',
     2, 3, 2, 125000),
    ('Emma', 'Miller', 'emma.miller@company.com',
     2, 4, 2, 85000),
    ('Ava', 'Garcia', 'ava.garcia@company.com',
     3, 6, 3, 65000),
    ('Ethan', 'Martinez', 'ethan.martinez@company.com',
     4, 8, 4, 78000),
    ('Mia', 'Anderson', 'mia.anderson@company.com',
     2, 4, 2, 90000),
    ('Lucas', 'Thomas', 'lucas.thomas@company.com',
     3, 6, 3, 62000),
    ('Isabella', 'Jackson', 'isabella.jackson@company.com',
     4, 8, 4, 82000);

-- VERIFY INSERTED RECORDS
SELECT * FROM CEH26_OrgUnitRegistry;
SELECT * FROM CEH26_PositionCatalog;
SELECT * FROM CEH26_WorkforceLedger;
