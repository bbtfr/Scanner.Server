require 'test_helper'

class Api::CitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cities = cities(:one)
  end

  test "should get index" do
    get api_cities_url
    assert_response :success
  end
end
