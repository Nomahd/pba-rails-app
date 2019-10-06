require 'test_helper'

class TagControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get tag_controller_create_url
    assert_response :success
  end

end
