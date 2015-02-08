#!/bin/bash

echo "Dropping tables"
psql -d beerpong < sql/drop_tables.sql
echo "Done."

echo "Creating tables"
psql -d beerpong < sql/create_tables.sql
echo "Done"
