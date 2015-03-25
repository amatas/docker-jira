Allocate enough memory to the VM so that JIRA performs reasonably well:


    VM_RAM=3000 vagrant up


Log in:


    vagrant ssh

Create the image:


    make image


PostgreSQL in the VM should be reachable from containers. Create a JIRA database, account, and password. Make sure ```/var/lib/pgsql/9.3/data/postgresql.conf``` contains ```listen_addresses = '*'```

Test the image:

```
DB_SERVICE_ADDRESS=<your vagrant box's address> \
APP_DB_NAME=9d617b7 \
APP_DB_USERNAME=9d617b7 \
APP_DB_PASSWORD=9d617b7 \
APP_MEMORY_LIMIT=1000 \ 
make test
```

CAVEATS:

https://jira.atlassian.com/browse/JRA-41941

