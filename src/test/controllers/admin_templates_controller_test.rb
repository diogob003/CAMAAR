require "test_helper"

class AdminTemplatesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_templates_index_url
    assert_response :success
  end

  test "should get list" do
    get admin_templates_list_url
    assert_response :success
  end
end
