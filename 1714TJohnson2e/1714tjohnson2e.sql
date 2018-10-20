-- Tim Johnson
-- Exercise 2E: Functions, Calculated Fields
-- Property Manager db

-- 2E.1) Building name, and location.  Filter by Winona, MN.
SELECT        BuildingName, Address, City + N', ' + State + N' ' + Zip AS Location
FROM            Building
WHERE        (City + N' ' + State = N'Winona MN')
--2E.2) Apartment estimated rent.  Filter by Red Wing, MN.
SELECT        Building.BuildingName, Apartment.ApartmentNum, Apartment.SquareFeet * 0.9 + Apartment.Bathrooms * 100 AS [Estimated Rent]
FROM            Apartment INNER JOIN
                         Building ON Apartment.BuildingId = Building.BuildingId
WHERE        (Building.City + N', ' + Building.State = N'Red Wing, MN')
--2E.3) Estimated vs. Actual Rent.  Filter by Red Wing, MN.
SELECT        Building.BuildingName, Apartment.ApartmentNum, Apartment.Rent, Apartment.SquareFeet * 0.9 + Apartment.Bathrooms * 100 AS [Estimated Rent], Apartment.Rent - (Apartment.SquareFeet * 0.9 + Apartment.Bathrooms * 100) 
                         AS Difference
FROM            Apartment INNER JOIN
                         Building ON Apartment.BuildingId = Building.BuildingId
WHERE        (Building.City + N', ' + Building.State = N'Red Wing, MN')
--2E.4) Invoice Total.
SELECT        Apartment.BuildingId, Apartment.ApartmentNum, Person.FirstName + N' ' + Person.LastName AS Tenant, Invoice.InvoiceDate, SUM(LineItem.Amount) AS [Invoice Total]
FROM            Apartment INNER JOIN
                         Invoice ON Apartment.ApartmentId = Invoice.ApartmentId INNER JOIN
                         LineItem ON Invoice.InvoiceId = LineItem.InvoiceId INNER JOIN
                         Person ON Apartment.TenantId = Person.PersonId
GROUP BY Apartment.BuildingId, Apartment.ApartmentNum, Person.FirstName + N' ' + Person.LastName, Invoice.InvoiceDate
--2E.5) Invoice Total and Receipt.
SELECT        Apartment.BuildingId, Apartment.ApartmentNum, Person.FirstName + N' ' + Person.LastName AS Tenant, Invoice.InvoiceDate, SUM(LineItem.Amount) AS [Invoice Total], Receipt.Amount AS Receipt
FROM            Apartment INNER JOIN
                         Invoice ON Apartment.ApartmentId = Invoice.ApartmentId INNER JOIN
                         LineItem ON Invoice.InvoiceId = LineItem.InvoiceId INNER JOIN
                         Person ON Apartment.TenantId = Person.PersonId INNER JOIN
                         Receipt ON Invoice.InvoiceId = Receipt.InvoiceId
GROUP BY Apartment.BuildingId, Apartment.ApartmentNum, Person.FirstName + N' ' + Person.LastName, Invoice.InvoiceDate, Receipt.Amount
--2E.6) Invoice Total vs. Received.  Filter by Received < Invoice Total.
SELECT        Apartment.BuildingId, Apartment.ApartmentNum, Person.FirstName + N' ' + Person.LastName AS Tenant, Invoice.InvoiceDate, SUM(LineItem.Amount) AS [Invoice Total], Receipt.Amount AS Receipt, SUM(LineItem.Amount) 
                         - Receipt.Amount AS Difference
FROM            Apartment INNER JOIN
                         Invoice ON Apartment.ApartmentId = Invoice.ApartmentId INNER JOIN
                         LineItem ON Invoice.InvoiceId = LineItem.InvoiceId INNER JOIN
                         Person ON Apartment.TenantId = Person.PersonId INNER JOIN
                         Receipt ON Invoice.InvoiceId = Receipt.InvoiceId
GROUP BY Apartment.BuildingId, Apartment.ApartmentNum, Person.FirstName + N' ' + Person.LastName, Invoice.InvoiceDate, Receipt.Amount
HAVING        (Receipt.Amount < SUM(LineItem.Amount))
--2E.7) Late Payments. Filter by days late > 0.
SELECT        Apartment.BuildingId, Apartment.ApartmentNum, Person.FirstName + N' ' + Person.LastName AS Tenant, Invoice.InvoiceDueDate AS DueDate, Receipt.ReceiptDate, DATEDIFF(day, Invoice.InvoiceDueDate, Receipt.ReceiptDate) 
                         AS [Days Late]
FROM            Apartment INNER JOIN
                         Person ON Apartment.TenantId = Person.PersonId INNER JOIN
                         Invoice ON Apartment.ApartmentId = Invoice.ApartmentId INNER JOIN
                         Receipt ON Invoice.InvoiceId = Receipt.InvoiceId
WHERE        (DATEDIFF(day, Invoice.InvoiceDueDate, Receipt.ReceiptDate) > 0)
--2E.8) Next InvoiceDate
SELECT        Person.PersonId, Person.FirstName + N' ' + Person.LastName AS Tenant, MAX(Invoice.InvoiceDate) AS [Recent Invoice], DATEADD(month, 1, MAX(Invoice.InvoiceDate)) AS [Next Invoice]
FROM            Person INNER JOIN
                         Apartment ON Person.PersonId = Apartment.TenantId INNER JOIN
                         Invoice ON Apartment.ApartmentId = Invoice.ApartmentId
GROUP BY Person.FirstName + N' ' + Person.LastName, Person.PersonId
ORDER BY Tenant