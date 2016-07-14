require 'test_helper'

class Api::IdentitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_identity = api_identities(:one)
  end

  test "should get index" do
    get api_identities_url
    assert_response :success
  end

  test "should get new" do
    get new_api_identity_url
    assert_response :success
  end

  test "should create api_identity" do
    assert_difference('Api::Identity.count') do
      post api_identities_url, params: { api_identity: {  } }
    end

    assert_redirected_to api_identity_url(Api::Identity.last)
  end

  test "should show api_identity" do
    get api_identity_url(@api_identity)
    assert_response :success
  end

  test "should get edit" do
    get edit_api_identity_url(@api_identity)
    assert_response :success
  end

  test "should update api_identity" do
    patch api_identity_url(@api_identity), params: { api_identity: {  } }
    assert_redirected_to api_identity_url(@api_identity)
  end

  test "should destroy api_identity" do
    assert_difference('Api::Identity.count', -1) do
      delete api_identity_url(@api_identity)
    end

    assert_redirected_to api_identities_url
  end
end
