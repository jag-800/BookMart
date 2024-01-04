require "test_helper"

class Admin::OrderDetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get admin_order_details_update_url
    assert_response :success
  end
end
