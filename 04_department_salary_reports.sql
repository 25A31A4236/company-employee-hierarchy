
/*
PROJECT: Company Employee Hierarchy Database
FILE: 04_department_salary_reports.sql
*/

-- QUERY 1: DEPARTMENT-WISE SALARY SUMMARY
SELECT
    D.Department_Name,
    COUNT(E.Staff_ID) AS Employee_Count,
    COALESCE(AVG(E.Salary), 0) AS Average_Salary,
    COALESCE(SUM(E.Salary), 0) AS Total_Salary,
    COALESCE(MIN(E.Salary), 0) AS Lowest_Salary,
    COALESCE(MAX(E.Salary), 0) AS Highest_Salary
FROM CEH26_OrgUnitRegistry D
LEFT JOIN CEH26_WorkforceLedger E
    ON D.Dept_ID = E.Dept_ID
GROUP BY D.Dept_ID, D.Department_Name
ORDER BY Average_Salary DESC;


-- QUERY 2: EMPLOYEES EARNING ABOVE COMPANY AVERAGE
SELECT
    Staff_ID,
    First_Name,
    Last_Name,
    Salary
FROM CEH26_WorkforceLedger
WHERE Salary > (
    SELECT AVG(Salary)
    FROM CEH26_WorkforceLedger
)
ORDER BY Salary DESC;


-- QUERY 3: TOTAL PAYROLL BY JOB TITLE
SELECT
    P.Title_Name,
    COUNT(E.Staff_ID) AS Employees_In_Position,
    COALESCE(SUM(E.Salary), 0) AS Total_Payroll
FROM CEH26_PositionCatalog P
LEFT JOIN CEH26_WorkforceLedger E
    ON P.Position_ID = E.Position_ID
GROUP BY P.Position_ID, P.Title_Name
ORDER BY Total_Payroll DESC;


-- QUERY 4: EMPLOYEES OUTSIDE THEIR POSITION'S SALARY RANGE
SELECT
    E.Staff_ID,
    E.First_Name + ' ' + E.Last_Name AS Staff_Name,
    P.Title_Name,
    E.Salary,
    P.Min_Salary,
    P.Max_Salary
FROM CEH26_WorkforceLedger E
INNER JOIN CEH26_PositionCatalog P
    ON E.Position_ID = P.Position_ID
WHERE E.Salary < P.Min_Salary
   OR E.Salary > P.Max_Salary
ORDER BY E.Staff_ID;


-- QUERY 5: EMPLOYEE COUNT BY DEPARTMENT AND JOB TITLE
SELECT
    D.Department_Name,
    P.Title_Name,
    COUNT(E.Staff_ID) AS Employee_Count
FROM CEH26_OrgUnitRegistry D
INNER JOIN CEH26_WorkforceLedger E
    ON D.Dept_ID = E.Dept_ID
INNER JOIN CEH26_PositionCatalog P
    ON E.Position_ID = P.Position_ID
GROUP BY D.Department_Name, P.Title_Name
ORDER BY D.Department_Name, P.Title_Name;
