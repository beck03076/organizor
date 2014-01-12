require 'test_helper'

class CommissionStatusesControllerTest < ActionController::TestCase
  setup do
    @commission_status = commission_statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:commission_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create commission_status" do
    assert_difference('CommissionStatus.count') do
      post :create, commission_status: { created_by: @commission_status.created_by, desc: @commission_status.desc, name: @commission_status.name, updated_by: @commission_status.updated_by }
    end

    assert_redirected_to commission_status_path(assigns(:commission_status))
  end

  test "should show commission_status" do
    get :show, id: @commission_status
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @commission_status
    assert_response :success
  end

  test "should update commission_status" do
    put :update, id: @commission_status, commission_status: { created_by: @commission_status.created_by, desc: @commission_status.desc, name: @commission_status.name, updated_by: @commission_status.updated_by }
    assert_redirected_to commission_status_path(assigns(:commission_status))
  end

  test "should destroy commission_status" do
    assert_difference('CommissionStatus.count', -1) do
      delete :destroy, id: @commission_status
    end

    assert_redirected_to commission_statuses_path
  end
end
