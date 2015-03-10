-- Problem 1

SELECT PeakName
FROM Peaks
ORDER BY PeakName

-- Problem 2

SELECT TOP 30 CountryName, Population
FROM Countries
WHERE ContinentCode = 'EU'
ORDER BY Population DESC

-- Problem 3

SELECT CountryName, CountryCode, 
CASE 
	WHEN CurrencyCode = 'EUR'
	THEN 'Euro'
	ELSE 'Not Euro'
	END as Currency
FROM Countries
ORDER BY CountryName

-- Problem 4

SELECT CountryName as 'Country Name', IsoCode as 'ISO Code'
FROM Countries
WHERE 
(SELECT LEN(CountryName) - LEN(REPLACE(LOWER(CountryName), 'a', ''))) > 2
ORDER BY IsoCode

-- Problem 5

SELECT p.PeakName, m.MountainRange as Mountain, p.Elevation
FROM Peaks p
JOIN Mountains m
ON p.MountainId = m.Id
ORDER BY p.Elevation DESC, p.PeakName

-- Problem 6

SELECT PeakName, m.MountainRange as Mountain, c.CountryName, cont.ContinentName
FROM Peaks p
JOIN Mountains m
ON p.MountainId = m.Id
JOIN MountainsCountries mc
ON m.Id = mc.MountainId
JOIN Countries c
ON mc.CountryCode = c.CountryCode
JOIN Continents cont
ON c.ContinentCode = cont.ContinentCode
ORDER BY p.PeakName, c.CountryName

-- Problem 7

SELECT r.RiverName as River, COUNT(c.CountryCode) as [Countries Count]
FROM Rivers r
JOIN CountriesRivers cr
ON r.Id = cr.RiverId
JOIN Countries c
ON c.CountryCode = cr.CountryCode
GROUP BY r.RiverName
HAVING COUNT(c.CountryCode) >= 3
ORDER BY r.RiverName

-- Problem 8

SELECT 
MAX(Elevation) as [MaxElevation],
MIN(Elevation) as [MinElevation],
AVG(Elevation) as [AverageElevation]
FROM Peaks 

-- Problem 9

SELECT 
c.CountryName, 
cont.ContinentName, 
(CASE 
 WHEN COUNT(r.Id) IS NULL
 THEN 0
 ELSE COUNT(r.Id)
 END)
  as [RiversCount], 
(CASE 
	WHEN COUNT(r.Id) > 0 
	THEN SUM(r.Length)
	ELSE 0
 END)
	 as [TotalLength]
FROM Countries c
LEFT JOIN CountriesRivers cr
ON c.CountryCode = cr.CountryCode
LEFT JOIN Rivers r
ON cr.RiverId = r.Id
LEFT JOIN Continents cont
ON c.ContinentCode = cont.ContinentCode
GROUP BY c.CountryName, cont.ContinentName
ORDER BY [RiversCount] DESC, [TotalLength] DESC, c.CountryName

--Problem 10

SELECT curr.CurrencyCode, curr.Description as Currency,
COUNT(countr.CountryCode) as NumberOfCountries
FROM Currencies curr
LEFT JOIN Countries countr
ON countr.CurrencyCode = curr.CurrencyCode
GROUP BY curr.CurrencyCode, curr.Description
ORDER BY NumberOfCountries DESC, curr.Description

-- Problem 11

SELECT 
cont.ContinentName, 
SUM(countr.AreaInSqKm) as CountriesArea,
SUM(CAST(countr.Population as bigint)) as CountriesPopulation
FROM Continents cont
JOIN Countries countr
ON cont.ContinentCode = countr.ContinentCode
GROUP BY cont.ContinentName
ORDER BY CountriesPopulation DESC

-- Problem 12

