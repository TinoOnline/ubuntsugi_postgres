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


