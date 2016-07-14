require 'test_helper'

class Api::IdentitiesControllerTest < ActionDispatch::IntegrationTest
  test "should not get abilities without unique_id" do
    get abilities_api_identity_url
    assert_response :success
    assert_equal "failed", json_response["status"]
  end

  test "should get abilities with unique_id" do
    get abilities_api_identity_url(unique_id: 1)
    assert_response :success
    assert_equal "success", json_response["status"]
  end

  test "should update use count" do
    post use_count_api_identity_url(unique_id: 1, feature: "scan_id_card")
    assert_response :success
    assert_equal "failed", json_response["status"]

    Ability.create(unique_id: 1, use_counts: { "scan_id_card" => 1 })
    post use_count_api_identity_url(unique_id: 1, feature: "scan_id_card")
    assert_response :success
    assert_equal "success", json_response["status"]
  end

  test "should get identify infomation" do
    Ability.create(unique_id: 1, use_counts: { "liveness_test" => 10 })

    SensetimeAPI.stubs(:selfie_idnumber_verification).raises(RuntimeError)
    post identify_api_identity_url(unique_id: 1, image: "MOCK", name: "MOCK", id: "MOCK")
    assert_response :success
    assert_equal "failed", json_response["status"]

    SensetimeAPI.stubs(:selfie_idnumber_verification).returns(read_fixture_json('identify_failed'))
    post identify_api_identity_url(unique_id: 1, image: "MOCK", name: "MOCK", id: "MOCK")
    assert_response :success
    assert_equal "failed", json_response["status"]

    SensetimeAPI.stubs(:selfie_idnumber_verification).returns(read_fixture_json('identify_success'))
    post identify_api_identity_url(unique_id: 1, image: "MOCK", name: "MOCK", id: "MOCK")
    assert_response :success
    assert_equal "success", json_response["status"]
  end
end
