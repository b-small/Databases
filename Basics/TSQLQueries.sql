-- Problem 1 - Create a database with two tables
CREATE TABLE Persons 
(id int NOT NULL IDENTITY,
FirstName nvarchar(50) NOT NULL,
LastName nvarchar(50) NOT NULL,
SSN nvarchar(50),
PRIMARY KEY(id))
GO

CREATE TABLE Accounts 
(id int NOT NULL IDENTITY,
PersonID int NOT NULL,
Balance decimal(18,2) DEFAULT 0,
PRIMARY KEY(id),
FOREIGN KEY(PersonId)
REFERENCES Persons(id))
GO

INSERT INTO Persons(FirstName, LastName, SSN)
VALUES ('Stamat', 'Palamarkov', '2323'),
	   ('Gergin', 'Gergov', '6935'),
	   ('Goca', 'Gergova', '22323')
GO

INSERT INTO Accounts(PersonID, Balance)
VALUES (3, 200.34),
	   (2, 34213.4),
	   (1, 4534.6)
GO

CREATE PROCEDURE usp_selectFullName
AS
SELECT FirstName + ' ' + LastName as FullName
FROM Persons
GO

EXEC usp_selectFullName;
GO

-- Problem 2 - create a stored procedure that accepts a number as a parameter 
-- and returns all persons who have more money in their accounts than the supplied number.
CREATE PROCEDURE usp_selectByBalance @MinBalance float
AS
SELECT *
FROM Persons p 
JOIN Accounts a
ON a.PersonID = p.id
WHERE a.Balance > @MinBalance
GO

EXEC usp_selectByBalance @MinBalance = 201
GO

--Problem 3 - create a function that accepts as parameters – sum, yearly interest rate and number of months
-- and calculates the new sum

CREATE FUNCTION ufnNewSum(@Sum float, @YearlyIntRate float, @Months int)
RETURNS float
AS
BEGIN
	DECLARE @NewSum float
	SELECT @NewSum = POWER(@Sum*(1+(@YearlyIntRate/12)),@Months);
	IF(@NewSum IS NULL)
		SET @NewSum = 0;
	RETURN @NewSum;
END;
GO

-- Test the created function 
SELECT p.FirstName, dbo.ufnNewSum(a.Balance, 1.4, 1)
FROM Persons p
JOIN Accounts a
ON a.PersonID = p.id
GO

-- Problem 4 - create a stored procedure that uses the function from the previous example
CREATE PROCEDURE usp_calcNewSum(@AccountId int, @InterestRate float)
	AS
	SELECT dbo.ufnNewSum(a.Balance, @InterestRate, 1)
	FROM Accounts a
	WHERE a.id = @AccountId
GO

EXEC usp_calcNewSum @AccountId = 1, @InterestRate = 1.8;
GO

-- Problem 5
CREATE PROCEDURE usp_WithdrawMoney(@AccountId int, @Money float)
AS
	UPDATE Accounts
	SET Balance -= @Money
	FROM Accounts 
	WHERE id = @AccountId
GO

CREATE PROCEDURE usp_DepositMoney(@AccountId int, @Money float)
AS
	UPDATE Accounts
	SET Balance += @Money
	FROM Accounts 
	WHERE id = @AccountId
GO

-- TEST
EXEC usp_WithdrawMoney @AccountId = 1, @Money = 200;
GO

SELECT * 
FROM Accounts
WHERE id = 1

EXEC usp_DepositMoney @AccountId = 1, @Money = 200;
GO

-- Problem 6 - Create table Logs
CREATE TABLE Logs(
LogId int IDENTITY,
AccountId int,
OldSum decimal(18,2),
NewSum decimal(18,2),
PRIMARY KEY (LogId),
FOREIGN KEY (AccountId)
REFERENCES Accounts(id)
)
GO

-- Add a trigger to the Accounts table that enters a new entry 
-- into the Logs table every time the sum on an account changes
CREATE TRIGGER tr_UpdateLogOnBalance ON Accounts FOR UPDATE
AS
	DECLARE @OldSum float;
	SELECT @OldSum = Balance FROM deleted;

	INSERT INTO Logs(AccountId, OldSum, NewSum)
		SELECT id, @OldSum, Balance
		FROM inserted
GO

-- Test
EXEC usp_WithdrawMoney 2, 200
EXEC usp_DepositMoney 1, 40000

SELECT * FROM Logs

-- Problem 7 - Define a function in the database SoftUni that returns 
-- all Employee's names (first or middle or last name) and all town's 
-- names that are comprised of given set of letters. 
USE SoftUni
GO

CREATE FUNCTION dbo.udf_setOfLettersSelect(
		@Word NVARCHAR(MAX),
        @Pattern NVARCHAR(MAX)
)
RETURNS BIT
AS BEGIN
        DECLARE @index INT = 1;
        WHILE (@index <= LEN(@Word))
        BEGIN
        IF ( @Pattern NOT LIKE '%' + SUBSTRING(@Word, @index, 1) + '%' ) 
		BEGIN  
                RETURN 0
        END
        SET @index = @index + 1
    END
        RETURN 1
END
GO
-- DROP FUNCTION dbo.ufn_setOfLettersSelect
-- DROP FUNCTION dbo.ufn_AllMatchingNames

CREATE FUNCTION ufn_AllMatchingNames(@pattern nvarchar(255))
	RETURNS @MatchingNames TABLE (Name nvarchar(100))
AS
BEGIN 
	INSERT @MatchingNames
	SELECT * FROM
		(SELECT e.FirstName
		FROM Employees e
		UNION 
		SELECT e.LastName
		FROM Employees e
		UNION
		SELECT e.MiddleName
		FROM Employees e
		UNION
		SELECT t.name
		FROM Towns t) as temp(Name)
	WHERE 1 = dbo.udf_setOfLettersSelect(LOWER(Name), @pattern) AND Name IS NOT NULL
	RETURN
END
GO


--Test
SELECT * 
FROM ufn_AllMatchingNames('nvkoayug')
SELECT * 
FROM ufn_AllMatchingNames('remdno')
GO

-- Problem 8 - using database cursor write a T-SQL script that scans all employees 
-- and their addresses and prints all pairs of employees that live in the same town

-- Problem 9 - Define a .NET aggregate function StrConcat that takes as input a 
-- sequence of strings and return a single string that consists of the input strings separated by ','
CREATE AGGREGATE StrConcat(@Sequence nvarchar(200))
RETURNS nvarchar(200)
	BEGIN

	END
	GO


