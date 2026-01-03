-- ============================================
-- CASH CONVERTERS PRODUCTS INDEXES
-- ============================================
-- Drop and recreate indexes for Cash Converters products table

-- Drop existing indexes
DROP INDEX IF EXISTS products.idx_cc_sku;
DROP INDEX IF EXISTS products.idx_cc_timestamp;
DROP INDEX IF EXISTS products.idx_cc_price;
DROP INDEX IF EXISTS products.idx_cc_region;
DROP INDEX IF EXISTS products.idx_cc_condition;

-- Create indexes for better query performance
CREATE INDEX idx_cc_sku ON products.cash_converters_products(sku);
CREATE INDEX idx_cc_timestamp ON products.cash_converters_products(timestamp);
CREATE INDEX idx_cc_price ON products.cash_converters_products(price);
CREATE INDEX idx_cc_region ON products.cash_converters_products(region);
CREATE INDEX idx_cc_condition ON products.cash_converters_products(condition);


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



