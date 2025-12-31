-- ============================================
-- HELPER VIEWS
-- ============================================
-- Drop and recreate views for easier data access

-- Drop existing views
DROP VIEW IF EXISTS products.products_with_categories;
DROP VIEW IF EXISTS products.product_stats_by_source;
DROP VIEW IF EXISTS products.popular_categories;

-- View: Products with their categories
CREATE OR REPLACE VIEW products.products_with_categories AS
SELECT 
    gp.id,
    gp.product_name,
    gp.brand,
    gp.price,
    gp.condition,
    gp.source,
    gp.region,
    STRING_AGG(gc.category_name, ', ' ORDER BY gc.category_name) AS categories,
    gp.view_count,
    gp.seller_name,
    gp.stock_status,
    gp.created_at,
    gp.updated_at
FROM products.global_products gp
LEFT JOIN products.product_categories pc ON gp.id = pc.product_id
LEFT JOIN products.global_categories gc ON pc.category_id = gc.id
GROUP BY gp.id, gp.product_name, gp.brand, gp.price, gp.condition, 
         gp.source, gp.region, gp.view_count, gp.seller_name, 
         gp.stock_status, gp.created_at, gp.updated_at;

COMMENT ON VIEW products.products_with_categories IS 'View showing products with their associated categories as comma-separated list';

-- View: Product statistics by source
CREATE OR REPLACE VIEW products.product_stats_by_source AS
SELECT 
    source,
    COUNT(*) AS total_products,
    ROUND(AVG(price), 2) AS avg_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    COUNT(DISTINCT brand) AS unique_brands,
    COUNT(DISTINCT region) AS unique_regions,
    SUM(view_count) AS total_views
FROM products.global_products
GROUP BY source;

COMMENT ON VIEW products.product_stats_by_source IS 'Statistical summary of products grouped by source platform';

-- View: Popular categories
CREATE OR REPLACE VIEW products.popular_categories AS
SELECT 
    gc.id,
    gc.category_name,
    gc.category_path,
    COUNT(pc.product_id) AS product_count,
    ROUND(AVG(gp.price), 2) AS avg_price,
    MIN(gp.price) AS min_price,
    MAX(gp.price) AS max_price
FROM products.global_categories gc
LEFT JOIN products.product_categories pc ON gc.id = pc.category_id
LEFT JOIN products.global_products gp ON pc.product_id = gp.id
GROUP BY gc.id, gc.category_name, gc.category_path
ORDER BY product_count DESC;

COMMENT ON VIEW products.popular_categories IS 'Categories ranked by product count with pricing statistics';


