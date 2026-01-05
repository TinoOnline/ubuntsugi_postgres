#!/bin/bash

# ============================================
# Migration v0.5: Map Cash Converters Categories
# ============================================
# This script maps cash_converters_products categories to brand_category_id

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
echo -e "${YELLOW}Migration v0.5: Mapping Cash Converters Categories${NC}"
echo -e "${YELLOW}==================================================${NC}"

echo -e "${GREEN}Step 1: Mapping categories to brand_category_id...${NC}"

psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" << 'EOF'
-- Update TV Audio & Video categories
UPDATE products.cash_converters_products
SET brand_category_id = (
    SELECT id FROM products.brand_categories 
    WHERE category_level_1 = 'TV Audio & Video' 
    LIMIT 1
)
WHERE category IN (
    'Amplifiers', 'Portable Speakers', 'Remotes & Accessories', 'Portable Audio',
    'Set-top Boxes & Antennas', 'Console Game Discs', 'Car Audio Accessories',
    'Amps & Stage Equipment', 'Headphones', 'Gaming Consoles', 'Mirrorless Cameras',
    'Game Controllers', 'Tripods & Monopods', 'Memory Cards & Rumble Packs',
    'Speakers', 'Console Accessories', 'Movies & TV Shows', 'Camera Bags & Cases',
    'DJ Electronic Equipment', 'Stands & Accessories', 'Lenses', 'CDs & DVDs',
    'Car Stereo', 'Televisions', 'Car Media', 'Gaming', 'Antique Cameras',
    'TV, Audio & Video', 'Stereo Systems', 'Media Players', 'Compact Cameras',
    'Digital Cameras', 'Recording Devices', 'Dashcams', 'Video Cameras',
    'DJ Lighting', 'Photography', 'Waterproof & Action Cameras'
);

-- Update Computers & Peripherals categories
UPDATE products.cash_converters_products
SET brand_category_id = (
    SELECT id FROM products.brand_categories 
    WHERE category_level_1 = 'Computers & Peripherals' 
    LIMIT 1
)
WHERE category IN (
    'Gaming Keyboards & Mice', 'Memory Cards', 'Network Tools', 'Routers',
    'Cables & Adapters', 'Desktop Computers', 'Docking Stations', 'Computers & Peripherals',
    'Computer Components', 'Power Supplies', 'Laptop Computer', 'Keyboards, Mice & Webcam',
    'Computer Monitors', 'PC Games', 'Printers & Scanners', 'Software',
    'Computer Speakers', 'Projectors', 'Drives & Storage', 'Peripherals',
    'Network, Routers & Adapters', 'Computer Accessory', 'Mobile Wi-Fi Routers'
);

-- Update Cellphones & Tablets categories
UPDATE products.cash_converters_products
SET brand_category_id = (
    SELECT id FROM products.brand_categories 
    WHERE category_level_1 = 'Cellphones & Tablets' 
    LIMIT 1
)
WHERE category IN (
    'Sim Cards', 'Cellphones & Tablets', 'Other Tablets', 'Handsfree & CB Radio',
    'Batteries', 'Cell Accessories', 'iPads', 'Handset', 'Headsets',
    'Smart Watches', 'Activity Trackers'
);

-- Update Other categories
UPDATE products.cash_converters_products
SET brand_category_id = (
    SELECT id FROM products.brand_categories 
    WHERE category_level_1 = 'Other' 
    LIMIT 1
)
WHERE category IN (
    'Print Material', 'Running', 'Irrigation', 'Outdoors & Sports', 'Other Toys',
    'Saws', 'Drill Bits', 'Mixers', 'Farming', 'Combat Sport', 'Sanders',
    'Books', 'Flashlights & Outdoor Lamps', 'Coaching', 'Metal Detectors',
    'Health Monitors', 'Soldering Irons', 'Compressed Air Tools', 'Binoculars & Optics',
    'Boats & Parts', 'Jewellery Boxes & Organisers', 'Tool Boxes & Bags', 'Gas',
    'Office Equipment', 'Hair Care', 'Building Blocks', 'Multimeters & Electrical Testers',
    'Necklaces', 'Jacks', 'Security Systems', 'Braais', 'Scrap Precious Metal',
    'Generators', 'Medical', 'Office Supplies', 'Shavers & Clippers', 'Chains',
    'Golf', 'Musical Instruments & Equipment', 'Surveillance Equipment', 'Antiques',
    'Ovens & Stoves', 'Watch Accessories', 'Filter', 'Coffee Makers', 'Appliance',
    'Clocks', 'Plumbing Tools', 'Pool, Spa, Sauna', 'Doors, Handles & Hinges',
    'Educational & Board Games', 'Jewellery, Watches & Fashion', 'Lamps & Lighting',
    'Vehicle Parts & Accessories', 'Toy Remote Controlled', 'Massagers', 'Irons & Clothes Steamers',
    'Outdoor Wear & Clothing', 'Motocross', 'Handbags & Accessories', 'Remote Controlled',
    'Guitars & String Instruments', 'Garden Equipment', 'Plates, Cutlery & Kitchenware',
    'Bicycle Accessories & Parts', 'Baby Care & Nursery', 'Other Rings', 'Cordless Batteries & Chargers',
    'Air Conditioners', 'Suitcases', 'Sunglasses', 'Cleaning equipment', 'Home & Garden',
    'Safety Equipment', 'Glue and Sealant', 'Business & Industrial', 'Blades',
    'Hobbies, Collectables & Antiques', 'Indoor Fans', 'Screwdrivers', 'Impact Drivers',
    'Power Saws', 'Lighting', 'Ties', 'Fitness', 'Air Compressors', 'Levels',
    'Dishwashers', 'Paintings & Drawings', 'Motor Bikes', 'Grinders', 'Electric Knives',
    'Fry Pans', 'Other Hand Tools', 'Wrenches', 'Backpacks & Bags', 'Indoor Furniture',
    'Drones', 'Analogue Watches', 'Spirit Levels', 'Wind Instruments', 'Fishing',
    'Drills', 'Catering Equipment', 'Socket Sets', 'Clothes Dryers & Washing Machines',
    'Keyboards & Pianos', 'Tools, Hardware & Automotive', 'Digital Watches', 'Jackhammers',
    'Humidifiers', 'Vehicle Alarms & Security', 'Electrical', 'Bathroom', 'Snips',
    'Steam Cookers', 'Uncategorized', 'Fridges & Freezers', 'Ornaments & Sculptures',
    'Musical Accessories', 'Welders', 'Stationery', 'Microwaves', 'Spray Guns',
    'Cleaning & Laundry', 'Planers', 'Memorabilia', 'Toasters', 'Bicycles',
    'Business Equipment', 'Mugs & Barware', 'Sewing', 'Writing Instruments', 'Rice Cookers',
    'Rock Climbing', 'Body Care', 'Knives & Tools', 'Ice Machines', 'Telephone',
    'Solar', 'Clothing', 'Heaters', 'Pliers'
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
FROM products.cash_converters_products cc
LEFT JOIN products.brand_categories bc ON cc.brand_category_id = bc.id
GROUP BY bc.category_level_1
ORDER BY product_count DESC
LIMIT 10;
EOF

echo -e "${GREEN}==================================================${NC}"
echo -e "${GREEN}Migration v0.5 completed successfully!${NC}"
echo -e "${GREEN}==================================================${NC}"

# Unset password for security
unset PGPASSWORD

