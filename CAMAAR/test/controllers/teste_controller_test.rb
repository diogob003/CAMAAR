require "test_helper"

class TesteControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get teste_index_url
    assert_response :success
  end
end
