-- ============================================
-- GLOBAL PRODUCTS TABLE
-- ============================================
-- Drop and recreate global unified products table

DROP TABLE IF EXISTS products.global_products CASCADE;

CREATE TABLE products.global_products (
    id SERIAL PRIMARY KEY,
    
    -- Common fields
    product_name TEXT NOT NULL,
    description TEXT,
    price DECIMAL(10, 2),
    brand VARCHAR(100),
    region VARCHAR(255),
    condition VARCHAR(50), -- 'new', 'used', 'refurbished', etc.
    
    -- Source tracking
    source VARCHAR(50) NOT NULL,
    source_id INTEGER,
    external_link TEXT,
    external_id VARCHAR(255),
    
    -- Additional metadata
    stock_status VARCHAR(100),
    view_count INTEGER DEFAULT 0,
    seller_name VARCHAR(255),
    image_count INTEGER DEFAULT 0,
    
    -- Timestamps
    source_timestamp TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Constraints
    CONSTRAINT chk_source CHECK (source IN ('cash_converters', 'gumtree')),
    CONSTRAINT unique_source_product UNIQUE (source, source_id)
);

COMMENT ON TABLE products.global_products IS 'Unified product table combining data from all sources';

COMMENT ON COLUMN products.global_products.source IS 'Source platform: cash_converters or gumtree';
COMMENT ON COLUMN products.global_products.source_id IS 'ID from the source table';
COMMENT ON COLUMN products.global_products.external_id IS 'SKU for Cash Converters, ad_id for Gumtree';
COMMENT ON COLUMN products.global_products.source_timestamp IS 'Original timestamp from source platform';


