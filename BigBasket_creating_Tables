-- CREATING DATABASE
CREATE DATABASE bigbasket;

-- DATA IS IMPORTED USING PYTHON

-- TO MAKE RELATION IN TABLES
-- PYTHON CONVERTS ALL ALL COLUMNS DATATYPES INTO TEXT OR BIGINT SO I CONVERT ALL DATA RELATIONAL DATA TYPES
-- INTO VARCHAR THEN PRIMARY KEY AND GIVE RELATION USING FORIGEN KEY

ALTER TABLE products
MODIFY product_id VARCHAR(30);

ALTER TABLE customers
MODIFY customer_id VARCHAR(30);

ALTER TABLE orders
MODIFY order_id VARCHAR(30),
MODIFY customer_id VARCHAR(30);

ALTER TABLE order_items
MODIFY order_id VARCHAR(30),
MODIFY product_id VARCHAR(30);

ALTER TABLE inventory
MODIFY product_id VARCHAR(30);

ALTER TABLE inventory_new
MODIFY product_id VARCHAR(30);

ALTER TABLE delivery_performance
MODIFY delivery_partner_id VARCHAR(30),
MODIFY order_id VARCHAR(30);

ALTER TABLE marketing_performance
MODIFY campaign_id VARCHAR(30);

ALTER TABLE customer_feedback
MODIFY feedback_id VARCHAR(30),
MODIFY customer_id VARCHAR(30),
MODIFY order_id VARCHAR(30);


-- PRODUCTS
ALTER TABLE products
ADD PRIMARY KEY (product_id);

-- ORDERS
ALTER TABLE orders
ADD PRIMARY KEY (order_id);

-- ORDER ITEMS (composite key – correct design)
ALTER TABLE order_items
ADD PRIMARY KEY (order_id, product_id);

-- INVENTORY
ALTER TABLE inventory
ADD PRIMARY KEY (product_id);

ALTER TABLE inventory
ADD COLUMN inventory_id INT AUTO_INCREMENT PRIMARY KEY;

ALTER TABLE inventory
ADD CONSTRAINT fk_inventory_products
FOREIGN KEY (product_id)
REFERENCES products(product_id);

ALTER TABLE inventory_new
ADD CONSTRAINT fk_inventory_new_products
FOREIGN KEY (product_id)
REFERENCES products(product_id);

-- INVENTORY NEW
ALTER TABLE inventory_new
ADD PRIMARY KEY (product_id);

-- DELIVERY PERFORMANCE
ALTER TABLE delivery_performance
ADD PRIMARY KEY (delivery_partner_id);

-- MARKETING PERFORMANCE
ALTER TABLE marketing_performance
ADD PRIMARY KEY (campaign_id);

-- CUSTOMER FEEDBACK
ALTER TABLE customer_feedback
ADD PRIMARY KEY (feedback_id);

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);


ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_orders
FOREIGN KEY (order_id)
REFERENCES orders(order_id);


ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_products
FOREIGN KEY (product_id)
REFERENCES products(product_id);


ALTER TABLE delivery_performance
ADD CONSTRAINT fk_delivery_orders
FOREIGN KEY (order_id)
REFERENCES orders(order_id);


ALTER TABLE customer_feedback
ADD CONSTRAINT fk_feedback_customers
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);


ALTER TABLE customer_feedback
ADD CONSTRAINT fk_feedback_orders
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

ALTER TABLE customers
ADD PRIMARY KEY (customer_id);

