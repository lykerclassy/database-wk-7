USE salesdb;

-- Question 1: Achieving 1NF
-- Transform ProductDetail table into 1NF (one product per row)
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50)
);

INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product) VALUES
(101,'John Doe','Laptop'),
(101,'John Doe','Mouse'),
(102,'Jane Smith','Tablet'),
(102,'Jane Smith','Keyboard'),
(102,'Jane Smith','Mouse'),
(103,'Emily Clark','Phone');

-- View the result
SELECT * FROM ProductDetail_1NF;

-- Question 2: Achieving 2NF
-- Break OrderDetails into Orders and OrderItems
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Populate Orders with distinct OrderIDs and CustomerNames
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName FROM OrderDetails;

-- Populate OrderItems with OrderID, Product, Quantity
INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity FROM OrderDetails;

-- View the combined data to confirm
SELECT o.OrderID, o.CustomerName, i.Product, i.Quantity
FROM Orders o
JOIN OrderItems i ON o.OrderID = i.OrderID;
