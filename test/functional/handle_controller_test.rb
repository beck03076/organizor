require 'test_helper'

class HandleControllerTest < ActionController::TestCase
  test "should get error" do
    get :error
    assert_response :success
  end

  test "should get cancan" do
    get :cancan
    assert_response :success
  end

end
