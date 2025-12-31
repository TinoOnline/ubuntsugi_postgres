-- ============================================
-- CASH CONVERTERS PRODUCTS TABLE
-- ============================================
-- Drop and recreate Cash Converters products table

DROP TABLE IF EXISTS products.cash_converters_products CASCADE;

CREATE TABLE products.cash_converters_products (
    id SERIAL PRIMARY KEY,
    link TEXT,
    name TEXT,
    sku VARCHAR(100),
    region VARCHAR(255),
    category VARCHAR(255),
    categories TEXT,
    description TEXT,
    price DECIMAL(10, 2),
    condition VARCHAR(50),
    stock_status VARCHAR(100),
    timestamp TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE products.cash_converters_products IS 'Raw product data from Cash Converters';

COMMENT ON COLUMN products.cash_converters_products.sku IS 'Stock Keeping Unit - unique product identifier';
COMMENT ON COLUMN products.cash_converters_products.categories IS 'Comma-separated list of categories';
COMMENT ON COLUMN products.cash_converters_products.stock_status IS 'Current stock availability status';


