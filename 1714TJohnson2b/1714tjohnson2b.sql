-- Tim Johnson
-- Exercise 2B: Summary queries
--PropertyManager db

-- 1) Count all buildings
SELECT        COUNT(*) AS [Count All Buildings]
FROM            Building

--2) Count buildings in Winona
SELECT        COUNT(*) AS [Count Buildings in Winona]
FROM            Building
GROUP BY City
HAVING        (City = N'Winona')

--3) Average rent of all apartments
SELECT        AVG(Rent) AS [Average Rent]
FROM            Apartment

--4) Total rent for Winona in building 1
SELECT        SUM(Rent) AS [Total Rent]
FROM            Apartment
GROUP BY BuildingId
HAVING        (BuildingId = 1)

--5) Cheapest Rent in building 2
SELECT        MIN(Rent) AS [Cheapest Rent]
FROM            Apartment
GROUP BY BuildingId
HAVING        (BuildingId = 2)

--6) Smallest size, average size, largest size in building 1
SELECT        MIN(SquareFeet) AS [Smallest Size], AVG(SquareFeet) AS [Average Size], MAX(SquareFeet) AS [Largest Size]
FROM            Apartment
GROUP BY BuildingId
HAVING        (BuildingId = 1) AND (BuildingId = 1) AND (BuildingId = 1)

--7) Cheapest price for garage
SELECT        MIN(Amount) AS [Cheapest Garage]
FROM            LineItem
GROUP BY Description
HAVING        (Description = N'Garage')

--8) Total amount billed for gas
SELECT        SUM(Amount) AS [Gas Total]
FROM            LineItem
GROUP BY Description
HAVING        (Description = N'Gas')

--9) Total rent for October
SELECT        SUM(Amount) AS [Total Rent: October]
FROM            LineItem
GROUP BY Description
HAVING        (Description LIKE N'Rent, O%')