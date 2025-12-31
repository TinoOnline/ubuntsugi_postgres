-- ============================================
-- SYNC CASH CONVERTERS TO GLOBAL FUNCTION
-- ============================================
-- Drop and recreate function to sync Cash Converters products to global table

DROP FUNCTION IF EXISTS products.sync_cash_converters_to_global();

CREATE OR REPLACE FUNCTION products.sync_cash_converters_to_global()
RETURNS INTEGER AS $$
DECLARE
    rows_affected INTEGER := 0;
BEGIN
    -- Insert or update Cash Converters products into global_products
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
        stock_status,
        source_timestamp
    )
    SELECT 
        cc.name,
        cc.description,
        cc.price,
        NULL AS brand, -- Cash Converters data doesn't have brand field
        cc.region,
        cc.condition,
        'cash_converters' AS source,
        cc.id AS source_id,
        cc.link AS external_link,
        cc.sku AS external_id,
        cc.stock_status,
        cc.timestamp AS source_timestamp
    FROM products.cash_converters_products cc
    ON CONFLICT (source, source_id) 
    DO UPDATE SET
        product_name = EXCLUDED.product_name,
        description = EXCLUDED.description,
        price = EXCLUDED.price,
        region = EXCLUDED.region,
        condition = EXCLUDED.condition,
        stock_status = EXCLUDED.stock_status,
        source_timestamp = EXCLUDED.source_timestamp,
        updated_at = CURRENT_TIMESTAMP;
    
    GET DIAGNOSTICS rows_affected = ROW_COUNT;
    
    RAISE NOTICE 'Synced % Cash Converters products to global_products', rows_affected;
    RETURN rows_affected;
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION products.sync_cash_converters_to_global() IS 'Syncs all Cash Converters products to the global_products table';


