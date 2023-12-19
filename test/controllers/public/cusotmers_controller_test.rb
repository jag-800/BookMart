require "test_helper"

class Public::CusotmersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_cusotmers_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_cusotmers_edit_url
    assert_response :success
  end

  test "should get confirm" do
    get public_cusotmers_confirm_url
    assert_response :success
  end
end
