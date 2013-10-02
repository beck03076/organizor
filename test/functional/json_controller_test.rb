require 'test_helper'

class JsonControllerTest < ActionController::TestCase
  test "should get cities" do
    get :cities
    assert_response :success
  end

  test "should get institutions" do
    get :institutions
    assert_response :success
  end

end
