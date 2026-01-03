#!/bin/bash

# ============================================
# Migration v0.4: Map Gumtree Categories
# ============================================
# This script maps gumtree_products categories to brand_category_id

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
echo -e "${YELLOW}Migration v0.4: Mapping Gumtree Categories${NC}"
echo -e "${YELLOW}==================================================${NC}"

echo -e "${GREEN}Step 1: Mapping categories to brand_category_id...${NC}"

psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" << 'EOF'
-- Update TV Audio & Video categories
UPDATE products.gumtree_products
SET brand_category_id = (
    SELECT id FROM products.brand_categories 
    WHERE category_level_1 = 'TV Audio & Video' 
    LIMIT 1
)
WHERE category IN (
    'dstv-services', 'satellite-tv-decoders', 'cd-players', 'broken-tvs-spares',
    'other-gaming-consoles', 'amplifiers-receivers', 'tvs-displays-dvd-s',
    'tube-tvs', 'mediplayas-streaming', 'psp-accessories', 'playstation-consoles',
    'other-cameras-video-cameras', 'mp3-players-and-ipods', 'playstation-accessories',
    'digital-camera', 'tv-accessories', 'other-home-audio', 'nintendo-ds-games',
    'headphones', '3d-tvs', 'xbox-games', 'consoles', 'wii-wiiu-games',
    'audio-receivers', 'camerlenses', 'cd-dvd', 'bluray-dvd-players',
    'nintendo-ds-accessories', 'car-audio-sound-systems', 'vintage-cameras',
    'cameraccessories', 'other-audio-music-equipment', 'nintendo-ds-consoles',
    'xbox-accessories', 'plasmtvs', 'action-cameras', 'hifi-systems', 'lcd-tvs',
    'hisense', 'speakers', 'video-cameras', 'smart-tvs', 'turntables',
    'audio-mixers', 'slr-cameras', 'led-tvs', 'microphones'
);

-- Update Computers & Peripherals categories
UPDATE products.gumtree_products
SET brand_category_id = (
    SELECT id FROM products.brand_categories 
    WHERE category_level_1 = 'Computers & Peripherals' 
    LIMIT 1
)
WHERE category IN (
    'lenovo-computers', 'toshiblaptops', 'corsair-computers', 'other-laptops',
    'computer-cables', 'sony-laptops', 'macbook-pro', 'monitors', 'asus-computers',
    'computer-graphic-cards', 'printer-accessories', 'microsoft-office', 'lenovo',
    'microsoft', 'other-macs', 'other-software', 'memory-hard-drives',
    'other-computer-accessories', 'gaming-pcs', 'computer-speakers',
    'other-computer-components', 'laptop-bags-cases', 'ink-cartridges',
    'memory-cards', 'projectors', 'mecer-computers', 'acer-laptops',
    'windows-operating-systems', 'computer-sound-cards', 'other-desktop-pcs',
    'lenovo-laptops', 'dell-laptops', 'samsung-laptops', 'computer-gaming-accessories',
    'keyboards-mice', 'routers', 'hp-+-compaq-laptops', 'laptop-batteries',
    'microsoft-laptops', 'modems-routers', 'asus-laptops', 'scanners',
    'imac', 'dell-desktop-pcs', 'computer-storage-devices', 'acer-desktop-pcs',
    'printers', 'vinyl-cutters-3d-printers', 'motherboards', 'samsung-computers',
    'hp-computers', 'adobe-software'
);

-- Update Cellphones & Tablets categories
UPDATE products.gumtree_products
SET brand_category_id = (
    SELECT id FROM products.brand_categories 
    WHERE category_level_1 = 'Cellphones & Tablets' 
    LIMIT 1
)
WHERE category IN (
    'tablets', 'other-cell-phones', 'kindles', 'screen-protectors', 'zte',
    'tablet-accessories', 'htc', 'sony-ericsson', 'cell-phone-cables',
    'cell-phones-accessories', 'other-cellphone-accessories', 'wearable-technology',
    'huawei', 'lg', 'ipads', 'samsung', 'blackberry', 'nokia', 'iphone',
    'motorola', 'apple-accessories', 'in+car-hands+free-kits', 'boosters',
    'xiaomi', 'mobile-accessories', 'batteries-chargers', 'earphones-headsets',
    'phone-cases-covers', 'carriers'
);

-- Set all remaining unmapped categories to NULL (for "Other")
-- You can create a specific "Other" category in brand_categories if needed

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
FROM products.gumtree_products gp
LEFT JOIN products.brand_categories bc ON gp.brand_category_id = bc.id
GROUP BY bc.category_level_1
ORDER BY product_count DESC
LIMIT 10;
EOF

echo -e "${GREEN}==================================================${NC}"
echo -e "${GREEN}Migration v0.4 completed successfully!${NC}"
echo -e "${GREEN}==================================================${NC}"

# Unset password for security
unset PGPASSWORD

