SELECT * FROM Orders;
SELECT * FROM Items;
SELECT DISTINCT Product_ID FROM Items;
SELECT DISTINCT Product_ID FROM Inventory;
SELECT * FROM Inventory;

SELECT o.Order_ID, o.Order_Date, o.Total_Price, u.Name, u.Email
FROM Orders o
JOIN users u ON o.User_ID = u.User_ID;

UPDATE Inventory
SET Stock_Quantity = Inventory.Stock_Quantity - i.Quantity
FROM Items i
WHERE Inventory.Product_ID = i.Product_ID
  AND Inventory.Stock_Quantity >= i.Quantity;




