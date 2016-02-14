#!/bin/bash

# Start postgres
service postgresql start

# Update passwd
echo -e "postgres1234\npostgres1234" | passwd postgres 
su - postgres -c "psql -U postgres -d postgres -c \"alter user postgres with password 'postgres1234';\""

# Create database
su - postgres -c "createdb pcm"

# Set database up or down based on LOCAL_POSTGRES environmental variable
if [ $LOCAL_POSTGRES == "false" ]; then
    service postgresql stop
fi

