	CREATE DATABASE CorpDataDB
	USE CorpDataDB

	Create Table Employees
	(
	EmpID int PRIMARY KEY IDENTITY(1,1),
	Name VARCHAR(50),
	Department VARCHAR(50),
	Salary DECIMAL(10,2),
	JoinDate DATE NOT NULL
	)
	INSERT INTO Employees VALUES('Ankur verma','IT',75000,'2022-01-15'),
	('Ashish verma','Finance',65000,'2021-11-20'),
	('Dishant Gautam','Administration',75000,'2020-06-10'),
	('Ravi Sharma','Audit',50000,'2023-03-25')

	SELECT * FROM Employees

	-- Triggers

	CREATE TRIGGER InsteadOf_Employee_Insert
	ON Employees
	INSTEAD OF INSERT
	AS
	BEGIN
		SET NOCOUNT ON;
    
		INSERT INTO Employees (Name, Department, Salary, JoinDate)
		SELECT Name, Department, 
			   CASE 
				   WHEN Salary < 0 THEN 0 
				   ELSE Salary 
			   END, 
			   JoinDate
		FROM inserted;
	END;

	INSERT INTO Employees VALUES('Ankur verma','IT',-50000,'2023-06-01')

	SELECT * FROM Employees WHERE Name = 'Ankur verma'

	-- Using an AFTER INSERT Trigger
	-- This trigger updates the salary after the record is inserted.

	CREATE TRIGGER After_Employee_Insert
	ON Employees
	AFTER INSERT
	AS
	BEGIN
		SET NOCOUNT ON

		UPDATE Employees
		SET Salary = 0
		WHERE Salary < 0
	END

	INSERT INTO Employees VALUES('Ankur verma','HR',-10000,'2023-06-05')

	SELECT * FROM Employees WHERE Name = 'Ankur verma'

	SELECT * FROM Employees

	-- VIEWS

	CREATE VIEW IT_Employees AS
	SELECT EmpID, Name, Salary FROM Employees WHERE Department = 'IT'

	SELECT * FROM Employees

	-- High-Paid Employees

	CREATE VIEW HighPaidEmployee AS
	SELECT Name, Department, Salary
	FROM Employees
	WHERE Salary > (SELECT AVG(Salary) FROM Employees)

	SELECT * FROM HighPaidEmployee

	-- INDEXING
	-- Basic Index: Single Column Index

	CREATE INDEX idx_department ON Employees(Department)

	-- Advanced Index: Composite Index

	CREATE INDEX idx_name_salary ON Employees(Name, Salary)

	-- Testing Index Performance

	SELECT * FROM Employees WHERE Department = 'IT'

