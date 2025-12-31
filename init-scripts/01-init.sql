-- Initialization script for PostgreSQL
-- This script runs automatically when the container is first created

-- Create example schema
CREATE SCHEMA IF NOT EXISTS app;

-- Create example table
CREATE TABLE IF NOT EXISTS app.users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create example indexes
CREATE INDEX IF NOT EXISTS idx_users_email ON app.users(email);
CREATE INDEX IF NOT EXISTS idx_users_created_at ON app.users(created_at);

-- Insert sample data
INSERT INTO app.users (username, email) VALUES
    ('admin', 'admin@example.com'),
    ('testuser', 'test@example.com')
ON CONFLICT (username) DO NOTHING;

-- Create example function
CREATE OR REPLACE FUNCTION app.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create trigger
CREATE TRIGGER update_users_updated_at
    BEFORE UPDATE ON app.users
    FOR EACH ROW
    EXECUTE FUNCTION app.update_updated_at_column();

-- Grant permissions (if needed)
-- GRANT ALL PRIVILEGES ON SCHEMA app TO postgres;
-- GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA app TO postgres;

