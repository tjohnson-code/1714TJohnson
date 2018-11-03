-- Tim Johnson
-- Exercise 2G: PropertyManager2 test queries
-- PropertyManager2 db

-- 1) Buildings, apartments, admins
SELECT        Buildings.Id, Buildings.BuildingName, Buildings.City, Apartments.ApartmentNum, People.FirstName + N' ' + People.LastName AS Admin
FROM            Buildings INNER JOIN
                         Apartments ON Buildings.Id = Apartments.Building_Id INNER JOIN
                         People ON Apartments.Admin_Id = People.Id
ORDER BY Buildings.Id, Apartments.ApartmentNum

-- 2) Apartments, invoices, line items
SELECT        Buildings.Id, Apartments.ApartmentNum, People.LastName + N', ' + People.FirstName AS Tenant, LineItems.Invoice_Id AS InvoiceId, LineItems.Description, LineItems.Amount
FROM            Buildings INNER JOIN
                         Apartments ON Buildings.Id = Apartments.Building_Id INNER JOIN
                         People ON Apartments.Tenant_Id = People.Id INNER JOIN
                         Invoices ON Apartments.Id = Invoices.Apartment_Id INNER JOIN
                         LineItems ON Invoices.Id = LineItems.Invoice_Id
ORDER BY Buildings.Id, Tenant

--3) Tenants, invoices, receipts
SELECT        Apartments.Id, People.LastName + N', ' + People.FirstName AS Tenant, Invoices.Id AS InvoiceId, Invoices.DueDate, Receipts.ReceiptDate, Receipts.Amount
FROM            Apartments INNER JOIN
                         People ON Apartments.Tenant_Id = People.Id INNER JOIN
                         Invoices ON Apartments.Id = Invoices.Apartment_Id INNER JOIN
                         Receipts ON Invoices.Id = Receipts.Invoice_Id
ORDER BY Apartments.Id DESC, InvoiceId