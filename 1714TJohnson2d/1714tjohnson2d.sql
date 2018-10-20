-- Tim Johnson
-- Exercise 2D: Multi-table join queries
-- Property Manager db

-- 2D.1) Building, apartment administrator tables.  Sort by City, BuildingName, ApartmentNum, LastName, FirstName
SELECT        Building.BuildingId, Building.BuildingName, Building.City, Apartment.ApartmentNum, Person.FirstName, Person.LastName
FROM            Building INNER JOIN
                         Apartment ON Building.BuildingId = Apartment.BuildingId INNER JOIN
                         Person ON Apartment.AdminId = Person.PersonId
ORDER BY Building.City, Building.BuildingName, Apartment.ApartmentNum, Person.LastName, Person.FirstName
--2D.2) Tenant, building, apartment tables.  Sort by LastName, FirstName, BuildingId, ApartmentNum
SELECT        Person.PersonId, Person.LastName, Person.FirstName, Building.City, Apartment.BuildingId, Building.BuildingName, Apartment.ApartmentNum
FROM            Person INNER JOIN
                         Apartment ON Person.PersonId = Apartment.TenantId INNER JOIN
                         Building ON Apartment.BuildingId = Building.BuildingId
ORDER BY Person.LastName, Person.FirstName, Apartment.BuildingId, Apartment.ApartmentNum
--2D.3) Apartment, tenant, invoice, line item tables (BuildingId 1).  Sort by ApartmentNum, LastName, FirstName, InvoiceDate
SELECT        Apartment.ApartmentNum, Person.LastName, Person.FirstName, LineItem.InvoiceId, Invoice.InvoiceDate, LineItem.Description, LineItem.Amount
FROM            Apartment INNER JOIN
                         Person ON Apartment.TenantId = Person.PersonId INNER JOIN
                         Invoice ON Apartment.ApartmentId = Invoice.ApartmentId INNER JOIN
                         LineItem ON Invoice.InvoiceId = LineItem.InvoiceId
WHERE        (Apartment.BuildingId = 1)
ORDER BY Apartment.ApartmentNum, Person.LastName, Person.FirstName, Invoice.InvoiceDate 
--2D.4) Apartment, tenant, invoice total tables.
SELECT        Apartment.BuildingId, Apartment.ApartmentId, Person.LastName, Person.FirstName, Invoice.InvoiceId, Invoice.InvoiceDate, SUM(LineItem.Amount) AS [Invoice Total]
FROM            Apartment INNER JOIN
                         Person ON Apartment.TenantId = Person.PersonId INNER JOIN
                         Invoice ON Apartment.ApartmentId = Invoice.ApartmentId INNER JOIN
                         LineItem ON Invoice.InvoiceId = LineItem.InvoiceId
GROUP BY Apartment.BuildingId, Apartment.ApartmentId, Person.LastName, Person.FirstName, Invoice.InvoiceId, Invoice.InvoiceDate
--2D.5) Invoice, tenant, receipt tables.  Sort by InvoiceDate, ReceiptDate
SELECT        Invoice.InvoiceId, Invoice.InvoiceDate, Apartment.BuildingId, Apartment.ApartmentNum, Person.LastName, Person.FirstName, Receipt.ReceiptDate, Receipt.Amount
FROM            Invoice INNER JOIN
                         Receipt ON Invoice.InvoiceId = Receipt.InvoiceId INNER JOIN
                         Apartment ON Invoice.ApartmentId = Apartment.ApartmentId INNER JOIN
                         Person ON Apartment.TenantId = Person.PersonId
ORDER BY Invoice.InvoiceId, Invoice.InvoiceDate
--2D.6) Invoice, tenant, apartment, total billed, total received tables.
SELECT        Invoice.InvoiceId, Invoice.InvoiceDate, Person.LastName AS Tenant, Apartment.BuildingId, Apartment.ApartmentNum, SUM(LineItem.Amount) AS [Total Billed], Receipt.Amount AS [Total Received]
FROM            Invoice INNER JOIN
                         Apartment ON Invoice.ApartmentId = Apartment.ApartmentId INNER JOIN
                         Person ON Apartment.TenantId = Person.PersonId INNER JOIN
                         LineItem ON Invoice.InvoiceId = LineItem.InvoiceId INNER JOIN
                         Receipt ON Invoice.InvoiceId = Receipt.InvoiceId
GROUP BY Invoice.InvoiceId, Invoice.InvoiceDate, Person.LastName, Apartment.BuildingId, Apartment.ApartmentNum, Receipt.Amount
--2D.7) Administrator, invoice, total billed, total received tables.
SELECT        Person.PersonId, Person.LastName AS Admin, Invoice.InvoiceId, Invoice.InvoiceDate, SUM(LineItem.Amount) AS [Total Billed], Receipt.Amount AS [Total Received]
FROM            LineItem INNER JOIN
                         Invoice ON LineItem.InvoiceId = Invoice.InvoiceId INNER JOIN
                         Receipt ON Invoice.InvoiceId = Receipt.InvoiceId INNER JOIN
                         Apartment ON Invoice.ApartmentId = Apartment.ApartmentId INNER JOIN
                         Person ON Apartment.AdminId = Person.PersonId
GROUP BY Person.PersonId, Person.LastName, Invoice.InvoiceDate, Receipt.Amount, Invoice.InvoiceId