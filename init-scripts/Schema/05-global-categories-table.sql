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


