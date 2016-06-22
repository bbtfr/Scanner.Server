#\ -o 0.0.0.0
require_relative 'config/initializer'

run Rack::URLMap.new({
  "/identity" => Scanner::Routes::Identity,
  "/news"     => Scanner::Routes::News
})
