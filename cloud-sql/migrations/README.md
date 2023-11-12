# Database Migrations for the AzteBot
MySQL DB migrations for this project are done through `golang-migrate`. The `history/` folder contains Up and Down SQL scripts for the necessary migrations. They are prepended by the migration id `1`, `2`, etc..

# How to Run a Migration
1. Make sure you have the `github.com/golang-migrate/migrate/v4` Golang package in your GOROOT.
2. 
_Expected URL: `mysql://user:password@tcp(host:port)/dbname?query`_