Quick Start:
- Start the PostgreSQL server:
```docker-compose up -d```
- View logs:
```docker-compose logs -f```
- Connect to database:
```docker exec -it postgres_server psql -U postgres -d mydb```
- Stop the server:
```docker-compose down```
- Stop and remove data (⚠️ deletes everything):
```docker-compose down -v```


Connection Details:
Host: localhost
Port: 5433 (changed from 5432)
Database: mydb
Username: postgres
Password: changeme123 (or whatever you set in .env)

📝 Connection Examples:
# Using psqlpsql -h localhost -p 5433 -U postgres -d mydb# Using docker execdocker exec -it postgres_server psql -U postgres -d mydb# Connection stringpostgresql://postgres:changeme123@localhost:5433/mydb


The container still runs PostgreSQL on port 5432 internally, but it's mapped to 5433 on your host machine. This is useful if you already have another PostgreSQL instance running on the default 5432 port!