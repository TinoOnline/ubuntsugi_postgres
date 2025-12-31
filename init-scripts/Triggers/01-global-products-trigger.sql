-- ============================================
-- GLOBAL PRODUCTS TABLE TRIGGER
-- ============================================
-- Drop and recreate trigger for auto-updating updated_at on global_products

DROP TRIGGER IF EXISTS update_global_products_updated_at ON products.global_products;

CREATE TRIGGER update_global_products_updated_at
    BEFORE UPDATE ON products.global_products
    FOR EACH ROW
    EXECUTE FUNCTION products.update_updated_at_column();

COMMENT ON TRIGGER update_global_products_updated_at ON products.global_products 
IS 'Automatically updates updated_at timestamp when a product is modified';


