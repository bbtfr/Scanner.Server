use Mix.Config

# Configures your deployment
config :dex, DeployManager,
  server: "zhongheng",
  username: "ubuntu",
  deploy_to: "/var/www/scanner",
  link_files: ["config/prod.secret.exs", ".env"]
