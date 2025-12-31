-- ============================================
-- UPDATE TIMESTAMP FUNCTION
-- ============================================
-- Drop and recreate function to auto-update updated_at column

DROP FUNCTION IF EXISTS products.update_updated_at_column() CASCADE;

CREATE OR REPLACE FUNCTION products.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION products.update_updated_at_column() IS 'Automatically updates the updated_at timestamp when a row is modified';


