require 'test_helper'

class BlockControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get block_main_url
    assert_response :success
  end

end
