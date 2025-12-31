-- ============================================
-- SYNC GUMTREE TO GLOBAL FUNCTION
-- ============================================
-- Drop and recreate function to sync Gumtree products to global table

DROP FUNCTION IF EXISTS products.sync_gumtree_to_global();

CREATE OR REPLACE FUNCTION products.sync_gumtree_to_global()
RETURNS INTEGER AS $$
DECLARE
    rows_affected INTEGER := 0;
BEGIN
    -- Insert or update Gumtree products into global_products
    INSERT INTO products.global_products (
        product_name, 
        description, 
        price, 
        brand, 
        region, 
        condition,
        source, 
        source_id, 
        external_link, 
        external_id, 
        view_count,
        seller_name, 
        image_count, 
        source_timestamp
    )
    SELECT 
        gt.name,
        gt.description,
        gt.price,
        gt.brand,
        gt.region_extracted,
        'used' AS condition, -- Gumtree is mostly used items
        'gumtree' AS source,
        gt.id AS source_id,
        gt.link AS external_link,
        gt.ad_id::VARCHAR AS external_id,
        gt.view_count,
        gt.seller,
        gt.images,
        gt.timestamp AS source_timestamp
    FROM products.gumtree_products gt
    ON CONFLICT (source, source_id) 
    DO UPDATE SET
        product_name = EXCLUDED.product_name,
        description = EXCLUDED.description,
        price = EXCLUDED.price,
        brand = EXCLUDED.brand,
        region = EXCLUDED.region,
        view_count = EXCLUDED.view_count,
        seller_name = EXCLUDED.seller_name,
        image_count = EXCLUDED.image_count,
        source_timestamp = EXCLUDED.source_timestamp,
        updated_at = CURRENT_TIMESTAMP;
    
    GET DIAGNOSTICS rows_affected = ROW_COUNT;
    
    RAISE NOTICE 'Synced % Gumtree products to global_products', rows_affected;
    RETURN rows_affected;
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION products.sync_gumtree_to_global() IS 'Syncs all Gumtree products to the global_products table';


