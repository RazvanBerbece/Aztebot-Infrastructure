package main

import migrate "github.com/rubenv/sql-migrate"

type DbMigrationTarget struct {
	ConnString string
	Fms        *migrate.FileMigrationSource
}
