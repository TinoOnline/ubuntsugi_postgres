-- ============================================
-- GLOBAL PRODUCTS INDEXES
-- ============================================
-- Drop and recreate indexes for global products table

-- Drop existing indexes
DROP INDEX IF EXISTS products.idx_global_products_source;
DROP INDEX IF EXISTS products.idx_global_products_brand;
DROP INDEX IF EXISTS products.idx_global_products_price;
DROP INDEX IF EXISTS products.idx_global_products_condition;
DROP INDEX IF EXISTS products.idx_global_products_created;
DROP INDEX IF EXISTS products.idx_global_products_region;
DROP INDEX IF EXISTS products.idx_global_products_name;

-- Create indexes for better query performance
CREATE INDEX idx_global_products_source ON products.global_products(source);
CREATE INDEX idx_global_products_brand ON products.global_products(brand);
CREATE INDEX idx_global_products_price ON products.global_products(price);
CREATE INDEX idx_global_products_condition ON products.global_products(condition);
CREATE INDEX idx_global_products_created ON products.global_products(created_at);
CREATE INDEX idx_global_products_region ON products.global_products(region);
CREATE INDEX idx_global_products_name ON products.global_products(product_name);


