-- Tim Johnson
-- Exercise 2C: Summary queries, groups, joins
--PropertyManager db

--1) Count buildings (building table): group by State, City
SELECT        State, City, COUNT(BuildingId) AS [Count Buildings]
FROM            Building
GROUP BY State, City

--2) Count buildings in MN (building table): group by City
SELECT        City, COUNT(BuildingId) AS [Count Buildings in MN]
FROM            Building
WHERE        (State = N'MN')
GROUP BY City, State

--3) Average rent (building, apartment tables): group by BuildingId, BuildingName
SELECT        Building.BuildingId, Building.BuildingName, AVG(Apartment.Rent) AS [Average Rent]
FROM            Building INNER JOIN
                         Apartment ON Building.BuildingId = Apartment.BuildingId
GROUP BY Building.BuildingId, Building.BuildingName

--4) Total Rent in Minnesota (building, apartment tables): group by City, BuildingName
SELECT        Building.City, Building.BuildingName, SUM(Apartment.Rent) AS [Total Rent in MN]
FROM            Building INNER JOIN
                         Apartment ON Building.BuildingId = Apartment.BuildingId
GROUP BY Building.City, Building.BuildingName, Building.State
HAVING        (Building.State = N'MN')

--5) Cheapest Rent (building, apartment tables): group by City
SELECT        Building.City, MIN(Apartment.Rent) AS [Cheapest Rent]
FROM            Building INNER JOIN
                         Apartment ON Building.BuildingId = Apartment.BuildingId
GROUP BY Building.City

--6) Apartments available in Winona - smallest, average, largest (building, apartment tables): group by BuildingName
SELECT        Building.BuildingName, MIN(Apartment.SquareFeet) AS [Smallest Size], AVG(Apartment.SquareFeet) AS [Average Size], MAX(Apartment.SquareFeet) AS [Largest Size]
FROM            Building INNER JOIN
                         Apartment ON Building.BuildingId = Apartment.BuildingId
GROUP BY Building.BuildingName, Building.City, Apartment.TenantId
HAVING        (Building.City = N'Winona') AND (Apartment.TenantId IS NULL)

--7) Cheapest price of garage for September 2018 (invoice, line item tables): group by InvoiceId
SELECT        MIN(LineItem.Amount) AS [Cheapest Garage for September 2018]
FROM            Invoice INNER JOIN
                         LineItem ON Invoice.InvoiceId = LineItem.InvoiceId
GROUP BY LineItem.Description, Invoice.InvoiceDate
HAVING        (LineItem.Description = N'Garage') AND (Invoice.InvoiceDate BETWEEN CONVERT(DATETIME, '2018-09-01 00:00:00', 102) AND CONVERT(DATETIME, '2018-09-30 00:00:00', 102))

--8) Total amount billed for September 2018 (invoice, line item tables): group by InvoiceId
SELECT        Invoice.InvoiceId, SUM(LineItem.Amount) AS [Total Amount Billed]
FROM            Invoice INNER JOIN
                         LineItem ON Invoice.InvoiceId = LineItem.InvoiceId
GROUP BY Invoice.InvoiceId, Invoice.InvoiceDate
HAVING        (Invoice.InvoiceDate BETWEEN CONVERT(DATETIME, '2018-09-01 00:00:00', 102) AND CONVERT(DATETIME, '2018-09-30 00:00:00', 102))