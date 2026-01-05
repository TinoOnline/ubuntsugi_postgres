#!/bin/bash

# ============================================
# Migration v0.3: Add Brand Category Column
# ============================================
# This script adds brand_category_id column to product tables
# for gumtree_products, cash_converters_products, and cash_crusaders_products tables

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
echo -e "${YELLOW}Migration v0.3: Adding Brand Category Column${NC}"
echo -e "${YELLOW}==================================================${NC}"

echo -e "${GREEN}Step 1: Adding brand_category_id column to cash_converters_products...${NC}"

psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" << EOF
ALTER TABLE ${DB_SCHEMA}.cash_converters_products 
ADD COLUMN IF NOT EXISTS brand_category_id INTEGER;
EOF

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Cash Converters table updated successfully${NC}"
else
    echo -e "${RED}✗ Failed to update Cash Converters table${NC}"
    exit 1
fi

echo -e "${GREEN}Step 2: Adding brand_category_id column to gumtree_products...${NC}"

psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" << EOF
ALTER TABLE ${DB_SCHEMA}.gumtree_products 
ADD COLUMN IF NOT EXISTS brand_category_id INTEGER;
EOF

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Gumtree table updated successfully${NC}"
else
    echo -e "${RED}✗ Failed to update Gumtree table${NC}"
    exit 1
fi

echo -e "${GREEN}Step 3: Adding brand_category_id column to cash_crusaders_products...${NC}"

psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" << EOF
ALTER TABLE ${DB_SCHEMA}.cash_crusaders_products 
ADD COLUMN IF NOT EXISTS brand_category_id INTEGER;
EOF

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Cash Crusaders table updated successfully${NC}"
else
    echo -e "${RED}✗ Failed to update Cash Crusaders table${NC}"
    exit 1
fi

echo -e "${GREEN}Step 4: Verification${NC}"

psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" << EOF
SELECT 'cash_converters_products' as table_name, 
       column_name, 
       data_type,
       is_nullable
FROM information_schema.columns 
WHERE table_schema = '${DB_SCHEMA}' 
  AND table_name = 'cash_converters_products'
  AND column_name = 'brand_category_id'
UNION ALL
SELECT 'gumtree_products' as table_name, 
       column_name, 
       data_type,
       is_nullable
FROM information_schema.columns 
WHERE table_schema = '${DB_SCHEMA}' 
  AND table_name = 'gumtree_products'
  AND column_name = 'brand_category_id'
UNION ALL
SELECT 'cash_crusaders_products' as table_name, 
       column_name, 
       data_type,
       is_nullable
FROM information_schema.columns 
WHERE table_schema = '${DB_SCHEMA}' 
  AND table_name = 'cash_crusaders_products'
  AND column_name = 'brand_category_id';
EOF

echo -e "${GREEN}==================================================${NC}"
echo -e "${GREEN}Migration v0.3 completed successfully!${NC}"
echo -e "${GREEN}==================================================${NC}"

# Unset password for security
unset PGPASSWORD

