-- Tim Johnson
-- Exercise 2A: 2-table queries
-- Property Manager db

-- 2A.1) Building, Apartment tables.  Sort by BuildingId, ApartmentNum
SELECT        Building.BuildingId, Building.BuildingName, Apartment.ApartmentNum, Apartment.Rent
FROM            Building INNER JOIN
                         Apartment ON Building.BuildingId = Apartment.BuildingId
ORDER BY Building.BuildingId, Apartment.ApartmentNum
-- 2A.2) Building, Apartment tables.  Sort by BuildingId, City, BuildingName, ApartmentNum, Rent.  Filter Winona
SELECT        Building.BuildingId, Building.City, Building.BuildingName, Apartment.ApartmentNum, Apartment.Rent
FROM            Building INNER JOIN
                         Apartment ON Building.BuildingId = Apartment.BuildingId
WHERE        (Building.City = N'Winona')
ORDER BY Building.BuildingId, Apartment.Rent DESC
-- 2A.3) Apartment, Invoice tables.  Sort by ApartmentId, ApartmentNum, InvoiceId, InvoiceDate, DueDate.  Filter BuildingId 1
SELECT        Apartment.ApartmentId, Apartment.ApartmentNum, Invoice.InvoiceId, Invoice.InvoiceDate, Invoice.InvoiceDueDate
FROM            Apartment INNER JOIN
                         Invoice ON Apartment.ApartmentId = Invoice.ApartmentId
WHERE        (Apartment.BuildingId = 1)
ORDER BY Apartment.ApartmentNum, Invoice.InvoiceDate DESC
-- 2A.4) Apartment, Invoice tables.  Sort by BuildingId, ApartmentNum, InvoiceId, InvoiceDate, DueDate.
SELECT        Apartment.BuildingId, Apartment.ApartmentNum, Invoice.InvoiceId, Invoice.InvoiceDate, Invoice.InvoiceDueDate
FROM            Apartment INNER JOIN
                         Invoice ON Apartment.ApartmentId = Invoice.ApartmentId
ORDER BY Apartment.BuildingId, Apartment.ApartmentNum, Invoice.InvoiceDate
-- 2A.5) Apartment, Person (Administrator) tables.  Sort by BuildingId, ApartmentNum, Rent, LastName (alias: 'Admin')
SELECT        Apartment.BuildingId, Apartment.ApartmentNum, Apartment.Rent, Person.LastName AS 'Admin'
FROM            Apartment INNER JOIN
                         Person ON Apartment.AdminId = Person.PersonId
ORDER BY Apartment.BuildingId, Apartment.ApartmentNum
-- 2A.6) Apartment, Person (Tenant) tables.  Sort by BuildingId, ApartmentNum, LastName (alias: TenantLastName), FirstName (alias: TenantFirstName)
SELECT        Person.LastName AS TenantLastName, Person.FirstName AS TenantFirstName, Apartment.BuildingId, Apartment.ApartmentNum
FROM            Apartment INNER JOIN
                         Person ON Apartment.TenantId = Person.PersonId
ORDER BY Apartment.BuildingId, TenantLastName, TenantFirstName
-- 2A.7) Invoice, LineItem tables.  Sort by ApartmentId, InvoiceId, InvoiceDate, Description, Amount.
SELECT        Invoice.ApartmentId, Invoice.InvoiceDate, LineItem.Description, LineItem.Amount
FROM            Invoice INNER JOIN
                         LineItem ON Invoice.InvoiceId = LineItem.InvoiceId
ORDER BY Invoice.ApartmentId, Invoice.InvoiceDate DESC
-- 2A.8) Invoice, LineItem tables.  Sort by ApartmentId, InvoiceId, Rent (any month), InvoiceDate, Decription, Amount, Garage.
SELECT        Invoice.ApartmentId, Invoice.InvoiceId, LineItem.Description, Invoice.InvoiceDate, LineItem.Amount
FROM            Invoice INNER JOIN
                         LineItem ON Invoice.InvoiceId = LineItem.InvoiceId
WHERE        (LineItem.Description LIKE N'Rent%') OR
                         (LineItem.Description = N'Garage')
ORDER BY Invoice.ApartmentId, Invoice.InvoiceId
-- 2A.9) Invoice, Receipt tables.  Sort by ApartmentId, InvoiceId, InvoiceDueDate, ReceiptDate, Amount.
SELECT        Invoice.ApartmentId, Invoice.InvoiceId, Invoice.InvoiceDueDate, Receipt.ReceiptDate, Receipt.Amount
FROM            Invoice INNER JOIN
                         Receipt ON Invoice.InvoiceId = Receipt.InvoiceId
ORDER BY Invoice.ApartmentId, Invoice.InvoiceId