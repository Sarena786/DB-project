SELECT * FROM Orders WHERE User_ID = 1;


SELECT * FROM Items WHERE Order_ID = 1;


SELECT * FROM Inventory;


SELECT o.Order_ID, o.Order_Date, o.Total_Price, u.Name, u.Email
FROM Orders o
JOIN User u ON o.User_ID = u.User_ID;

SELECT * 
FROM Orders
LIMIT 1;

UPDATE Inventory
SET Stock_Quantity = Stock_Quantity - o.Ordered_Quantity
FROM Orders o
WHERE Inventory.Product_ID = o.product_id AND Inventory.Stock_Quantity > 0;

SELECT Product_Name, Stock_Quantity
FROM Inventory
JOIN Products ON Inventory.Product_ID = Products.Product_ID
WHERE Stock_Quantity < 10;

SELECT SUM(Products.Price * Inventory.Stock_Quantity) AS Total_Inventory_Value
FROM Products
JOIN Inventory ON Products.Product_ID = Inventory.Product_ID;
