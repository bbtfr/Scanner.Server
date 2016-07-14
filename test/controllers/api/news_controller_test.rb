require 'test_helper'

class Api::NewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_news = api_news(:one)
  end

  test "should get index" do
    get api_news_index_url
    assert_response :success
  end

  test "should get new" do
    get new_api_news_url
    assert_response :success
  end

  test "should create api_news" do
    assert_difference('Api::News.count') do
      post api_news_index_url, params: { api_news: {  } }
    end

    assert_redirected_to api_news_url(Api::News.last)
  end

  test "should show api_news" do
    get api_news_url(@api_news)
    assert_response :success
  end

  test "should get edit" do
    get edit_api_news_url(@api_news)
    assert_response :success
  end

  test "should update api_news" do
    patch api_news_url(@api_news), params: { api_news: {  } }
    assert_redirected_to api_news_url(@api_news)
  end

  test "should destroy api_news" do
    assert_difference('Api::News.count', -1) do
      delete api_news_url(@api_news)
    end

    assert_redirected_to api_news_index_url
  end
end
