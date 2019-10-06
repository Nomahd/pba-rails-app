require 'test_helper'

class TagMetaControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get tag_meta_create_url
    assert_response :success
  end

end
