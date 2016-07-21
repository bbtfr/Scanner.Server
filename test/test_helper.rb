ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'mocha/mini_test'
require 'simplecov'
SimpleCov.start

Paperclip::Attachment.default_options[:path] = "#{Rails.root}/tmp/test_files/:class/:id_partition/:style.:extension"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def json_response
    ActiveSupport::JSON.decode response.body
  end

  def fixture_file_path filename
    File.join(self.class.fixture_path, 'files', filename)
  end

  def read_fixture_file filename
    File.read(fixture_file_path(filename))
  end

  def read_fixture_json name
    JSON.parse read_fixture_file "#{name}.json"
  end

  def fixture_uploaded_file(filename, mime_type = nil)
    Rack::Test::UploadedFile.new(fixture_file_path(filename), mime_type)
  end
end
