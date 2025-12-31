-- ============================================
-- PRODUCT CATEGORIES JUNCTION TABLE INDEXES
-- ============================================
-- Drop and recreate indexes for product-categories junction table

-- Drop existing indexes
DROP INDEX IF EXISTS products.idx_product_categories_product;
DROP INDEX IF EXISTS products.idx_product_categories_category;
DROP INDEX IF EXISTS products.idx_product_categories_primary;

-- Create indexes for better query performance
CREATE INDEX idx_product_categories_product ON products.product_categories(product_id);
CREATE INDEX idx_product_categories_category ON products.product_categories(category_id);
CREATE INDEX idx_product_categories_primary ON products.product_categories(is_primary) WHERE is_primary = TRUE;


