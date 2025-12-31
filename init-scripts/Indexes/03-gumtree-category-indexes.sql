-- ============================================
-- GUMTREE PRODUCTS CATEGORY INDEXES
-- ============================================
-- Drop and recreate indexes for Gumtree category table

-- Drop existing indexes
DROP INDEX IF EXISTS products.idx_gtc_ad_id;
DROP INDEX IF EXISTS products.idx_gtc_brand;

-- Create indexes for better query performance
CREATE INDEX idx_gtc_ad_id ON products.gumtree_products_category(ad_id);
CREATE INDEX idx_gtc_brand ON products.gumtree_products_category(brand);


