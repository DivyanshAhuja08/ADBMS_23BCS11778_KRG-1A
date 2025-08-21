/*
-----experiment 03:sub queries----------------
1. Nested queries /sub queries 
eg: q1 connect (q2(q3)) -- inner query
--main query / outer query
execution order: q3>q2>q1;

special operator /connectors
1. =: 9,AMAN ,109.67 <,>,<=,>= ,!= (<>)
2. IN SQ RETURN CITY MULTIPLE ROWS
EG:WHERE CITY IN(A,B,C)

3.NOT IN;
4. ANY(OR)
5.ALL(AND)


2.TYPE OF SUB-QUERIES
1. SCALER SQ:WHICH RETURN ONLY ONE  ROW
  OPERATORS:<,>,<=,>= ,(!= (<>))
2. MULTI -VALUES /MULTI-ROW:WHICH RETURN ONLY MULTIPLE ROW/VALUES
OPERATOR: IN,NOT IN,ANY,ALL
3.SELF-CONTAINED SQ :WHICH DO NOT HAVE DEPENDENCY ON OUTER QUERY
4.CO-RELATED SQ:
WHICH DEPENDS  ON OUTER QUERY
 Q1(Q2)

 3. PLACEMENT OF SQ;
   1. SQ WITH IN THE WHERE CLAUSE
   2. SQ WITH THE SELECT COMMAND (ALIAS)
   3. SQ IN FROM CLAUSE (ALIAS
*/

INPUT TABLES:

CREATE TABLE MyEmployees (
    EmpId INT PRIMARY KEY IDENTITY(1,1),
    EmpName VARCHAR(50),
    Gender VARCHAR(10),t
    Salary INT,A
    City VARCHAR(50),
    Dept_id INT
);


INSERT INTO MyEmployees (EmpName, Gender, Salary, City, Dept_id)
VALUES
('Amit', 'Male', 50000, 'Delhi', 2),
('Priya', 'Female', 60000, 'Mumbai', 1),
('Rajesh', 'Male', 45000, 'Agra', 3),
('Sneha', 'Female', 55000, 'Delhi', 4),
('Anil', 'Male', 52000, 'Agra', 2),
('Sunita', 'Female', 48000, 'Mumbai', 1),
('Vijay', 'Male', 47000, 'Agra', 3),
('Ritu', 'Female', 62000, 'Mumbai', 2),
('Alok', 'Male', 51000, 'Delhi', 1),
('Neha', 'Female', 53000, 'Agra', 4),
('Simran', 'Female', 33000, 'Agra', 3);


create table dept(
	id int unique not null, 
	Dept_Name varchar(20) not null
)

insert into dept values(1, 'Accounts');
insert into dept values(2, 'HR');
insert into dept values(3, 'Admin');
insert into dept values(4, 'Counselling');


/*
	0. IN JOINS, CATESIAN PRODUCT: 
	1. NESTED QUERIES / QUERY INSIDE A QUERY
		Q1 (Q2 (Q3) - 9, AMAN) - INNER QUERY
		MAIN QUERY / OUTER QUERY

	2. EXECUTION ORDER:  Q3 > Q2 > Q1

	3. THE OPERATORS / (CONNECTORS) USED WITH SQ:
			1. =,<,>, != (<>): SUB RETURNING ONE OUTPUT
			2. IN: SQ IS RETURNING MORE THAN ONE OUTPUT
					WHERE CITY IN ('A','B','C')
			3. NOT IN
			4. ANY (OR)
			5. ALL (AND)




	4. TYPES OF SUB-QUEREIS
			1. SCALER SUB-QUERY: WHICH RETURNS ONLY ONE OUTPUT, 8,109.67, AMAN
				OPERATORS: =,<,>, != (<>)
			
			2. MULTI-ROW / MULTI-VALUED SQ: WHCIH RETURNS MULTIPLE ROWS
				OPERATORS: IN, NOT IN, ANY, ALL


			3. SELF-CONTAINED SQ: WHICH HAS NO DEPENDENCY ON OUTER QUERY
					EG: Q1 (Q2->Q1)

			4. CO-RELATED SQ: WHICH HAS DEPENDENCY ON OUTER QUERY
				EG: Q1 (<-Q2)


		5. PLACEMENT OF SUB-QUERIES
			1. SQ WITH WHERE CLAUSE
			2. SQ IN SELECT COMMAND
			2. SQ IN FROM CLAUSE

			START SQ: (SQ)
*/

USE SUB_QUERIES

SELECT *FROM MyEmployees
--FIND THE 2ND HIGHEST SALARY
/*
	AGG FUN: SUM, COUNT, MIN, MAX, AVG
	1. FIND THE MAX SALARY -- X
	2. FIND THE MAX SALARY BUT EXCLUDING X
*/

SELECT MAX(SALARY) FROM MyEmployees
WHERE SALARY NOT IN
(SELECT MAX(SALARY) FROM MyEmployees)

/*
TYPES OF SUB-QUEREIS
			1. SCALER SUB-QUERY: WHICH RETURNS ONLY ONE OUTPUT, 8,109.67, AMAN
				OPERATORS: =,<,>, != (<>)
			
			2. MULTI-ROW / MULTI-VALUED SQ: WHCIH RETURNS MULTIPLE ROWS
				OPERATORS: IN, NOT IN, ANY, ALL


			3. SELF-CONTAINED SQ: WHICH HAS NO DEPENDENCY ON OUTER QUERY
					EG: Q1 (Q2->Q1)

			4. CO-RELATED SQ: WHICH HAS DEPENDENCY ON OUTER QUERY
				EG: Q1 (<-Q2)

*/

