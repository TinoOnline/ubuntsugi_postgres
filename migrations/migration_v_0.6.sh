#!/bin/bash

# ============================================
# Migration v0.6: Map Cash Crusaders Categories
# ============================================
# This script maps cash_crusaders_products categories to brand_category_id

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
echo -e "${YELLOW}Migration v0.6: Mapping Cash Crusaders Categories${NC}"
echo -e "${YELLOW}==================================================${NC}"

echo -e "${GREEN}Step 1: Mapping categories to brand_category_id...${NC}"

psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" << 'EOF'
-- Update TV Audio & Video categories
UPDATE products.cash_crusaders_products
SET brand_category_id = (
    SELECT id FROM products.brand_categories 
    WHERE category_level_1 = 'TV Audio & Video' 
    LIMIT 1
)
WHERE category IN (
    'Cameras', 'Gaming Consoles', 'Audio Players', 'Home Entertainment',
    'Games', 'Car Audio', 'DJ Equipment'
);

-- Update Computers & Peripherals categories
UPDATE products.cash_crusaders_products
SET brand_category_id = (
    SELECT id FROM products.brand_categories 
    WHERE category_level_1 = 'Computers & Peripherals' 
    LIMIT 1
)
WHERE category IN (
    'Computers'
);

-- Update Cellphones & Tablets categories
UPDATE products.cash_crusaders_products
SET brand_category_id = (
    SELECT id FROM products.brand_categories 
    WHERE category_level_1 = 'Cellphones & Tablets' 
    LIMIT 1
)
WHERE category IN (
    'Phones'
);

-- Update Other categories
UPDATE products.cash_crusaders_products
SET brand_category_id = (
    SELECT id FROM products.brand_categories 
    WHERE category_level_1 = 'Other' 
    LIMIT 1
)
WHERE category IN (
    'Large Appliances', 'Power Tools', 'Outdoor Goods', 'Small Appliances',
    'Home Appliances', 'Musical Instruments', 'Watches'
);

EOF

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Categories mapped successfully${NC}"
else
    echo -e "${RED}✗ Failed to map categories${NC}"
    exit 1
fi

echo -e "${GREEN}Step 2: Verification${NC}"

psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" << 'EOF'
-- Show mapping statistics
SELECT 
    CASE 
        WHEN bc.category_level_1 IS NULL THEN 'Unmapped'
        ELSE bc.category_level_1
    END as category_type,
    COUNT(*) as product_count
FROM products.cash_crusaders_products cc
LEFT JOIN products.brand_categories bc ON cc.brand_category_id = bc.id
GROUP BY bc.category_level_1
ORDER BY product_count DESC
LIMIT 10;
EOF

echo -e "${GREEN}==================================================${NC}"
echo -e "${GREEN}Migration v0.6 completed successfully!${NC}"
echo -e "${GREEN}==================================================${NC}"

# Unset password for security
unset PGPASSWORD

