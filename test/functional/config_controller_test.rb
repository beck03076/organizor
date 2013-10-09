require 'test_helper'

class ConfigControllerTest < ActionController::TestCase
  test "should get user_config" do
    get :user_config
    assert_response :success
  end

end
