use Mix.Config

# Configures your deployment
config :dex, DeployManager,
  server: "zhongheng",
  username: "ubuntu",
  deploy_to: "/var/www/scanner",
  link_files: ["config/prod.secret.exs", ".env"]

config :scanner, :sensetime,
  api_id: "bea403ab58e84b3e809d959ffb527a99",
  api_secret: "90afff8b1c254c678cdd63970efb7287"
