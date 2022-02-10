USE [AdventureWorks2019]
GO

SELECT *
FROM Production.ProductInventory

----

SELECT TOP(3) ProductID AS "Producto", LocationID AS "Locaci�n"
FROM Production.ProductInventory

/* Indicar cu�les son los nombres de los departamentos existentes en la empresa. Keyword: name 
*/
SELECT Name
FROM HumanResources.Department

-- Indicar el nombre de las culturas que se utilizan en la base de datos. Keyword: name 
SELECT name
FROM Production.Culture

--Indicar los tipos de personas que la empresa utiliza para hacer la clasificaci�n. 
-- El resultado de la consulta no debe tener registros repetidos. Keyword: persontype

SELECT DISTINCT persontype AS "tipo de personas"
FROM Person.person

-- Indicar las categor�as que la empresa implementa para las ofertas especiales. 
-- El resultado de la consulta no debe tener registros repetidos. Keyword: category

SELECT DISTINCT Category
FROM Sales.SpecialOffer

-- Indicar el nombre del proveedor que tiene por cuenta el n�mero AUSTRALI0001. Keywords: vendor, accountnumber

SELECT name, AccountNumber
FROM Purchasing.Vendor
WHERE AccountNumber='AUSTRALI0001'


-- Indicar el id y el nombre de los territorios de ventas con codigos de region pais US y CA. 
-- Desarrollar dos consultas, ya que se puede lograr con dos operadores relacionales distintos. 
-- El resultado debe ser el mismo. Keywords: territoryid, name, salesterritory, countryregioncode */

SELECT TerritoryID, Name, CountryRegionCode
FROM Sales.SalesTerritory
WHERE CountryRegionCode IN ('US','CA')

SELECT TerritoryID, Name, CountryRegionCode
FROM Sales.SalesTerritory
WHERE CountryRegionCode ='US' OR CountryRegionCode ='CA'

-- Indicar los id de tarifa moneda y sus tarifas promedio que se dieron entre 31/05/2011 y 20/06/2011. 
-- Desarrollar dos consultas, una debe contener un operador logico y la otra debe contener operadores relacionales. 
-- El resultado debe ser el mismo. Keywords: currencyrateid, averagerate, currencyratedate.

SELECT ToCurrencyCode, AverageRate, CurrencyRateDate
FROM Sales.CurrencyRate
WHERE CurrencyRateDate >='2011-05-31' AND CurrencyRateDate <= '2011-06-20'

SELECT ToCurrencyCode, AverageRate, CurrencyRateDate
FROM Sales.CurrencyRate
WHERE CurrencyRateDate BETWEEN '2011-05-31' AND '2011-06-20'

-- Indicar cual es la tarifa de impuesto promedio. Renombrar la nueva columna como tarifa_promedio. Keyword: taxrate.
SELECT AVG(TaxRate)  AS "Tarifa_promedio"
FROM Sales.SalesTaxRate

-- Indicar cu�l es el m�ximo y el minimo punto de reposicion que se tiene registrado para los productos. 
-- Renombrar los campos maximo_punto y minimo_punto respectivamente. Keyword: reorderpoint.

SELECT MAX( ReorderPoint) AS "maximo_punto", MIN(ReorderPoint) AS "minimo_punto"
FROM Production.Product

-- Indicar cu�ntos modelos de producto hay registrados. Renombrar el nuevo campo como cant_modelos. Keyword: productmodel.
SELECT DISTINCT COUNT(name) AS "Cant_modelos"
FROM Production.Productmodel


-- Indicar el id de producto y cu�ntos comentarios tiene registrado cada producto. 
-- Renombrar el campo nuevo como cantidad_com. Keywords: productid, comments, productreview.

SELECT ProductID, COUNT (Comments) AS "Cantidad_com"
FROM Production.ProductReview
GROUP BY ProductID

-- Indicar cu�ntas transacciones tienen registradas los productos con id 784, 798, 799 y  977. 
-- Renombrar el campo nuevo como cant_transacciones. Keywords: transactionhistory, productid.

SELECT ProductID, COUNT (TransactionID) AS "cant_Transacciones"
FROM Production.TransactionHistory
WHERE ProductID =784 OR ProductID=798 OR ProductID=799 OR ProductID=977
GROUP BY ProductID;

-- Indicar el id de orden, cu�ntas locaciones y qu� costo planeado promedio tienen las �rdenes de pedido con id de orden 72, 14, 122 y 123. 
-- Keywords: workorderid, locationid, plannedcost, workorderrouting.