SELECT 
c.CountryName, 
MAX(p.Elevation) as [HighestPeakElevation],
MAX(r.Length) as [LongestRiverLength]
FROM Countries c
LEFT JOIN MountainsCountries mc
ON c.CountryCode = mc.CountryCode
LEFT JOIN Peaks p
ON p.MountainId = mc.MountainId
LEFT JOIN CountriesRivers cr
ON cr.CountryCode = c.CountryCode
LEFT JOIN Rivers r
ON cr.RiverId = r.Id
GROUP BY c.CountryName
ORDER BY [HighestPeakElevation] DESC, [LongestRiverLength] DESC, c.CountryName


-- Problem 13

SELECT p.PeakName, r.RiverName, LOWER(p.PeakName) + SUBSTRING(LOWER(r.RiverName), 2, LEN(r.RiverName)) as [Mix]
FROM Peaks p
JOIN Rivers r
ON RIGHT(LOWER(p.PeakName), 1) = LEFT(LOWER(r.RiverName), 1)
ORDER BY [Mix]


-- Problem 14
/*
SELECT 
c.CountryName as Country,
p.PeakName as [Highest Peak Name],
p.Elevation as [Highest Peak Elevation],
m.MountainRange as Mountain
FROM Countries c
JOIN MountainsCountries mc
ON mc.CountryCode = c.CountryCode
JOIN Mountains m
ON mc.MountainId = m.Id
JOIN Peaks p
ON m.Id = p.Id
GROUP BY c.CountryName, p.PeakName, p.Elevation, m.MountainRange
HAVING p.Elevation = MAX(p.Elevation)*/

-- Problem 15

CREATE TABLE Monasteries(
Id int IDENTITY,
Name nvarchar(max) NOT NULL,
CountryCode char(2),
PRIMARY KEY(Id),
FOREIGN KEY(CountryCode)
REFERENCES Countries
)

INSERT INTO Monasteries(Name, CountryCode) VALUES
('Rila Monastery “St. Ivan of Rila”', 'BG'), 
('Bachkovo Monastery “Virgin Mary”', 'BG'),
('Troyan Monastery “Holy Mother''s Assumption”', 'BG'),
('Kopan Monastery', 'NP'),
('Thrangu Tashi Yangtse Monastery', 'NP'),
('Shechen Tennyi Dargyeling Monastery', 'NP'),
('Benchen Monastery', 'NP'),
('Southern Shaolin Monastery', 'CN'),
('Dabei Monastery', 'CN'),
('Wa Sau Toi', 'CN'),
('Lhunshigyia Monastery', 'CN'),
('Rakya Monastery', 'CN'),
('Monasteries of Meteora', 'GR'),
('The Holy Monastery of Stavronikita', 'GR'),
('Taung Kalat Monastery', 'MM'),
('Pa-Auk Forest Monastery', 'MM'),
('Taktsang Palphug Monastery', 'BT'),
('Sümela Monastery', 'TR')

--Task 3
ALTER TABLE Countries
ADD IsDeleted bit DEFAULT 0

-- Task 4
UPDATE Countries 
SET IsDeleted = 1
WHERE CountryCode IN (SELECT c.CountryCode
FROM Countries c
JOIN CountriesRivers cr
ON c.CountryCode = cr.CountryCode
JOIN Rivers r
ON cr.RiverId = r.Id
GROUP BY c.CountryCode
HAVING COUNT(r.Id) > 3)

-- Task 5

SELECT m.Name as Monastery, c.CountryName as Country
FROM Monasteries m
LEFT JOIN Countries c
ON m.CountryCode = c.CountryCode
WHERE c.IsDeleted = 0
ORDER BY m.Name

-- Problem 16

-- Task 1
UPDATE Countries
SET CountryName = 'Burma'
WHERE CountryName = 'Myanmar'

-- Task 2
INSERT INTO Monasteries(Name, CountryCode)
VALUES ('Hanga Abbey', (SELECT CountryCode FROM Countries WHERE CountryName = 'Tanzania'))

INSERT INTO Monasteries(Name, CountryCode)
VALUES ('Myin-Tin-Daik', (SELECT CountryCode FROM Countries WHERE CountryName = 'Myanmar'))

