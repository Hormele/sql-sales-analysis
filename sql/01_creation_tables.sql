create table users (
	user_id int,
    first_name varchar(100),
    last_name varchar(100),
    age int,
    gender varchar(100),
    country varchar(100),
    city varchar(100),
    created_at datetime
);

CREATE TABLE products (
	product_id INT,
    product_name VARCHAR(255),
    category VARCHAR(100),
    brand VARCHAR(100),
    retail_price DECIMAL(10,2),
    cost DECIMAL(10,2),
    department VARCHAR(100)
);

CREATE TABLE orders (
    order_id INT,
    user_id INT,
    status VARCHAR(50),
    gender VARCHAR(20),
    created_at DATETIME,
    returned_at DATETIME,
    shipped_at DATETIME,
    delivered_at DATETIME
);

CREATE TABLE order_items (
    order_item_id INT,
    order_id INT,
    user_id INT,
    product_id INT,
    inventory_item_id INT,
    status VARCHAR(50),
    created_at DATETIME,
    shipped_at DATETIME,
    delivered_at DATETIME,
    returned_at DATETIME

);
