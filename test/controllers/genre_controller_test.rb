require 'test_helper'

class GenreControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get genre_create_url
    assert_response :success
  end

end
