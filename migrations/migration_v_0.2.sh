#!/bin/bash

# ============================================
# Migration v0.2: Cash Crusaders Products Table
# ============================================
# This script creates the cash_crusaders_products table

set -e  # Exit on any error

# Database connection variables
DB_HOST="localhost"
DB_PORT="5433"
DB_NAME="Ubuntsugi_Products"
DB_USER="postgres"
DB_SCHEMA="products"
export PGPASSWORD="postgres"

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}==================================================${NC}"
echo -e "${YELLOW}Migration v0.2: Creating Cash Crusaders Table${NC}"
echo -e "${YELLOW}==================================================${NC}"

echo -e "${GREEN}Creating cash_crusaders_products table...${NC}"

# Create the cash_crusaders_products table
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" << EOF
-- Drop table if exists
DROP TABLE IF EXISTS ${DB_SCHEMA}.cash_crusaders_products CASCADE;

-- Create cash_crusaders_products table
CREATE TABLE ${DB_SCHEMA}.cash_crusaders_products (
    id SERIAL PRIMARY KEY,
    link TEXT,
    name TEXT,
    sku VARCHAR(100) UNIQUE,
    region VARCHAR(255),
    category VARCHAR(255),
    categories TEXT,
    description TEXT,
    price DECIMAL(10, 2),
    stock_status VARCHAR(100),
    brand VARCHAR(100),
    timestamp TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Add comments
COMMENT ON TABLE ${DB_SCHEMA}.cash_crusaders_products IS 'Raw product data from Cash Crusaders';
COMMENT ON COLUMN ${DB_SCHEMA}.cash_crusaders_products.sku IS 'Stock Keeping Unit - unique product identifier';
COMMENT ON COLUMN ${DB_SCHEMA}.cash_crusaders_products.categories IS 'Comma-separated list of categories';
COMMENT ON COLUMN ${DB_SCHEMA}.cash_crusaders_products.stock_status IS 'Current stock availability status';

-- Create indexes for better query performance
CREATE INDEX idx_cash_sku ON ${DB_SCHEMA}.cash_crusaders_products(sku);
CREATE INDEX idx_cash_timestamp ON ${DB_SCHEMA}.cash_crusaders_products(timestamp);
CREATE INDEX idx_cash_price ON ${DB_SCHEMA}.cash_crusaders_products(price);
CREATE INDEX idx_cash_region ON ${DB_SCHEMA}.cash_crusaders_products(region);
CREATE INDEX idx_cash_brand ON ${DB_SCHEMA}.cash_crusaders_products(brand);

EOF

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Table created successfully${NC}"
else
    echo -e "${RED}✗ Failed to create table${NC}"
    exit 1
fi

echo -e "${GREEN}==================================================${NC}"
echo -e "${GREEN}Migration v0.2 completed successfully!${NC}"
echo -e "${GREEN}==================================================${NC}"

# Unset password for security
unset PGPASSWORD

