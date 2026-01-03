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


-- ============================================
-- GLOBAL CATEGORIES TABLE TRIGGER
-- ============================================
-- Drop and recreate trigger for auto-updating updated_at on global_categories

DROP TRIGGER IF EXISTS update_global_categories_updated_at ON products.global_categories;

CREATE TRIGGER update_global_categories_updated_at
    BEFORE UPDATE ON products.global_categories
    FOR EACH ROW
    EXECUTE FUNCTION products.update_updated_at_column();

COMMENT ON TRIGGER update_global_categories_updated_at ON products.global_categories 
IS 'Automatically updates updated_at timestamp when a category is modified';



