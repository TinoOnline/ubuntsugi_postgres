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


