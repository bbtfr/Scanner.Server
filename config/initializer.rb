RACK_ENV = (ENV['RACK_ENV'] || "development").to_sym
DATABASE_URL = ENV['DATABASE_URL'] || "sqlite://db/#{RACK_ENV}.sqlite3"
puts "Run Sinatra in #{RACK_ENV} mode, connect to database: #{DATABASE_URL}"

require 'dotenv'
Dotenv.load

# Load models
require 'sequel'
require 'logger'
DB = Sequel.connect(DATABASE_URL)
Dir['app/models/*.rb'].each do |file|
  load file
end

require_relative '../lib/sensetime_api'
require_relative '../app/routes'
