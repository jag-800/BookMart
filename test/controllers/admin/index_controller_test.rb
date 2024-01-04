require "test_helper"

class Admin::IndexControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_index_show_url
    assert_response :success
  end

  test "should get update" do
    get admin_index_update_url
    assert_response :success
  end
end
