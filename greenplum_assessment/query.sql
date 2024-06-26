
CREATE TABLE IF NOT EXISTS customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email_address VARCHAR(100) NOT NULL,
    country VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
DISTRIBUTED BY (customer_id);


CREATE TABLE IF NOT EXISTS products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    category VARCHAR(50),
    stock INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
DISTRIBUTED BY (product_id);

CREATE TABLE IF NOT EXISTS sales_transactions (
    transaction_id SERIAL,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    purchase_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    quantity_purchased INT NOT NULL,
    total_amount NUMERIC(10, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (transaction_id, purchase_date),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
)
DISTRIBUTED BY (transaction_id)
PARTITION BY RANGE (purchase_date)
(
    PARTITION sales_transactions_2023_01 START ('2023-02-01') INCLUSIVE,
    PARTITION sales_transactions_2023_02 START ('2023-03-01') INCLUSIVE,
    PARTITION sales_transactions_2023_03 START ('2023-04-01') INCLUSIVE,
    PARTITION sales_transactions_2023_04 START ('2023-05-01') INCLUSIVE,
    PARTITION sales_transactions_2023_05 START ('2023-06-01') INCLUSIVE,
    PARTITION sales_transactions_2023_06 START ('2023-07-01') INCLUSIVE,
    PARTITION sales_transactions_2023_07 START ('2023-08-01') INCLUSIVE,
    PARTITION sales_transactions_2023_08 START ('2023-09-01') INCLUSIVE,
    PARTITION sales_transactions_2023_09 START ('2023-10-01') INCLUSIVE,
    PARTITION sales_transactions_2023_10 START ('2023-11-01') INCLUSIVE,
    PARTITION sales_transactions_2023_11 START ('2023-12-01') INCLUSIVE,
    PARTITION sales_transactions_2023_12 START ('2024-01-01') INCLUSIVE,
    PARTITION sales_transactions_2024_01 START ('2024-02-01') INCLUSIVE,
    PARTITION sales_transactions_2024_02 START ('2024-03-01') INCLUSIVE,
    PARTITION sales_transactions_2024_03 START ('2024-04-01') INCLUSIVE,
    PARTITION sales_transactions_2024_04 START ('2024-05-01') INCLUSIVE,
    PARTITION sales_transactions_2024_05 START ('2024-06-01') INCLUSIVE,
    PARTITION sales_transactions_2024_06 START ('2024-07-01') INCLUSIVE,
    PARTITION sales_transactions_2024_07 START ('2024-08-01') INCLUSIVE,
    PARTITION sales_transactions_2024_08 START ('2024-09-01') INCLUSIVE,
    PARTITION sales_transactions_2024_09 START ('2024-10-01') INCLUSIVE,
    PARTITION sales_transactions_2024_10 START ('2024-11-01') INCLUSIVE,
    PARTITION sales_transactions_2024_11 START ('2024-12-01') INCLUSIVE,
    PARTITION sales_transactions_2024_12 START ('2025-01-01') INCLUSIVE
);



CREATE TABLE IF NOT EXISTS shipping_details (
    transaction_id INT,
    purchase_date TIMESTAMP,
    shipping_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    shipping_address VARCHAR(255) NOT NULL,
    city VARCHAR(100),
    country VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   FOREIGN KEY (transaction_id, purchase_date) REFERENCES sales_transactions(transaction_id, purchase_date)
)
DISTRIBUTED BY (transaction_id);