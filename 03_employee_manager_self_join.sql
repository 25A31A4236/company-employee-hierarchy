
/*
PROJECT: Company Employee Hierarchy Database
FILE: 03_employee_manager_self_join.sql
*/

-- QUERY 1: EACH EMPLOYEE AND THEIR DIRECT MANAGER
SELECT
    E.Staff_ID,
    E.First_Name + ' ' + E.Last_Name AS Staff_Name,
    M.First_Name + ' ' + M.Last_Name AS Manager_Name,
    E.Salary
FROM CEH26_WorkforceLedger E
LEFT JOIN CEH26_WorkforceLedger M
    ON E.Reports_To = M.Staff_ID
ORDER BY E.Staff_ID;


-- QUERY 2: EMPLOYEES WHO EARN MORE THAN THEIR MANAGERS
SELECT
    E.First_Name + ' ' + E.Last_Name AS Staff_Name,
    E.Salary AS Staff_Salary,
    M.First_Name + ' ' + M.Last_Name AS Manager_Name,
    M.Salary AS Manager_Salary
FROM CEH26_WorkforceLedger E
INNER JOIN CEH26_WorkforceLedger M
    ON E.Reports_To = M.Staff_ID
WHERE E.Salary > M.Salary
ORDER BY E.Salary DESC;


-- QUERY 3: EMPLOYEES REPORTING DIRECTLY TO THE CEO
SELECT
    E.Staff_ID,
    E.First_Name + ' ' + E.Last_Name AS Staff_Name,
    M.First_Name + ' ' + M.Last_Name AS Manager_Name
FROM CEH26_WorkforceLedger E
INNER JOIN CEH26_WorkforceLedger M
    ON E.Reports_To = M.Staff_ID
INNER JOIN CEH26_PositionCatalog P
    ON M.Position_ID = P.Position_ID
WHERE P.Title_Name = 'CEO';


-- QUERY 4: DISPLAY STAFF WITH DEPARTMENT AND JOB TITLE
SELECT
    E.Staff_ID,
    E.First_Name + ' ' + E.Last_Name AS Staff_Name,
    D.Department_Name,
    P.Title_Name,
    E.Salary
FROM CEH26_WorkforceLedger E
INNER JOIN CEH26_OrgUnitRegistry D
    ON E.Dept_ID = D.Dept_ID
INNER JOIN CEH26_PositionCatalog P
    ON E.Position_ID = P.Position_ID
ORDER BY D.Department_Name, E.Salary DESC;
