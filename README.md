## MySql
for ecommerce page

# E-commerce System Database

This project involves creating a database to manage a simple e-commerce system. The system consists of three tables: customers, orders, and products. The database is designed to track customer information, order details, and product information, with functionality to retrieve specific queries as described below.

[MySQL Page](https://www.db-fiddle.com/f/3vgGa5HgxpTcQPMrkTVGjj/1)

## Database Structure

The database includes the following tables:

1. **customers**: Contains information about customers.
2. **orders**: Contains information about customer orders.
3. **products**: Contains information about products available for sale.
4. **order_items**: A new table to normalize the database by linking orders with products and quantities.

## SQL Schema

### Customers Table
```sql
CREATE TABLE customers (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name CHAR(30),
  email VARCHAR(30),
  address VARCHAR(60)
);
ALTER TABLE customers AUTO_INCREMENT = 1;
```

### Products Table
```sql
CREATE TABLE products (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name CHAR(30),
  price INT UNSIGNED,
  description VARCHAR(60)
);
ALTER TABLE products AUTO_INCREMENT = 101;
```

### Orders Table
```sql
CREATE TABLE orders (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  customer_id INT UNSIGNED NOT NULL,
  order_date DATE,
  total_price INT UNSIGNED,
  CONSTRAINT FK_customerorder FOREIGN KEY (customer_id) REFERENCES customers(id)
);
ALTER TABLE orders AUTO_INCREMENT = 1001;
```

### Order Items Table (for normalization)
```sql
CREATE TABLE order_items (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  order_id INT UNSIGNED NOT NULL,
  product_id INT UNSIGNED NOT NULL,
  quantity INT UNSIGNED DEFAULT 1,
  price INT UNSIGNED,
  CONSTRAINT FK_order FOREIGN KEY (order_id) REFERENCES orders(id),
  CONSTRAINT FK_product FOREIGN KEY (product_id) REFERENCES products(id)
);
```

## Sample Data Insertion

### Insert Data into Customers Table
```sql
INSERT INTO customers (name, email, address) VALUES
  ('vaibhav', 'vaibhav@gmail.com', 'chennai'),
  ('vaani', 'vaani@gmail.com', 'bangalore'),
  ('Ravi', 'ravi@gmail.com', 'Mumbai'),
  ('Sita', 'sita@gmail.com', 'Delhi'),
  ('viji', 'viji@gmail.com', 'chennai');
```

### Insert Data into Products Table
```sql
INSERT INTO products (name, price, description) VALUES
  ('Apple iMAC', 245000, 'apply is very good system'),
  ('imac book big', 290000, 'big mac book'),
  ('Dell laptop new', 15000, 'its very new condition laptop'),
  ('oppo f1s', 25000, 'oppo, mobile'),
  ('Samsung Galaxy', 55000, 'Samsung mobile phone'),
  ('Product C', 15000, 'High-quality headphones'),
  ('Product A', 12000, 'Multifunctional printer');
```

### Insert Data into Orders Table
```sql
INSERT INTO orders (customer_id, order_date, total_price) VALUES
  (1, CURDATE(), 290000),
  (2, CURDATE() - INTERVAL 15 DAY, 245000),
  (3, CURDATE() - INTERVAL 45 DAY, 25000),
  (4, CURDATE(), 55000),
  (4, CURDATE() - INTERVAL 30 DAY, 54000);
```

### Insert Data into Order Items Table
```sql
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
  (1001, 101, 1, 245000),
  (1002, 102, 1, 290000),
  (1003, 103, 2, 45000),
  (1004, 107, 1, 55000);
```

## Queries

### 1. Retrieve all customers who have placed an order in the last 30 days
```sql
SELECT customers.*
FROM customers
JOIN orders ON customers.id = orders.customer_id
WHERE orders.order_date >= CURDATE() - INTERVAL 30 DAY;
```

### 2. Get the total amount of all orders placed by each customer
```sql
SELECT customers.name, SUM(orders.total_price) AS total_spent
FROM customers
JOIN orders ON customers.id = orders.customer_id
GROUP BY customers.name;
```

### 3. Update the price of Product C to 45.00
```sql
UPDATE products
SET price = 45000
WHERE name = 'Product C';
```

### 4. Add a new column "discount" to the products table
```sql
ALTER TABLE products
ADD COLUMN discount INT UNSIGNED DEFAULT 0;
```

### 5. Retrieve the top 3 products with the highest price
```sql
SELECT *
FROM products
ORDER BY price DESC
LIMIT 3;
```

### 6. Get the names of customers who have ordered Product A
```sql
SELECT DISTINCT customers.name
FROM customers
JOIN orders ON customers.id = orders.customer_id
JOIN order_items ON orders.id = order_items.order_id
JOIN products ON order_items.product_id = products.id
WHERE products.name = 'Product A';
```

### 7. Join the orders and customers tables to retrieve the customer's name and order date for each order
```sql
SELECT customers.name, orders.order_date
FROM customers
JOIN orders ON customers.id = orders.customer_id;
```

### 8. Retrieve the orders with a total amount greater than 150.00
```sql
SELECT *
FROM orders
WHERE total_price > 150.00;
```

### 9. Retrieve the average total of all orders
```sql
SELECT AVG(total_price) AS average_order_price
FROM orders;
```

## Notes

- The `order_items` table was created to normalize the database by separating the details of products ordered in each order. This allows tracking multiple products in a single order, with quantity and price for each product.
- The provided queries cover the basic operations required to retrieve and manage data in an e-commerce system.

---

[View on DB Fiddle](https://www.db-fiddle.com/f/3vgGa5HgxpTcQPMrkTVGjj/1)
