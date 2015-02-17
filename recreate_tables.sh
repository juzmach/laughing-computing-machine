#!/bin/bash

echo "Dropping tables"
psql -d beerpong < sql/drop_tables.sql
echo "Done."

echo "Creating tables"
psql -d beerpong < sql/create_tables.sql

echo "Granting access"
psql -d beerpong < sql/grant_access.sql
echo "Done"

echo "Adding test data"
psql -d beerpong < sql/add_test_data.sql
echo "Done"

