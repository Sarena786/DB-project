SELECT * FROM Orders WHERE User_ID = 1;


SELECT * FROM Items WHERE Order_ID = 1;


SELECT * FROM Inventory;


SELECT o.Order_ID, o.Order_Date, o.Total_Price, u.Name, u.Email
FROM Orders o
JOIN User u ON o.User_ID = u.User_ID;

SELECT * 
FROM Inventory i
JOIN Items t ON i.Product_ID = t.Product_ID
WHERE t.Order_ID = 1;



UPDATE Inventory
SET Stock_Quantity = Inventory.Stock_Quantity - i.Quantity
FROM Items i
WHERE Inventory.Product_ID = i.Product_ID
  AND i.Order_ID = 1
  AND Inventory.Stock_Quantity >= i.Quantity;