--1. SCALER SQ: RETRUN ONE OUTPUT
SELECT *FROM MyEmployees 
SELECT *FROM DEPT

--WE CAN REPLACE JOINS WITH SQ

SELECT *FROM MyEmployees 
WHERE DEPT_ID =
(SELECT ID FROM DEPT WHERE DEPT_NAME ='Accounts')
--NOTE: WHICHEVER COL TYPES USED WITH OUTER QUERY -> THE SAME DATATYPE COL SHOULD BE USED IN
--SQ


--2. MULTI-ROW SQ:

SELECT *FROM MyEmployees WHERE EMPNAME IN
(SELECT EmpName FROM MyEmployees)

SELECT *FROM MyEmployees


--3. SELF CONTAINED SUB-QUERY
SELECT *FROM MyEmployees 
WHERE DEPT_ID =
(SELECT ID FROM DEPT WHERE DEPT_NAME ='Accounts'
)
  
--4. CO-RELATED SQ: VS JOINS
/*
	1. WE HAVE TO USE ALIAS
	2. CO-RELATED SQ CREATES A MORE OVERHEAD, ALSO THEY ARE AVOIDED

*/

SELECT *FROM MyEmployees AS E
WHERE E.DEPT_ID IN
(SELECT D.ID FROM DEPT AS D WHERE E.GENDER = 'Male')


/*
-- experiment 03: (easy)------
ps : generate an employee realtion with only on attrubute i.e,emp_id
    employee id(Emp_id)
	  2
	  4
	  4
	  6
	  6
	  7
	  8
	  8

task : find the max emp_id but excluding the duplicates
output: 7
*/

create database subquires
use subquires

create table  tbl_employee(
emp_id int 
);

insert into tbl_employee values(2),(4),(4),(6),(6),(7),(8),(8);

select * from tbl_employee

select max(emp_id) AS EMPID from tbl_employee where emp_id not in 
(select emp_id from tbl_employee 
group by emp_id
having count(emp_id)>1) --4,6,8


--- task: find  the id ,name ,description of product which has not been sold for once
--- output: id 1, name, description
CREATE TABLE TBL_PRODUCTS
(
	ID INT PRIMARY KEY IDENTITY,
	[NAME] NVARCHAR(50),
	[DESCRIPTION] NVARCHAR(250) 
)

CREATE TABLE TBL_PRODUCTSALES
(
	ID INT PRIMARY KEY IDENTITY,
	PRODUCTID INT FOREIGN KEY REFERENCES TBL_PRODUCTS(ID),
	UNITPRICE INT,
	QUALTITYSOLD INT
)

INSERT INTO TBL_PRODUCTS VALUES ('TV','52 INCH BLACK COLOR LCD TV')
INSERT INTO TBL_PRODUCTS VALUES ('LAPTOP','VERY THIIN BLACK COLOR ACER LAPTOP')
INSERT INTO TBL_PRODUCTS VALUES ('DESKTOP','HP HIGH PERFORMANCE DESKTOP')


INSERT INTO TBL_PRODUCTSALES VALUES (3,450,5)
INSERT INTO TBL_PRODUCTSALES VALUES (2,250,7)
INSERT INTO TBL_PRODUCTSALES VALUES (3,450,4)
INSERT INTO TBL_PRODUCTSALES VALUES (3,450,9)


SELECT *FROM TBL_PRODUCTS
SELECT *FROM TBL_PRODUCTSALES

select id,[name],[description] from TBL_PRODUCTS where id not in
(select distinct PRODUCTID from TBL_PRODUCTSALES )




--task 02: find the total quantity sold for each respective product 
-- ouput : name   qty_sold(sum)
 --          A           15
 -- you will use sq in select clause

 select distinct sum(QUALTITYSOLD) from TBL_PRODUCTSALES
 select [Name], (select sum(QUALTITYSOLD) from TBL_PRODUCTSALES where PRODUCTID= TBL_PRODUCTS.ID) as [Qty_sold]
 from TBL_PRODUCTS


  /*
		----------------SET OPERATIONS IN SQL------------
		SET = TABLE

		OPERATION:
		1. UNION
		2. UNION ALL
		3. INTERSECT (INNER JOIN)
		4. (A-B): EXCEPT


		GENERAL RULES:
		1. WHICHEVER COLM INVOLED IN THE OPERATION MUST HAVE SAME DATATYPE
				SELECT *FROM A
				UNION
				SELECT *FROM B

				SELECT ID, NAME FROM A
				UNION
				SELECT NAME, ID FROM B




	 */

	 SELECT *FROM HockeyParticipants
	 EXCEPT
	 SELECT *FROM FootballParticipants

	 --ERROR CASE
	 SELECT ID, NAME FROM HockeyParticipants
	 EXCEPT
	 SELECT NAME, ID FROM FootballParticipants



	 SELECT ID, NAME FROM HockeyParticipants
	 UNION
	 SELECT ID, EMAIL FROM FootballParticipants