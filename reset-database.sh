#!/bin/bash

SOURCE_DB_URI=$1
DESTINATION_DB_URI=$2

function usage() {
    echo "Usage: $0 <source_db_uri> <destination_db_uri>"
    echo "Example: $0 mongodb://remote-database:27017/mydb mongodb://localhost:27017"
}

if [ -z "$SOURCE_DB_URI" ]
then
    echo "Error: Source DB URI is required"
    usage
    exit 1
fi
if [ -z "$DESTINATION_DB_URI" ]
then
    echo "Error: Destination DB URI is required"
    usage
    exit 1
fi

echo "This script will dump the database and restore your destination. Are you sure you want to continue? (y/n)"
read -n 1 -r
# If response is not 'y', exit
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo ""
    echo "Exiting..."
    exit 1
fi

echo ""
echo "Resetting database..."

DUMP_FOLDER="dump_"$(date +"%Y-%m-%d_%H-%M-%S")
# DUMP_FOLDER="dump_"
rm -rf $DUMP_FOLDER

mkdir -p $DUMP_FOLDER

echo "Dumping database..."
mongodump --uri="$SOURCE_DB_URI" --gzip --out=$DUMP_FOLDER

echo "Waiting for 15 seconds..."
sleep 15
echo "Dumping database...done"

echo "Restoring database..."
mongorestore --uri="$DESTINATION_DB_URI" --gzip $DUMP_FOLDER
echo "Restoring database...done"

echo "Remove dump folder? ($DUMP_FOLDER) (y/n)"
read -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    rm -rf $DUMP_FOLDER
fi