--Task 4

SELECT cont.ContinentName, countr.CountryName, COUNT(m.Id) as MonasteriesCount
FROM Continents cont
LEFT JOIN Countries countr
ON cont.ContinentCode = countr.ContinentCode
LEFT JOIN Monasteries m
ON m.CountryCode = countr.CountryCode
GROUP BY cont.ContinentName, countr.CountryName, countr.IsDeleted
HAVING countr.IsDeleted = 0
ORDER BY MonasteriesCount DESC, countr.CountryName

-- Problem 17


IF (object_id(N'fn_MountainsPeaksJSON') IS NOT NULL)
DROP FUNCTION fn_MountainsPeaksJSON
GO

CREATE FUNCTION fn_MountainsPeaksJSON()
RETURNS NVARCHAR(MAX)
AS
	BEGIN
		DECLARE MountainsCursor CURSOR FOR
			SELECT MountainRange FROM Mountains
			--ORDER BY MountainRange
		OPEN MountainsCursor

		DECLARE
			@JSON NVARCHAR(MAX) = '{"mountains":[',
			@mountain NVARCHAR(MAX)
		FETCH NEXT FROM MountainsCursor INTO @mountain;
			
		WHILE @@FETCH_STATUS = 0
		BEGIN
		SELECT @JSON += '{"name":"' + @mountain + '","peaks":[';
			DECLARE @peaks NVARCHAR(MAX) = '';
				SELECT
				@peaks = CASE
				WHEN @peaks IS NULL THEN CONVERT(NVARCHAR(MAX), PeakName, 112)
				ELSE  @peaks + '{"name":"'+ CONVERT(NVARCHAR(MAX), PeakName, 112) +
				  '","elevation":' + CONVERT(NVARCHAR(MAX), Elevation, 112) + '},'
				  
				END
			FROM Peaks p
			JOIN Mountains m
			ON p.MountainId = m.Id 
			WHERE m.MountainRange = @mountain
			--ORDER BY p.PeakName
			--@peaks = SUBSTRING(@peaks, 1, LEN(@peaks
			SELECT @JSON += @peaks + ']},';		
			FETCH NEXT FROM MountainsCursor INTO @mountain;
			END;

			CLOSE MountainsCursor;
			DEALLOCATE MountainsCursor;
			
		RETURN SUBSTRING(@JSON,1,LEN(@JSON)-1) + ']}';
	END
	GO

	SELECT dbo.fn_MountainsPeaksJSON()

	-- Problem 14
	SELECT c.CountryName as Country,
	 (CASE
	WHEN p.PeakName is not null
	THEN p.PeakName 
	ELSE '(no highest peak)'
	END) as [Highest Peak Name],
	(CASE
	WHEN p.Elevation is not null
	THEN p.Elevation
	ELSE '0'
	END) as [Highest Peak Elevation],
	(Case 
	WHEN m.MountainRange is not null
	THEN m.MountainRange
	ELSE '(no mountain)'
	END) as [Mountain]
	FROM Countries c
	LEFT OUTER JOIN MountainsCountries mc
	ON mc.CountryCode = c.CountryCode
	LEFT JOIN Mountains m
	ON mc.MountainId = m.Id
	LEFT JOIN Peaks p
	ON m.Id = p.MountainId
	GROUP BY c.CountryName, p.PeakName, p.Elevation, m.MountainRange, c.CountryCode
	HAVING p.Elevation = (SELECT MAX(p.Elevation) FROM Peaks p 	LEFT OUTER JOIN MountainsCountries mc
	ON mc.CountryCode = c.CountryCode
	LEFT JOIN Mountains m
	ON mc.MountainId = m.Id
	LEFT JOIN Countries c
	ON c.CountryCode = mc.CountryCode) OR p.Elevation IS NULL
	ORDER BY c.CountryName, [Highest Peak Name]