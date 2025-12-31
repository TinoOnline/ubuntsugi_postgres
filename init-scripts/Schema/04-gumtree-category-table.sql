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


