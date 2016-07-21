require 'test_helper'

class Api::IdentitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @image = fixture_uploaded_file('rails.jpg', 'image/jpeg')
  end

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

  test "should not update use count if limit exceed" do
    return unless Ability::CHECK_ABILITY
    post use_count_api_identity_url, params: { unique_id: 1, feature: "scan_id_card" }
    assert_response :success
    assert_equal "failed", json_response["status"]
  end

  test "should update use count" do
    Ability.create(unique_id: 1, use_counts: { "scan_id_card" => 1 })
    post use_count_api_identity_url, params: { unique_id: 1, feature: "scan_id_card" }
    assert_response :success
    assert_equal "success", json_response["status"]
  end

  test "should not identify if limit exceed" do
    return unless Ability::CHECK_ABILITY
    SensetimeAPI.stubs(:selfie_idnumber_verification).returns(read_fixture_json('identify_success'))
    post identify_api_identity_url, params: { unique_id: 1, image: @image, name: "MOCK", id: "MOCK" }
    assert_response :success
    assert_equal "failed", json_response["status"]
  end

  test "should not identify if raise error" do
    Ability.create(unique_id: 1, use_counts: { "liveness_test" => 1 })
    SensetimeAPI.stubs(:selfie_idnumber_verification).raises(RuntimeError)
    post identify_api_identity_url, params: { unique_id: 1, image: @image, name: "MOCK", id: "MOCK" }
    assert_response :success
    assert_equal "failed", json_response["status"]
  end

  test "should not identify if validity failed" do
    Ability.create(unique_id: 1, use_counts: { "liveness_test" => 1 })
    SensetimeAPI.stubs(:selfie_idnumber_verification).returns(read_fixture_json('validity_failed'))
    post identify_api_identity_url, params: { unique_id: 1, image: @image, name: "MOCK", id: "MOCK" }
    assert_response :success
    assert_equal "failed", json_response["status"]
  end

  test "should not identify if identify failed" do
    Ability.create(unique_id: 1, use_counts: { "liveness_test" => 1 })
    SensetimeAPI.stubs(:selfie_idnumber_verification).returns(read_fixture_json('identify_failed'))
    post identify_api_identity_url, params: { unique_id: 1, image: @image, name: "MOCK", id: "MOCK" }
    assert_response :success
    assert_equal "failed", json_response["status"]
  end

  test "should identify if things go right" do
    Ability.create(unique_id: 1, use_counts: { "liveness_test" => 1 })
    SensetimeAPI.stubs(:selfie_idnumber_verification).returns(read_fixture_json('identify_success'))
    post identify_api_identity_url, params: { unique_id: 1, image: @image, name: "MOCK", id: "MOCK" }
    assert_response :success
    assert_equal "success", json_response["status"]
  end

  test "should identify if things go right 2nd time" do
    Ability.create(unique_id: 1, use_counts: { "liveness_test" => 1 })
    person = Person.create(name: "MOCK", id_number: "MOCK", image: images(:one))
    SensetimeAPI.stubs(:selfie_idnumber_verification).raises(RuntimeError)
    SensetimeAPI.stubs(:historical_selfie_verification).returns(read_fixture_json('identify_success_2'))
    post identify_api_identity_url, params: { unique_id: 1, image: @image, name: "MOCK", id: "MOCK" }
    assert_response :success
    assert_equal "success", json_response["status"]
  end
end
