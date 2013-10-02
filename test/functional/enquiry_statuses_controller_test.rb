require 'test_helper'

class EnquiryStatusesControllerTest < ActionController::TestCase
  setup do
    @enquiry_status = enquiry_statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:enquiry_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create enquiry_status" do
    assert_difference('EnquiryStatus.count') do
      post :create, enquiry_status: { desc: @enquiry_status.desc, name: @enquiry_status.name }
    end

    assert_redirected_to enquiry_status_path(assigns(:enquiry_status))
  end

  test "should show enquiry_status" do
    get :show, id: @enquiry_status
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @enquiry_status
    assert_response :success
  end

  test "should update enquiry_status" do
    put :update, id: @enquiry_status, enquiry_status: { desc: @enquiry_status.desc, name: @enquiry_status.name }
    assert_redirected_to enquiry_status_path(assigns(:enquiry_status))
  end

  test "should destroy enquiry_status" do
    assert_difference('EnquiryStatus.count', -1) do
      delete :destroy, id: @enquiry_status
    end

    assert_redirected_to enquiry_statuses_path
  end
end
