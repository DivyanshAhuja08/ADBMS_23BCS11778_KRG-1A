/*
THE MIN NUMBER OF TABLES REQUIRS FOR JOINS AS WELL AS FK: 1
COND: ATLEAST ONE COMMON COLUMN SHOULD BE THERE(NAME FO THE COL CAN BE DIFF/ VALUES SHOULD BE SAME ((ATLEAST 1))

TYPES:
	1. INNER JOIN: COMMON DATA ONLY (ONLY THE MATCHING RECORDS)
	2. LEFT OUTER JOIN: LEFT TABLE WHOLE DATA + COMMON DATA
	3. RIGHT OUTER JOIN
	4. FULL OUTER JOIN : L + R + COMMON DATA
	5. SELF JOIN (TABLE)
	6. LEFT EXCLUSIVE JOIN
	7. RIGHT EXCLUSIVE JOIN
*/
--SYNTAX:
--USE SQUARE BRACKETS IF YOU WANT TO GIVE NAME TO THE COLUMN
CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    ManagerID INT NULL  -- Self-reference to EmpID
);


ALTER TABLE Employee
ADD CONSTRAINT FK_Manager FOREIGN KEY (ManagerID) REFERENCES Employee(EmpID);


-- Insert data into Employee table
INSERT INTO Employee (EmpID, EmpName, Department, ManagerID)
VALUES
(1, 'Alice', 'HR', NULL),        -- Top-level manager
(2, 'Bob', 'Finance', 1),
(3, 'Charlie', 'IT', 1),
(4, 'David', 'Finance', 2),
(5, 'Eve', 'IT', 3),
(6, 'Frank', 'HR', 1);

SELECT E1.EmpName AS [EMPLOYEEE_NAME], E2.EmpName AS [MANAGER_NAME], E1.Department AS [EMP_DEPT], E2.Department AS [MANAGER_DEPT]
FROM EMPLOYEE AS E1
INNER JOIN 
EMPLOYEE AS E2
ON
E1.ManagerID = E2.EmpID; --always put foreign key column on the left side always works 

--Hard Question
create table Year_tbl(
ID INT not null,
Year INT,
NPV INT
);
create table Queries_tbl(
ID int NOT NULL,
Year INT
);
insert into Year_tbl(ID,Year,NPV) values
(1,2018,100),
(7,2020,30),
(13,2019,40),
(1,2019,113),
(2,2008,121),
(3,2009,112),
(11,2020,99),
(7,2019,0)

insert into Queries_tbl(ID,Year) values 
(1,2019),
(2,2008),
(3,2009),
(7,2018),
(7,2019),
(7,2020),
(13,2019)

SELECT 
    Y.ID AS [ID],
    Y.Year AS [Year],
    ISNULL(Q.NPV, 0) AS [NPV]
FROM 
    Queries_tbl AS Y
LEFT OUTER JOIN 
    Year_tbl AS Q 
ON 
    Y.ID = Q.ID AND Y.Year = Q.Year;
