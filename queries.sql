SELECT * FROM Orders WHERE User_ID = 1;


SELECT * FROM Items WHERE Order_ID = 1;


SELECT * FROM Inventory;


SELECT o.Order_ID, o.Order_Date, o.Total_Price, u.Name, u.Email
FROM Orders o
JOIN User u ON o.User_ID = u.User_ID;

UPDATE Inventory
SET Stock_Quantity = Inventory.Stock_Quantity - i.Quantity
FROM Items i
WHERE Inventory.Product_ID = i.Product_ID
  AND Inventory.Stock_Quantity >= i.Quantity;



WITH TotalQuantities AS (
    SELECT Product_ID, SUM(Quantity) AS Total_Quantity
    FROM Items
    GROUP BY Product_ID
)
UPDATE Inventory
SET Stock_Quantity = Inventory.Stock_Quantity - t.Total_Quantity
FROM TotalQuantities t
WHERE Inventory.Product_ID = t.Product_ID
  AND Inventory.Stock_Quantity >= t.Total_Quantity;

