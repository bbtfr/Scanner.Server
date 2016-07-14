require 'test_helper'

class Api::NewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @news = news(:one)
  end

  test "should get index" do
    get api_news_index_url
    assert_response :success
  end
end