SELECT WorkOrderID, COUNT (locationID) AS Location, AVG (PlannedCost) AS "Costo Planeado promedio"
FROM Production.WorkOrderRouting
WHERE WorkOrderID=72 OR WorkOrderID=14 OR WorkOrderID=122 OR WorkOrderID=123
GROUP BY WorkOrderID

-- Indicar el n�mero de entidad de negocio y los tres primeros n�meros del n�mero de identificaci�n nacional de cada uno de los empleados. 
-- Renombrar la nueva columna como id_tres. Keywords: BusinessEntityId, NationalIDNumber, Employee.

SELECT BusinessEntityID, LEFT (NationalIDNumber,3) AS id_tres
FROM HumanResources.Employee

-- Indicar el id de direcci�n, la l�nea 1 de direcci�n (Addressline1) y los cuatro �ltimos d�gitos del c�digo postal de cada direcci�n registrada. 
-- Eliminar los espacios en el inicio y el final de los valores resultantes. Renombrar la nueva columna como postal_4. Keywords: adressid, Addresline1, postalcode.

SELECT AddressID, AddressLine1, TRIM(RIGHT(PostalCode,4)) AS "Postal 4"
FROM Person.Address

-- Indicar el id de provincia-estado y la concatenaci�n de los campos codigo de region-pa�s, nombre y c�digo de provincia-estado.  
-- El resultado debe utilizar dos separadores: primero barra inclinada (/) y luego gui�n (-). 
-- Ejemplo: CA/California-CA. Renombrar la nueva columna como regi�n. Los resultados de la nueva columna deben estar en may�sculas. 
-- Keywords: stateprovinceid, countryregioncode, name, stateprovinceid.

SELECT StateProvinceID, UPPER(CONCAT(CountryRegionCode,'/',Name,'-',StateProvinceCode)) AS "Regi�n"
FROM Person.StateProvince

-- Indicar el id de la foto producto y el nombre de archivo de foto. Reemplazar el tipo de archivo gif por jpeg en cada uno de los registros. 
-- Renombrar la nueva columna como foto. Keywords: productphotoid, thumbnailphotofilename, productphoto.

SELECT ProductPhotoID, REPLACE(ThumbnailPhotoFileName,'gif','jpg') AS "Foto"
FROM Production.ProductPhoto

-- Indicar el codigo de unidad de medida, el nombre y el a�o en el que fue modificado cada registro. 
-- Renombrar la nueva columna como anio_modificacion. Keywords: unitmeasurecode, name, modifieddate. 

SELECT Unitmeasurecode, name, YEAR(Modifieddate) AS "Anio_Modificaci�n"
FROM Production.UnitMeasure

-- Indicar el id de tarjeta de cr�dito, el tipo de tarjeta y el mes en el que fue modificado cada registro almacenado para las tarjetas de cr�dito. 
-- Renombrar a la nueva columna Mes_modificacion. Keywords: Creditcardid, cardtype, modifieddate, creditcard. 

SELECT CreditCardID, CardType, DATEPART(Month,ModifiedDate) AS 'Mes_modificaci�n'
FROM Sales.CreditCard

-- Indicar el id de transacci�n, el id de referencia de orden y el d�a del mes en el que se registr� la transacci�n en el hist�rico. 
-- Renombrar a la nueva columna como dia_transaccion. Keywords: transactionid, referenceorderid, transactiondate, transactionhistoryarchive.

SELECT TransactionID, ReferenceOrderID, DATEPART(Day,TransactionDate) AS "Dia_Transacci�n"
FROM Production.TransactionHistoryArchive

-- Indicar el id de orden de pedido, la fecha de inicio y cual seria la fecha de entrega, si cada orden debe ser recibida 30 d�as despu�s de su inicio. 
-- Consultar para cada orden de pedido registrada. Renombrar la nueva columna como entrega_estimada. Keywords: workorderid, startdate, workorder.

SELECT WorkOrderID, Startdate, DATEADD(Day,30,StartDate) AS "Entrega_estimada"
FROM Production.WorkOrder

-- Indicar el id de orden de pedido y cu�ntos dias hay entre la fecha programada de inicio y la fecha programada de fin, para los id de orden 
-- comprendidos entre 72060 y 72070. Se requiere la informaci�n correspondiente a la m�xima fecha de registro, sin agregar la fecha de forma manual. 
-- Renombrar la nueva columna como diferencia_dias. Keywords: workorderid, scheduledstartdate, scheduledenddate, modifieddate.

