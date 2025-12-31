-- ============================================
-- GUMTREE PRODUCTS INDEXES
-- ============================================
-- Drop and recreate indexes for Gumtree products table

-- Drop existing indexes
DROP INDEX IF EXISTS products.idx_gt_ad_id;
DROP INDEX IF EXISTS products.idx_gt_timestamp;
DROP INDEX IF EXISTS products.idx_gt_price;
DROP INDEX IF EXISTS products.idx_gt_brand;
DROP INDEX IF EXISTS products.idx_gt_region;
DROP INDEX IF EXISTS products.idx_gt_seller;

-- Create indexes for better query performance
CREATE INDEX idx_gt_ad_id ON products.gumtree_products(ad_id);
CREATE INDEX idx_gt_timestamp ON products.gumtree_products(timestamp);
CREATE INDEX idx_gt_price ON products.gumtree_products(price);
CREATE INDEX idx_gt_brand ON products.gumtree_products(brand);
CREATE INDEX idx_gt_region ON products.gumtree_products(region_extracted);
CREATE INDEX idx_gt_seller ON products.gumtree_products(seller);


