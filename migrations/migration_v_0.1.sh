#!/bin/bash

# ============================================
# Migration v0.1: Brand Categories Table
# ============================================
# This script creates the brand_categories table and imports data from CSV
# Run this script from the project root directory

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
echo -e "${YELLOW}Migration v0.1: Creating Brand Categories Table${NC}"
echo -e "${YELLOW}==================================================${NC}"

# Check if CSV file exists
CSV_FILE="../Data/brand_categories.csv"
if [ ! -f "$CSV_FILE" ]; then
    echo -e "${RED}Error: CSV file not found at $CSV_FILE${NC}"
    exit 1
fi

echo -e "${GREEN}Step 1: Creating brand_categories table...${NC}"

# Create the brand_categories table
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" << EOF
-- Drop table if exists
DROP TABLE IF EXISTS ${DB_SCHEMA}.brand_categories CASCADE;

-- Create brand_categories table
CREATE TABLE ${DB_SCHEMA}.brand_categories (
    id SERIAL PRIMARY KEY,
    brand VARCHAR(100) NOT NULL,
    category_level_1 VARCHAR(255) NOT NULL,
    category_level_2 VARCHAR(255),
    category_level_3 VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Unique constraint to prevent duplicate brand-category combinations
    CONSTRAINT unique_brand_category UNIQUE (brand, category_level_1, category_level_2, category_level_3)
);

-- Add comments
COMMENT ON TABLE ${DB_SCHEMA}.brand_categories IS 'Brand and their associated product categories';
COMMENT ON COLUMN ${DB_SCHEMA}.brand_categories.brand IS 'Brand name (e.g., Apple, Samsung)';
COMMENT ON COLUMN ${DB_SCHEMA}.brand_categories.category_level_1 IS 'Top level category (e.g., Cellphones & Tablets)';
COMMENT ON COLUMN ${DB_SCHEMA}.brand_categories.category_level_2 IS 'Second level category (e.g., Cellphones)';
COMMENT ON COLUMN ${DB_SCHEMA}.brand_categories.category_level_3 IS 'Third level category (e.g., Handset)';

-- Create indexes for better query performance
CREATE INDEX idx_brand_categories_brand ON ${DB_SCHEMA}.brand_categories(brand);
CREATE INDEX idx_brand_categories_level1 ON ${DB_SCHEMA}.brand_categories(category_level_1);
CREATE INDEX idx_brand_categories_level2 ON ${DB_SCHEMA}.brand_categories(category_level_2);

EOF

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Table created successfully${NC}"
else
    echo -e "${RED}✗ Failed to create table${NC}"
    exit 1
fi

echo -e "${GREEN}Step 2: Importing CSV data...${NC}"

# Import CSV data using \copy command
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" << EOF
\copy ${DB_SCHEMA}.brand_categories(brand, category_level_1, category_level_2, category_level_3) FROM '${CSV_FILE}' WITH (FORMAT csv, HEADER true, DELIMITER ',', NULL '');
EOF

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Data imported successfully${NC}"
else
    echo -e "${RED}✗ Failed to import data${NC}"
    exit 1
fi

# Get count of imported records
RECORD_COUNT=$(psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -t -c "SELECT COUNT(*) FROM ${DB_SCHEMA}.brand_categories;")

echo -e "${GREEN}Step 3: Verification${NC}"
echo -e "${GREEN}✓ Total records imported: ${RECORD_COUNT}${NC}"

# Show sample data
echo -e "${YELLOW}Sample data (first 5 rows):${NC}"
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" << EOF
SELECT id, brand, category_level_1, category_level_2, category_level_3 
FROM ${DB_SCHEMA}.brand_categories 
LIMIT 5;
EOF

echo -e "${GREEN}==================================================${NC}"
echo -e "${GREEN}Migration v0.1 completed successfully!${NC}"
echo -e "${GREEN}==================================================${NC}"

# Unset password for security
unset PGPASSWORD

