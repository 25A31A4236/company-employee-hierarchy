# Company Employee Hierarchy Database

## Overview
A SQL Server project designed to manage a company's organizational structure, employee information, job positions, and reporting relationships.

## Objectives
- Manage departments and job positions.
- Store employee details and salary information.
- Represent manager–employee relationships using a self-referencing foreign key.
- Generate department-wise salary reports.
- Display the complete organizational hierarchy.

## Database Tables

| Table | Description |
|---|---|
| `CEH26_OrgUnitRegistry` | Stores department names and locations |
| `CEH26_PositionCatalog` | Stores job titles and salary ranges |
| `CEH26_WorkforceLedger` | Stores employees, salaries, departments, positions, and manager IDs |

## SQL Concepts Used
- Primary and foreign keys
- Self-referencing foreign keys
- Self-joins
- `DEFAULT` and `CHECK` constraints
- Aggregate functions: `COUNT`, `AVG`, `SUM`, `MIN`, `MAX`
- `GROUP BY` and subqueries
- Recursive Common Table Expressions (CTEs)

## Project Structure

```text
company-employee-hierarchy/
├── README.md
└── sql/
    ├── 01_create_tables.sql
    ├── 02_insert_sample_data.sql
    ├── 03_employee_manager_self_join.sql
    ├── 04_department_salary_reports.sql
    └── 05_recursive_hierarchy.sql
```

## How to Run
1. Open Microsoft SQL Server Management Studio (SSMS).
2. Connect to your SQL Server instance and select your project database.
3. Execute `01_create_tables.sql`.
4. Execute `02_insert_sample_data.sql` once on the empty tables.
5. Execute the remaining query files to explore employee relationships, salary reports, and the reporting hierarchy.

## Main Query Example

```sql
SELECT
    E.First_Name + ' ' + E.Last_Name AS Employee_Name,
    M.First_Name + ' ' + M.Last_Name AS Manager_Name
FROM CEH26_WorkforceLedger E
LEFT JOIN CEH26_WorkforceLedger M
    ON E.Reports_To = M.Staff_ID;
```

## Technologies
- Microsoft SQL Server
- T-SQL
- GitHub

## Author
Created as a SQL database portfolio project.
