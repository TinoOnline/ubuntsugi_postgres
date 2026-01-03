-- ============================================
-- CREATE PRODUCTS SCHEMA
-- ============================================
-- Drop and recreate the products schema
-- Note: CASCADE will drop all objects in the schema

DROP SCHEMA IF EXISTS products CASCADE;
CREATE SCHEMA products;

COMMENT ON SCHEMA products IS 'Schema containing product data from Cash Converters and Gumtree';


-- ============================================
-- CASH CONVERTERS PRODUCTS TABLE
-- ============================================
-- Drop and recreate Cash Converters products table

DROP TABLE IF EXISTS products.cash_converters_products CASCADE;

CREATE TABLE products.cash_converters_products (
    id SERIAL PRIMARY KEY,
    link TEXT,
    name TEXT,
    sku VARCHAR(100) UNIQUE,
    region VARCHAR(255),
    category VARCHAR(255),
    categories TEXT,
    description TEXT,
    price DECIMAL(10, 2),
    condition VARCHAR(50),
    stock_status VARCHAR(100),
    timestamp TIMESTAMP,
    brand VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE products.cash_converters_products IS 'Raw product data from Cash Converters';

COMMENT ON COLUMN products.cash_converters_products.sku IS 'Stock Keeping Unit - unique product identifier';
COMMENT ON COLUMN products.cash_converters_products.categories IS 'Comma-separated list of categories';
COMMENT ON COLUMN products.cash_converters_products.stock_status IS 'Current stock availability status';


-- ============================================
-- GUMTREE PRODUCTS TABLE
-- ============================================
-- Drop and recreate Gumtree products table

DROP TABLE IF EXISTS products.gumtree_products CASCADE;
CREATE TABLE products.gumtree_products (
    id SERIAL PRIMARY KEY,
    link TEXT,
    category VARCHAR(255),
    region VARCHAR(255),
    name_extracted TEXT,
    link_id VARCHAR(255),
    ad_id BIGINT UNIQUE NOT NULL,
    name TEXT,
    seller VARCHAR(255),
    price DECIMAL(10, 2),
    total_ads INTEGER,
    total_views INTEGER,
    view_count INTEGER,
    creation FLOAT,
    images INTEGER,
    seller_years INTEGER,
    active_ads INTEGER,
    region_extracted VARCHAR(255),
    phone_start VARCHAR(10),
    description TEXT,
    timestamp TIMESTAMP,
    brand VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE products.gumtree_products IS 'Raw product data from Gumtree';

COMMENT ON COLUMN products.gumtree_products.ad_id IS 'Unique advertisement ID from Gumtree';
COMMENT ON COLUMN products.gumtree_products.seller_years IS 'Number of years seller has been active';
COMMENT ON COLUMN products.gumtree_products.view_count IS 'Number of times the ad has been viewed';


-- ============================================
-- GUMTREE PRODUCTS CATEGORY TABLE
-- ============================================
-- Drop and recreate Gumtree product categories table

DROP TABLE IF EXISTS products.gumtree_products_category CASCADE;

CREATE TABLE products.gumtree_products_category (
    id SERIAL PRIMARY KEY,
    ad_id BIGINT NOT NULL,
    directories TEXT,
    brand VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign key constraint
    CONSTRAINT fk_gumtree_ad FOREIGN KEY (ad_id) 
        REFERENCES products.gumtree_products(ad_id) 
        ON DELETE CASCADE
);

COMMENT ON TABLE products.gumtree_products_category IS 'Category mappings for Gumtree products';

COMMENT ON COLUMN products.gumtree_products_category.directories IS 'Semicolon-separated category hierarchy path';
COMMENT ON COLUMN products.gumtree_products_category.ad_id IS 'Reference to Gumtree product advertisement';


-- ============================================
-- GLOBAL CATEGORIES TABLE
-- ============================================
-- Drop and recreate global normalized categories table

DROP TABLE IF EXISTS products.global_categories CASCADE;

CREATE TABLE products.global_categories (
    id SERIAL PRIMARY KEY,
    category_name VARCHAR(255) UNIQUE NOT NULL,
    category_path TEXT,
    parent_category VARCHAR(255),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE products.global_categories IS 'Normalized category table for all products';

COMMENT ON COLUMN products.global_categories.category_name IS 'Unique category name';
COMMENT ON COLUMN products.global_categories.category_path IS 'Full hierarchical path (e.g., "Electronics > Phones > iPhone")';
COMMENT ON COLUMN products.global_categories.parent_category IS 'Parent category name for hierarchical structure';


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


-- ============================================
-- PRODUCT CATEGORIES JUNCTION TABLE
-- ============================================
-- Drop and recreate junction table for many-to-many relationship

DROP TABLE IF EXISTS products.product_categories CASCADE;

CREATE TABLE products.product_categories (
    id SERIAL PRIMARY KEY,
    product_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    is_primary BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign key constraints
    CONSTRAINT fk_product FOREIGN KEY (product_id) 
        REFERENCES products.global_products(id) 
        ON DELETE CASCADE,
    CONSTRAINT fk_category FOREIGN KEY (category_id) 
        REFERENCES products.global_categories(id) 
        ON DELETE CASCADE,
    
    -- Unique constraint to prevent duplicate relationships
    CONSTRAINT unique_product_category UNIQUE (product_id, category_id)
);

COMMENT ON TABLE products.product_categories IS 'Junction table for many-to-many product-category relationships';

COMMENT ON COLUMN products.product_categories.product_id IS 'Reference to global_products table';
COMMENT ON COLUMN products.product_categories.category_id IS 'Reference to global_categories table';
COMMENT ON COLUMN products.product_categories.is_primary IS 'Indicates if this is the primary category for the product';


