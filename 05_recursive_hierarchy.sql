
/*
PROJECT: Company Employee Hierarchy Database
FILE: 05_recursive_hierarchy.sql
*/

-- QUERY 1: COMPLETE COMPANY REPORTING HIERARCHY
;WITH EmployeeHierarchy AS (
    -- Anchor: start with employees who have no manager.
    SELECT
        E.Staff_ID,
        E.First_Name,
        E.Last_Name,
        E.Reports_To,
        0 AS Hierarchy_Level,
        CAST(
            E.First_Name + ' ' + E.Last_Name
            AS VARCHAR(1000)
        ) AS Reporting_Path
    FROM CEH26_WorkforceLedger E
    WHERE E.Reports_To IS NULL

    UNION ALL

    -- Recursive member: find each employee's direct reports.
    SELECT
        E.Staff_ID,
        E.First_Name,
        E.Last_Name,
        E.Reports_To,
        H.Hierarchy_Level + 1,
        CAST(
            H.Reporting_Path + ' > ' +
            E.First_Name + ' ' + E.Last_Name
            AS VARCHAR(1000)
        )
    FROM CEH26_WorkforceLedger E
    INNER JOIN EmployeeHierarchy H
        ON E.Reports_To = H.Staff_ID
)
SELECT
    Staff_ID,
    REPLICATE('    ', Hierarchy_Level)
        + First_Name + ' ' + Last_Name AS Employee,
    Reports_To AS Manager_ID,
    Hierarchy_Level,
    Reporting_Path
FROM EmployeeHierarchy
ORDER BY Reporting_Path
OPTION (MAXRECURSION 100);


-- QUERY 2: FIND ALL DIRECT REPORTS OF A SPECIFIC MANAGER
DECLARE @ManagerID INT = 2;

SELECT
    E.Staff_ID,
    E.First_Name + ' ' + E.Last_Name AS Staff_Name,
    E.Salary
FROM CEH26_WorkforceLedger E
WHERE E.Reports_To = @ManagerID
ORDER BY E.Last_Name, E.First_Name;


-- QUERY 3: COUNT DIRECT REPORTS FOR EACH MANAGER
SELECT
    M.Staff_ID AS Manager_ID,
    M.First_Name + ' ' + M.Last_Name AS Manager_Name,
    COUNT(E.Staff_ID) AS Direct_Report_Count
FROM CEH26_WorkforceLedger M
LEFT JOIN CEH26_WorkforceLedger E
    ON E.Reports_To = M.Staff_ID
GROUP BY M.Staff_ID, M.First_Name, M.Last_Name
HAVING COUNT(E.Staff_ID) > 0
ORDER BY Direct_Report_Count DESC;
