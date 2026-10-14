
/*
PROJECT: Company Employee Hierarchy Database
FILE: 01_create_tables.sql
DATABASE: SQL Server / Azure SQL

Run this script first.
*/

-- Optional: create a dedicated database separately.
-- CREATE DATABASE CompanyHierarchyDB;
-- GO
-- USE CompanyHierarchyDB;
-- GO

-- TABLE 1: DEPARTMENTS
CREATE TABLE CEH26_OrgUnitRegistry (
    Dept_ID INT IDENTITY(1,1) PRIMARY KEY,
    Department_Name VARCHAR(100) NOT NULL UNIQUE,
    Location VARCHAR(100) NOT NULL
        CONSTRAINT DF_CEH26_Department_Location
        DEFAULT 'Head Office'
);

-- TABLE 2: JOB TITLES / POSITIONS
CREATE TABLE CEH26_PositionCatalog (
    Position_ID INT IDENTITY(1,1) PRIMARY KEY,
    Title_Name VARCHAR(100) NOT NULL UNIQUE,
    Min_Salary DECIMAL(10,2) NOT NULL,
    Max_Salary DECIMAL(10,2) NOT NULL,

    CONSTRAINT CK_CEH26_Position_Salary
        CHECK (
            Min_Salary >= 0
            AND Max_Salary >= Min_Salary
        )
);

-- TABLE 3: EMPLOYEES
CREATE TABLE CEH26_WorkforceLedger (
    Staff_ID INT IDENTITY(1,1) PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Email VARCHAR(150) NOT NULL UNIQUE,

    Dept_ID INT NOT NULL,
    Position_ID INT NOT NULL,
    Reports_To INT NULL,

    Salary DECIMAL(10,2) NOT NULL
        CHECK (Salary >= 0),

    Hire_Date DATE NOT NULL
        CONSTRAINT DF_CEH26_HireDate
        DEFAULT CAST(GETDATE() AS DATE),

    CONSTRAINT FK_CEH26_Staff_Department
        FOREIGN KEY (Dept_ID)
        REFERENCES CEH26_OrgUnitRegistry(Dept_ID),

    CONSTRAINT FK_CEH26_Staff_Position
        FOREIGN KEY (Position_ID)
        REFERENCES CEH26_PositionCatalog(Position_ID),

    CONSTRAINT FK_CEH26_Staff_Manager
        FOREIGN KEY (Reports_To)
        REFERENCES CEH26_WorkforceLedger(Staff_ID),

    CONSTRAINT CK_CEH26_No_Self_Manager
        CHECK (
            Reports_To IS NULL
            OR Reports_To <> Staff_ID
        )
);

-- VERIFY TABLE CREATION
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
  AND TABLE_NAME IN (
      'CEH26_OrgUnitRegistry',
      'CEH26_PositionCatalog',
      'CEH26_WorkforceLedger'
  )
ORDER BY TABLE_NAME;
