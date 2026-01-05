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

-- Update Other categories
UPDATE products.gumtree_products
SET brand_category_id = (
    SELECT id FROM products.brand_categories 
    WHERE category_level_1 = 'Other' 
    LIMIT 1
)
WHERE category IN (
    'clerical-administrative-cvs', 'beds-headboards', 'drones-gadgets', 'yachts-sailboats',
    'house-rentals-flat-rentals-offered', 'manufacturing-jobs', 'car-wheels', 'call-centre-jobs',
    'vintage-antique-jewellery', 'braais-potjie-pots', 'men-s-t+shirts', 'handyman-jobs',
    'car-rims', 'sports-fitness-gear', 'fashion-accessories-+-others', 'government-ngo-jobs',
    'kids-bicycles', 'carpets-rugs-mats', 'generators-solar-power', 'boats-jet-skis',
    'hats', 'stoves-ovens', 'auto-electrical-parts', 'google', 'bathroom-fixtures-and-supplies',
    'security-cvs', 'arts-entertainment-jobs', 'plants-seedlings', 'industrial-properties-for-sale',
    'lighting-accessories', 'flemarket-jumble-sale', 'tutors-education-services', 'security-gates-fencing',
    'wendy-houses', 'sunglasses', 'farm-vehicles-equipment', 'manufacturing', 'motorcycles-scooters',
    'other-watercraft', 'automotive-services', 'hand-saws', 'other-antique-collectables',
    'graphic-design-jobs', 'activities-hobbies', 'sheep-goats', 'removals-storage',
    'appliance-parts', 'hammers', 'other-events', 'musicians-artists', 'classic-vintage-cars',
    'home-office-desks-chairs', 'model-cars-trains', 'general-worker-cvs', 'accessories-styling',
    'sports-sports-partners', 'motorcycle-tyres-rims', 'clocks', 'car-interior-accessories',
    'chandeliers-hanging-lights', 'healthcare-nursing-jobs', 'office-jobs', 'other-sports-leisure-items',
    'other-community-posts', 'land-plots-for-sale', 'short+term-properties', 'other-retail-jobs',
    'heavy-truck-buses-spares', 'pest-control', 'travel-agents-tours', 'musical-instruments',
    'cars-bakkies', 'other-items-for-babies-kids', 'restaurant-bar-cvs', 'construction-skilled-trade-cvs',
    'air-conditioners', 'fireplaces', 'men-s-suits', 'other-hand-tools', 'tv-stands-wall-units',
    'wall-lights', 'industrial-machinery', 'car-body-trim', 'men-s-formal-shoes', 'microwaves',
    'dj-entertainment-services', 'men-s-watches', 'dining-chairs-benches', 'appliance-repairs',
    'flat-share-house-share', 'kettles-toasters', 'party-catering', 'other-power-tools',
    'dogs-puppies', 'car-seats', 'store-manager-jobs', 'kayaks-paddle-boats', 'electronics-it-services',
    'housekeeping-cleaning-jobs', 'other-toys', 'rare-coins-stamps', 'sales-representatives-jobs',
    'patio-outdoor-furniture', 'sanders', 'car-shocks-suspension-steering-parts', 'clerical-datcapturing-jobs',
    'aftermarket-service-parts', 'hr-jobs', 'health-beauty-services', 'grinders', 'tourism-jobs',
    'machinery-spares', 'caravans-trailers', 'gardening-supplies', 'tutors-teaching-jobs',
    'software-web-developer-jobs', 'jigsaws', 'events-gigs-nightlife', 'essential-home-maintenance',
    'books-games', 'other-lighting', 'other-electronics', 'ornaments-figurines', 'games',
    'cleaning-services', 'other', 'baby-monitors', 'fmcg-jobs', 'juicers-blenders-food-processors',
    'web-designers', 'car-lights', 'logistics-transportation-cvs', 'classic-vintage-cars-spares',
    'retail-space-for-rent', 'road-bikes', 'women-s-boots', 'chauffeur-airport-transfer',
    'security-jobs', 'women-s-jewellery', 'car-exterior-accessories', 'sewing-machines',
    'building-trades', 'au-pair-babysitting-jobs', 'poultry', 'childcare-babysitting-cvs',
    'binoculars-telescopes', 'teaching-cvs', 'internship-jobs', 'pliers', 'courses-training',
    'cats-kittens', 'customer-service-jobs', 'chairs', 'chisels', 'couches', 'chest-of-drawers',
    'antique-clocks', 'sales-jobs', 'it-technician-jobs', 'washing-machines', 'other-home-improvement',
    'antique-furniture', 'other-replacement-car-part', 'child-care', 'logistics-jobs',
    'car-brake-parts', 'water-purifiers-geysers', 'sports-fitness-training', 'raw-materials',
    'women-s-sneakers', 'irons-steamers', 'holiday-homes', 'agriculture-farm-jobs', 'charity-donations',
    'car-engines-engine-parts', 'estate-agent-jobs', 'landscaping-gardening-services', 'other-home-decor-items',
    'store-catering-equipment', 'educational-toys', 'antique-lamps-lights', 'motorcycle-helmets-clothes-boots',
    'mountain-bikes', 'mechanic-jobs', 'photography-video-services', 'other-sales-jobs',
    'healthcare-nursing-cvs', 'accounting-finance-cvs', 'men-s-jewellery', 'coffee-side-tables',
    'women-s-clothing-+-other', 'tax-financial-services', 'crystal-glassware', 'heavy-trucks-buses',
    'camping-gear', 'swimming-pools-accessories', 'other-skill-trade-jobs', 'landline-telephones',
    'office-equipment-furniture', 'carriers', 'silver-metalware', 'machinery-vehicles',
    'legal-secretary', 'kitchen-cabinets-modulars', 'braai-accessories', 'other-admin-jobs',
    'houses-flats-for-sale', 'other-properties', 'baby-feeding-products', 'women-s-watches',
    'coffee-makers', 'office-space-for-rent', 'furniture-sets', 'fish', 'wedding-venues-wedding-services',
    'receptionist-jobs', 'computing-it-cvs', 'pet-services', 'other-furniture', 'nail-technician-jobs',
    'engineering-architecture-jobs', 'other-essential-services', 'general-worker-jobs', 'birds',
    'pet-accessories', 'other-home-appliances', 'advertising-marketing-cvs', 'catering-services',
    'weekend-part+time-jobs-cvs', 'hotel-jobs', 'healer-services', 'picture-frames',
    'bags-handbags-purses', 'paintings-decorations', 'motorcycle-accessories-styling', 'women-s-tees',
    'wardrobes-cupboards', 'houses-flats-for-rent', 'industrial-properties-for-rent', 'refrigerators-freezers',
    'gardening-landscaping-cvs', 'dishwashers', 'antiques-collectables', 'display-cabinets',
    'gardening-tools-lawn-mowers', 'garden-decorations-plants', 'solar-powered-electronics', 'cashier-jobs',
    'vacuum-cleaners', 'porcelain-ceramics', 'housekeeping-cleaning-cvs', 'car-tyres', 'other-pets',
    'arts-entertainment-cvs', 'shop-assistant-jobs', 'businesses-for-sale', 'power-tool-parts-accessories',
    'recruitment-services', 'accounting-finance-jobs', 'tiles-flooring', 'drills'
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

