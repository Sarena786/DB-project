-------------------------------------------------------------------------------------



-- Manage Trigger in Orders :
-- Items
-- Sales
-- Restock

------------------------Trigger for Populating Items Table from Orders----------------------------------
CREATE OR REPLACE FUNCTION populate_items_from_orders()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Items (Order_ID, Product_ID, Branch_ID, Quantity, Price)
    VALUES (
        NEW.Order_ID,
        NEW.Product_ID, 
        NEW.Branch_ID,
        1, 
        (SELECT Price FROM Products WHERE Product_ID = NEW.Product_ID) 
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Update the trigger
DROP TRIGGER IF EXISTS after_order_insert_items ON Orders;

CREATE TRIGGER after_order_insert_items
AFTER INSERT ON Orders
FOR EACH ROW
EXECUTE FUNCTION populate_items_from_orders();

--------------Trigger for Inserting Sales Record on Completed Orders------------------

CREATE OR REPLACE FUNCTION insert_sales_trigger()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.Status = 'Completed' THEN
        INSERT INTO Sales (Branch_ID, Product_ID, User_ID, Sale_Date, Quantity, Total_Amount)
        VALUES (
            NEW.Branch_ID,
            NEW.Product_ID,
            NEW.User_ID,
            NEW.Order_Date,
            1,  
            NEW.Total_Price
        );
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


DROP TRIGGER IF EXISTS after_order_insert ON Orders;

CREATE TRIGGER after_order_insert
AFTER INSERT ON Orders
FOR EACH ROW
EXECUTE FUNCTION insert_sales_trigger();

SELECT * FROM sales;
    
---------------- Restock inventory if the stock is low -----------------------

SELECT event_object_table AS table_name, trigger_name, action_timing, event_manipulation
FROM information_schema.triggers
WHERE event_object_table = 'inventory';

CREATE OR REPLACE FUNCTION auto_restock_trigger()
RETURNS TRIGGER AS $$
BEGIN
    RAISE NOTICE 'Trigger fired for Branch_ID: %, Product_ID: %, Stock_Quantity: %', 
                 NEW.Branch_ID, NEW.Product_ID, NEW.Stock_Quantity;

    IF NEW.Stock_Quantity < 10 THEN
        RAISE NOTICE 'Inserting restock order for Product_ID: %, Branch_ID: %', 
                     NEW.Product_ID, NEW.Branch_ID;

        INSERT INTO Restock_Orders (Branch_ID, Product_ID, Restock_Order_Date, Quantity, Status)
        SELECT NEW.Branch_ID, NEW.Product_ID, CURRENT_DATE, 50, 'Pending'
        WHERE NOT EXISTS (
            SELECT 1
            FROM Restock_Orders
            WHERE Restock_Orders.Product_ID = NEW.Product_ID
              AND Restock_Orders.Branch_ID = NEW.Branch_ID
              AND Restock_Orders.Restock_Order_Date = CURRENT_DATE
        );
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


DROP TRIGGER IF EXISTS after_inventory_update ON Inventory;

CREATE TRIGGER after_inventory_update
AFTER UPDATE ON Inventory
FOR EACH ROW
EXECUTE FUNCTION auto_restock_trigger();

UPDATE Inventory
SET Stock_Quantity = Stock_Quantity + s.Quantity
FROM Restock_Orders s
WHERE Inventory.Product_ID = s.Product_ID
  AND Inventory.Branch_ID = s.Branch_ID
  AND s.Status = 'Pending'; 

------------------------------------------------------------------------------
SELECT * FROM inventory;
SELECT * FROM restock_orders;