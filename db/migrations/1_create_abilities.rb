# => sequel -m . sqlite://../development.db
# When you need to modify some table, create a new migration file,
# NEVER modify the existed files

# EDIT: Syntax is:
# $ sequel -m [/path/to/db_migrations/directory] sqlite://[path/to/development.db]
# If all else fails, do (from project root directory):
# $ sqlite3 db/development.db
# sqlite> (DROP ALL TABLES)
# $ sequel -m db/migrations sqlite://db/development.db
# NOTE: You need to reseed the tables after this.

Sequel.migration do
  change do
    create_table :abilities do
      primary_key :id
      String :unique_id
      Text :use_counts
    end
  end
end
