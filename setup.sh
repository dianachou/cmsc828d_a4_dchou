#!/usr/bin/env bash

# Create movies table
echo ">>> Creating database..."
createdb -U postgres -h localhost a3database
echo ""
#
echo ">>> Creating user..."
createuser -U postgres -h localhost cmsc828d
echo ""

echo ">>> Creating tables and granting permissions..."
psql -U postgres -h localhost -d a3database -f sql/create_schemas.sql
echo ""

# Load each data file
echo ">>> Loading data files..."
psql -U postgres -d a3database -c "\copy a2.shootings FROM 'data/new_shootings.csv' DELIMITER ',' CSV HEADER;"
psql -U postgres -d a3database -c "\copy a3.shootings FROM 'data/new_shootings.csv' DELIMITER ',' CSV HEADER;"
echo ""

echo ">>> Creating optimizations to the server..."
psql -U postgres -h localhost -d a3database -f sql/create_optimize.sql
echo ""

echo "Setup done! Run the server by executing 'python3 server.py'"
echo ""
