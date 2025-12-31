f-- ============================================
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
    creation INTEGER,
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


