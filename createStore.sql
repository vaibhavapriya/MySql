
    CREATE TABLE  customers(
      id	INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
      name	CHAR(30),
      email VARCHAR(30),
      address VARCHAR(60));
    ALTER TABLE customers AUTO_INCREMENT = 1;

    CREATE TABLE  products(
      id	INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
      name	CHAR(30),
      price INT UNSIGNED,
      description VARCHAR(60));
      ALTER TABLE products AUTO_INCREMENT =101;

     CREATE TABLE  orders(
      id	INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
      customer_id	INT UNSIGNED NOT NULL,
      order_date DATE,
      total_price INT UNSIGNED,
      CONSTRAINT FK_customerorder FOREIGN KEY (customer_id) REFERENCES customers(id));
      ALTER TABLE orders AUTO_INCREMENT =1001;


     INSERT INTO customers (name, email, address) VALUES
    ('vaibhav','vaibhav@gmail.com','chennai'),
    ('vaani','vaani@gmail.com','bangalore'),
    ('Ravi', 'ravi@gmail.com', 'Mumbai'),
    ('Sita', 'sita@gmail.com', 'Delhi'),
    ('viji','viji@gmail.com','chennai');
    
    INSERT INTO products (name, price, description) VALUES
    ('Apple iMAC', 245000, 'apply is very good system'),
    ('imac book big', 290000, 'big mac book'),
    ('Dell laptop new', 15000, 'its very new condition laptop'),
    ('oppo f1s', 25000, 'oppo, mobile'),
    ('Samsung Galaxy', 55000, 'Samsung mobile phone'),
    ('Product C', 15000, 'High-quality headphones'),
    ('Product A', 12000, 'Multifunctional printer');
    
    INSERT INTO orders (customer_id, order_date, total_price) VALUES
    (1, CURDATE(), 290000),  
    (2, CURDATE() - INTERVAL 15 DAY, 245000), 
    (3, CURDATE() - INTERVAL 45 DAY, 25000),  
    (4, CURDATE(), 55000), 
    (4, CURDATE() - INTERVAL 30 DAY, 54000);

    
    UPDATE products
    SET price = 45000
    WHERE name = 'Product C';
    
    ALTER TABLE products
    ADD COLUMN discount INT UNSIGNED DEFAULT 0;
    
    CREATE TABLE order_items (
      id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
      order_id INT UNSIGNED NOT NULL,
      product_id INT UNSIGNED NOT NULL,
      quantity INT UNSIGNED DEFAULT 1,
      price INT UNSIGNED,
      CONSTRAINT FK_order FOREIGN KEY (order_id) REFERENCES orders(id),
      CONSTRAINT FK_product FOREIGN KEY (product_id) REFERENCES products(id)
    );
    
    INSERT INTO order_items (order_id, product_id, quantity, price)
    VALUES
    (1001, 101, 1, 245000),
    (1002, 102, 1, 290000),  
    (1003, 103, 1, 45000),   
    (1004, 107, 2, 55000);

    select * from customers;
    select * from products;
    select * from orders;

    SELECT customers.*
    FROM customers
    JOIN orders ON customers.id = orders.customer_id
    WHERE orders.order_date >= CURDATE() - INTERVAL 30 DAY;

    SELECT customers.name, SUM(orders.total_price) AS total_spent
    FROM customers
    JOIN orders ON customers.id = orders.customer_id
    GROUP BY customers.name;

    SELECT *
    FROM products
    ORDER BY price DESC
    LIMIT 3;

    SELECT DISTINCT customers.name
    FROM customers
    JOIN orders ON customers.id = orders.customer_id
    JOIN order_items ON orders.id = order_items.order_id
    JOIN products ON order_items.product_id = products.id 
    WHERE products.name = 'Product A';


    SELECT customers.name, orders.order_date
    FROM customers
    JOIN orders ON customers.id = orders.customer_id;

    SELECT *
    FROM orders
    WHERE total_price > 150.00;

    SELECT AVG(total_price) AS average_order_price
    FROM orders;


