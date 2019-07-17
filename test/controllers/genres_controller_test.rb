require 'test_helper'

class GenresControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get genres_create_url
    assert_response :success
  end

end
