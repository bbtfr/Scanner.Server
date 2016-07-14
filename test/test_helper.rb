ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'mocha/mini_test'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def json_response
    ActiveSupport::JSON.decode response.body
  end

  def read_fixture_file filename
    File.read(Rails.root.join('test', 'fixtures', 'files', filename))
  end

  def read_fixture_json name
    JSON.parse read_fixture_file "#{name}.json"
  end
end
