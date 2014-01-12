require 'test_helper'

class ImportControllerTest < ActionController::TestCase
  test "should get contacts" do
    get :contacts
    assert_response :success
  end

  test "should get events" do
    get :events
    assert_response :success
  end

  test "should get tasks" do
    get :tasks
    assert_response :success
  end

end
