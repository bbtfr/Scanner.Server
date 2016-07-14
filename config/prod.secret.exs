use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or you later on).
config :scanner, Scanner.Endpoint,
  secret_key_base: "K0MdzDyDU2JXTNjkpmOLe5t65I9Rw9lH37pjctGQ6VyKWuJpk+SjJv2uxNDHblWT"

# Configure your database
config :scanner, Scanner.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "zhongheng",
  database: "scanner_prod",
  pool_size: 20
