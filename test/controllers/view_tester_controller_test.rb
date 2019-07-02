require 'test_helper'

class ViewTesterControllerTest < ActionDispatch::IntegrationTest
  test "should get test" do
    get view_tester_test_url
    assert_response :success
  end

end
