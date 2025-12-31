f-- ============================================
-- CREATE PRODUCTS SCHEMA
-- ============================================
-- Drop and recreate the products schema
-- Note: CASCADE will drop all objects in the schema

DROP SCHEMA IF EXISTS products CASCADE;
CREATE SCHEMA products;

COMMENT ON SCHEMA products IS 'Schema containing product data from Cash Converters and Gumtree';


