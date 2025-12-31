# Database Initialization Scripts

This directory contains SQL scripts that are automatically executed when the PostgreSQL container is first created.

## 📁 Directory Structure

```
init-scripts/
├── 01-init.sql                    # Basic app schema (example)
├── Schema/                        # Table definitions (DROP & CREATE)
│   ├── 01-create-schema.sql
│   ├── 02-cash-converters-table.sql
│   ├── 03-gumtree-products-table.sql
│   ├── 04-gumtree-category-table.sql
│   ├── 05-global-categories-table.sql
│   ├── 06-global-products-table.sql
│   └── 07-product-categories-junction-table.sql
├── Indexes/                       # Index definitions (DROP & CREATE)
│   ├── 01-cash-converters-indexes.sql
│   ├── 02-gumtree-indexes.sql
│   ├── 03-gumtree-category-indexes.sql
│   ├── 04-global-products-indexes.sql
│   ├── 05-global-categories-indexes.sql
│   └── 06-product-categories-indexes.sql
├── Functions/                     # Function definitions (DROP & CREATE)
│   ├── 01-update-timestamp-function.sql
│   ├── 02-sync-cash-converters-function.sql
│   ├── 03-sync-gumtree-function.sql
│   └── 04-views.sql
├── Triggers/                      # Trigger definitions (DROP & CREATE)
│   ├── 01-global-products-trigger.sql
│   └── 02-global-categories-trigger.sql
└── Permissions/                   # Permission grants
    └── 01-grant-permissions.sql
```

## 🔄 Execution Order

Scripts are executed in **alphabetical order** by PostgreSQL. The naming convention ensures proper execution:

1. **Schema Creation** - `Schema/*.sql`
2. **Indexes** - `Indexes/*.sql`
3. **Functions** - `Functions/*.sql` (including views)
4. **Triggers** - `Triggers/*.sql`
5. **Permissions** - `Permissions/*.sql`

## ⚠️ Important Notes

### First Run Only
- Init scripts **only run when the database volume is empty** (first container creation)
- They do **NOT run on container restarts**

### To Re-run Init Scripts
```bash
# Stop and remove the container AND volume
docker-compose down -v

# Start fresh (this will run all init scripts)
docker-compose up -d
```

### DROP Statements
All files include `DROP ... IF EXISTS` statements to make them idempotent. This means:
- Safe to run multiple times
- Will recreate objects from scratch
- Useful for development/testing

## 📊 Database Schema Overview

### Source Tables (Raw Data)
- `products.cash_converters_products` - Cash Converters product data
- `products.gumtree_products` - Gumtree product listings
- `products.gumtree_products_category` - Gumtree category mappings

### Global Tables (Normalized)
- `products.global_products` - Unified products from all sources
- `products.global_categories` - Normalized category structure
- `products.product_categories` - Junction table (many-to-many)

### Relationships
```
global_products (1) ←→ (M) product_categories (M) ←→ (1) global_categories
```

## 🛠️ Useful Functions

After data is loaded, sync to global tables:

```sql
-- Sync Cash Converters products
SELECT products.sync_cash_converters_to_global();

-- Sync Gumtree products
SELECT products.sync_gumtree_to_global();
```

## 📈 Helper Views

Three views are automatically created:

```sql
-- View products with their categories
SELECT * FROM products.products_with_categories;

-- View statistics by source
SELECT * FROM products.product_stats_by_source;

-- View popular categories
SELECT * FROM products.popular_categories;
```

## 🔧 Modifying Scripts

When making changes:

1. **Edit the appropriate file** in its category folder
2. **Remove the volume** to trigger re-initialization:
   ```bash
   docker-compose down -v
   docker-compose up -d
   ```

3. **Or manually run scripts** in a running database:
   ```bash
   docker exec -i postgres_server psql -U postgres -d mydb < Schema/06-global-products-table.sql
   ```

## 📝 Adding New Scripts

To add new scripts:

1. **Name with numeric prefix** to control execution order
2. **Include DROP statements** for idempotency
3. **Add to appropriate folder** (Schema, Indexes, Functions, Triggers, or Permissions)
4. **Test by recreating the volume**

Example:
```bash
# Create new table script
echo "DROP TABLE IF EXISTS products.my_new_table CASCADE;
CREATE TABLE products.my_new_table (...);" > Schema/08-my-new-table.sql

# Recreate database
docker-compose down -v && docker-compose up -d
```

## 🔍 Troubleshooting

### Check if scripts ran
```bash
# View container logs
docker-compose logs postgres

# Connect and check tables
docker exec -it postgres_server psql -U postgres -d mydb -c "\dt products.*"
```

### Scripts didn't run
- Ensure volume was empty (use `docker-compose down -v`)
- Check for syntax errors in logs
- Verify file naming (must end in `.sql`)

### Permission errors
- Check `Permissions/01-grant-permissions.sql`
- Ensure script execution order is correct


