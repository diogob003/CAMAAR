require "test_helper"

class AuthenticatedControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get authenticated_index_url
    assert_response :success
  end
end
