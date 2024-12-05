SELECT * FROM Orders WHERE User_ID = 1;


SELECT * FROM Items WHERE Order_ID = 1;


SELECT * FROM Inventory;


SELECT o.Order_ID, o.Order_Date, o.Total_Price, u.Name, u.Email
FROM Orders o
JOIN users u ON o.User_ID = u.User_ID;

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

SELECT b.Branch_Name, p.Product_ID, p.Price, i.Stock_Quantity --selecting the branch name, product id, price, and stock quantity
FROM Inventory i
JOIN Products p ON i.Product_ID = p.Product_ID
JOIN Branches b ON i.Branch_ID = b.Branch_ID;

SELECT o.Order_ID, o.Total_Price, o.Status, b.Branch_Name --selecting the order id, total price, status, and branch name
FROM Orders o
JOIN Branches b ON o.Branch_ID = b.Branch_ID
WHERE b.Branch_ID = 1;

UPDATE Inventory --updating the stock quantity of product 101 in branch 1
SET Stock_Quantity = Stock_Quantity - 5
WHERE Product_ID = 101 AND Branch_ID = 1;
