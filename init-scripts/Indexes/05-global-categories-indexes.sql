-- ============================================
-- GLOBAL CATEGORIES INDEXES
-- ============================================
-- Drop and recreate indexes for global categories table

-- Drop existing indexes
DROP INDEX IF EXISTS products.idx_global_categories_name;
DROP INDEX IF EXISTS products.idx_global_categories_parent;
DROP INDEX IF EXISTS products.idx_global_categories_path;

-- Create indexes for better query performance
CREATE INDEX idx_global_categories_name ON products.global_categories(category_name);
CREATE INDEX idx_global_categories_parent ON products.global_categories(parent_category);
CREATE INDEX idx_global_categories_path ON products.global_categories(category_path);


