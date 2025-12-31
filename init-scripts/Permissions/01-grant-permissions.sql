-- ============================================
-- GRANT PERMISSIONS
-- ============================================
-- Grant appropriate permissions on all objects in products schema

-- Grant usage on schema
GRANT USAGE ON SCHEMA products TO postgres;

-- Grant permissions on all tables
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA products TO postgres;

-- Grant permissions on all sequences
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA products TO postgres;

-- Grant permissions on all functions
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA products TO postgres;

-- Ensure future objects get permissions automatically
ALTER DEFAULT PRIVILEGES IN SCHEMA products 
    GRANT ALL ON TABLES TO postgres;

ALTER DEFAULT PRIVILEGES IN SCHEMA products 
    GRANT ALL ON SEQUENCES TO postgres;

ALTER DEFAULT PRIVILEGES IN SCHEMA products 
    GRANT EXECUTE ON FUNCTIONS TO postgres;

-- Note: For production, you should create separate roles with limited permissions
-- Example for read-only user:
-- CREATE ROLE readonly_user WITH LOGIN PASSWORD 'secure_password';
-- GRANT USAGE ON SCHEMA products TO readonly_user;
-- GRANT SELECT ON ALL TABLES IN SCHEMA products TO readonly_user;

-- Example for application user:
-- CREATE ROLE app_user WITH LOGIN PASSWORD 'secure_password';
-- GRANT USAGE ON SCHEMA products TO app_user;
-- GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA products TO app_user;
-- GRANT USAGE ON ALL SEQUENCES IN SCHEMA products TO app_user;


