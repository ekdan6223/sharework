require 'test_helper'

class AlbafavControllerTest < ActionDispatch::IntegrationTest
  test "should get albafavcreate" do
    get albafav_albafavcreate_url
    assert_response :success
  end

  test "should get albafavdestroy" do
    get albafav_albafavdestroy_url
    assert_response :success
  end

end
