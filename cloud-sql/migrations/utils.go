package main

import migrate "github.com/rubenv/sql-migrate"

type DbMigrationTarget struct {
	DevConnString  string
	ProdConnString string
	Fms            *migrate.FileMigrationSource
}
