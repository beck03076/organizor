require 'test_helper'

class TodoStatusesControllerTest < ActionController::TestCase
  setup do
    @todo_status = todo_statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:todo_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create todo_status" do
    assert_difference('TodoStatus.count') do
      post :create, todo_status: { desc: @todo_status.desc, name: @todo_status.name }
    end

    assert_redirected_to todo_status_path(assigns(:todo_status))
  end

  test "should show todo_status" do
    get :show, id: @todo_status
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @todo_status
    assert_response :success
  end

  test "should update todo_status" do
    put :update, id: @todo_status, todo_status: { desc: @todo_status.desc, name: @todo_status.name }
    assert_redirected_to todo_status_path(assigns(:todo_status))
  end

  test "should destroy todo_status" do
    assert_difference('TodoStatus.count', -1) do
      delete :destroy, id: @todo_status
    end

    assert_redirected_to todo_statuses_path
  end
end