SELECT WorkOrderID, DATEDIFF(DAY,ScheduledEndDate,ScheduledStartDate) AS "diferencia_dias"
FROM Production.WorkOrderRouting
WHERE WorkOrderID BETWEEN '72060' AND '72070' AND ModifiedDate = 
(SELECT MAX(ModifiedDate)
FROM Production.WorkOrderRouting)

-- Para el n�mero de orden 43659: Indicar el n�mero de orden de venta y el n�mero entero correspondiente al precio unitario de todos los registros de 
-- los detalles de ventas. Se requiere la informaci�n correspondiente a la m�nima fecha de registro, sin agregar la condici�n de fecha de forma manual. 
-- Renombrar la nueva columna como precio_en_enteros. Keywords: salesorderid, unitprice, salesorderdetail, modifieddate.

SELECT SalesOrderID, FLOOR(UnitPrice) as "precio_en_enteros"
FROM Sales.SalesOrderDetail
WHERE SalesOrderID=43659 AND ModifiedDate = (
SELECT MIN(ModifiedDate)
FROM Sales.SalesOrderDetail)

-- Indicar el n�mero de id nacional y cu�l es la tarifa registrada por la empresa para las empleadas de g�nero femenino que fueron contratadas 
-- a partir de enero de 2009 . 
-- El resultado debe contener todos los valores registrados en la primera tabla, sin importar que no haya similitud de valores con la segunda tabla. 
-- Renombrar todos los campos al espa�ol. Keywords: nationalidnumber, rate, EmployeePayHistory, employee, gender, hiredate.

SELECT empleados.NationalIDNumber, pay.rate
FROM HumanResources.Employee AS "Empleados"
LEFT JOIN HumanResources.EmployeePayHistory AS "Pay"
ON empleados.BusinessEntityID = Pay.BusinessEntityID
WHERE empleados.Gender = 'F' AND empleados.HireDate> '2008-12-31' --podes usar Year.


-- Para los id de direcci�n superiores a 1000: Indicar el id de entidad de negocio, id de persona y id de tipo de contacto; 
-- estos campos se encuentran registrados en la tabla contacto de entidad de negocio. 
-- Complementar el resultado con el id de tipo de direcci�n, almacenado en las direcciones de entidad de negocio. 
-- El resultado no debe tener valores nulos en ninguna de las dos tablas. Renombrar todos los campos al espa�ol. 
-- Keywords: addressid, businessentityid, personid, contacttypeid, businessentitycontact, addresstypeid, businessentityaddress.

SELECT contact.BusinessEntityID, PersonID, ContactTypeID
FROM Person.BusinessEntityAddress AS "Address"
INNER JOIN Person.BusinessEntityContact AS "contact"
ON Address.BusinessEntityID= contact.BusinessEntityID
WHERE Address.AddressID>1000

-- Para los productos que llevan por n�mero del 920 al 931 y tienen disponible un nombre de archivo de foto: 
-- Indicar el id de foto de producto, el nombre de archivo de foto, los 5 primeros d�gitos del largo de la foto registrados por la empresa 
-- en las fotos de producto y el id de producto. Renombrar el campo nuevo como �largo�, y el resto de columnas al espa�ol. 
-- Keywords: productphotoid, thumbnailphotofilename, largephoto, productphoto, productid, productproductphoto.

SELECT pp.productID, foto.ProductphotoID , foto.thumbnailPhotoFileName, LEFT(foto.largephoto,5) AS 'Largo'
FROM Production.ProductProductPhoto as pp
INNER JOIN Production.ProductPhoto as foto
ON pp.ProductPhotoID= foto.ProductPhotoID
WHERE pp.ProductID BETWEEN 920 AND 931 AND foto.ThumbnailPhotoFileName NOT LIKE 'no_image%'

-- Para las �rdenes con con id inferior a 100, secuencia de operaci�n 1 y 2 e id de locaci�n 10: Indicar el n�mero de orden de pedido y 
-- la sumatoria de la cantidad registrada en las �rdenes. Keywords: workorderid, operationsequence, locationid, orderqty.

SELECT  WorkR.WorkOrderID, COUNT(WorkR.OrderQty) AS "Cantidad"
FROM Production.WorkOrderRouting as Work
INNER JOIN Production.WorkOrder as WorkR
ON Work.WorkOrderID = WorkR.WorkOrderID
WHERE work.WorkOrderID <100 AND work.OperationSequence=1 OR work.OperationSequence=2 AND work.LocationID=10
GROUP BY WorkR.WorkOrderID
ORDER BY WorkR.WorkOrderID

