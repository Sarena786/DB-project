SELECT Product_Name, Stock_Quantity
FROM Inventory
JOIN Products ON Inventory.Product_ID = Products.Product_ID

UPDATE Inventory
SET Stock_Quantity = Stock_Quantity - o.Ordered_Quantity
FROM Orders o
WHERE Inventory.Product_ID = o.Product_ID AND Inventory.Stock_Quantity > 0;


