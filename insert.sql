
INSERT INTO Users (User_ID , Name, Email, Password, Phone_Number,Address) VALUES
('1', 'Alice', 'alice@example.com', 'password123', '1234567890','123 Main St, Springfield, IL 62701'),
('2', 'Bob', 'bob@example.com', 'password456', '0987654321','456 Elm St, Springfield, IL 62702'),
('3', 'Carol', 'carol@example.com', 'password789', '1122334455', '789 Oak St, Springfield, IL 62703'),
('4', 'David', 'david@example.com', 'password101', '9988776655', '321 Pine St, Springfield, IL 62704');

INSERT INTO Products (Product_ID, Product_Name, Price)
VALUES (1, 'Gray Cat Plushie', 350.00),
       (2, 'Light Purple Rabbit Plushie', 350.00),
       (3, 'Pink Rabbit Plushie', 350.00),
       (4, 'Orange Tiger Plushie', 350.00),
       (5, 'Brown Bear Plushie', 400.00),
       (6, 'Beige Bear Plushie', 400.00);


INSERT INTO Orders (Order_ID, User_ID, Order_Date, Total_Price, Status)
VALUES
    (1, 1, '2024-01-01', 350.00, 'Completed'),
    (2, 1, '2024-01-02', 350.00, 'Processing'),
    (3, 2, '2024-01-03', 400.00, 'Completed'),
    (4, 2, '2024-01-04', 400.00, 'Processing'),
    (5, 3, '2024-01-05', 350.00, 'Completed'),
    (6, 3, '2024-01-06', 350.00, 'Completed'),
    (7, 4, '2024-01-07', 400.00, 'Completed'),
    (8, 4, '2024-01-08', 400.00, 'Processing');



INSERT INTO Items (Order_item_ID, Order_ID, Product_ID, Quantity, Price)
VALUES
(1, 1, 2, 1, (SELECT Price FROM Products WHERE Product_ID = 2)),
(2, 2, 1, 2, (SELECT Price FROM Products WHERE Product_ID = 1));



INSERT INTO Inventory (Product_ID, Stock_Quantity)
VALUES (1, 30),
       (2, 30),
       (3, 30),
       (4, 30),
       (5, 30),
       (6, 30);


(SELECT COALESCE(MAX(Order_Item_ID), 0) + 1 FROM Items)

-- CREATE SEQUENCE items_order_item_id_seq START 1;

-- ALTER TABLE Items ALTER COLUMN Order_Item_ID SET DEFAULT nextval('items_order_item_id_seq');
-- CREATE OR REPLACE FUNCTION insert_items_trigger()
-- RETURNS TRIGGER AS $$
-- BEGIN
--     INSERT INTO Items (Order_ID, Product_ID, Quantity, Price)
--     VALUES (
--         NEW.Order_ID, 
--         NEW.Product_ID, 
--         1,  
--         (SELECT Price FROM Products WHERE Product_ID = NEW.Product_ID)
--     );
--     RETURN NEW;
-- END;
-- $$ LANGUAGE plpgsql;

-- CREATE TRIGGER after_order_insert
-- AFTER INSERT ON Orders
-- FOR EACH ROW
-- EXECUTE FUNCTION insert_items_trigger();

INSERT INTO Orders (Order_ID, User_ID, Order_Date, Product_ID, Total_Price, Status)
VALUES (1, 1, '2024-01-01', 1, 350.00, 'Completed'),
    (2, 1, '2024-01-02', 2, 350.00, 'Processing'),
    (3, 2, '2024-01-03', 5, 400.00, 'Completed'),
    (4, 2, '2024-01-04', 6, 400.00, 'Processing'),
    (5, 3, '2024-01-05', 3, 350.00, 'Completed'),
    (6, 3, '2024-01-06', 4, 350.00, 'Completed'),
    (7, 4, '2024-01-07', 6, 400.00, 'Completed'),
    (8, 4, '2024-01-08', 6, 400.00, 'Processing'),
    (9, 2, '2024-01-10', 2, 350.00, 'Processing');
SELECT * FROM Items;

INSERT INTO User_Total_Spent (User_ID, Name, Email, Phone_Number, Address, Total_Spent)
SELECT 
    u.User_ID,
    u.Name,
    u.Email,
    u.Phone_Number,
    u.Address,
    SUM(o.Total_Price) AS Total_Spent
FROM 
    Users u
JOIN 
    Orders o ON u.User_ID = o.User_ID
GROUP BY 
    u.User_ID, u.Name, u.Email, u.Phone_Number, u.Address;
