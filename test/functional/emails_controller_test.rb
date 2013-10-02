require 'test_helper'

class EmailsControllerTest < ActionController::TestCase
  test "should get save_send" do
    get :save_send
    assert_response :success
  end

end
