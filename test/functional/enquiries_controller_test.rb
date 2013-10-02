require 'test_helper'

class EnquiriesControllerTest < ActionController::TestCase
  setup do
    @enquiry = enquiries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:enquiries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create enquiry" do
    assert_difference('Enquiry.count') do
      post :create, enquiry: { assigned_by: @enquiry.assigned_by, assigned_to: @enquiry.assigned_to, created_by: @enquiry.created_by, date_of_birth: @enquiry.date_of_birth, email1: @enquiry.email1, email2: @enquiry.email2, first_name: @enquiry.first_name, gender: @enquiry.gender, mobile1: @enquiry.mobile1, mobile2: @enquiry.mobile2, score: @enquiry.score, source_id: @enquiry.source_id, surname: @enquiry.surname, updated_by: @enquiry.updated_by }
    end

    assert_redirected_to enquiry_path(assigns(:enquiry))
  end

  test "should show enquiry" do
    get :show, id: @enquiry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @enquiry
    assert_response :success
  end

  test "should update enquiry" do
    put :update, id: @enquiry, enquiry: { assigned_by: @enquiry.assigned_by, assigned_to: @enquiry.assigned_to, created_by: @enquiry.created_by, date_of_birth: @enquiry.date_of_birth, email1: @enquiry.email1, email2: @enquiry.email2, first_name: @enquiry.first_name, gender: @enquiry.gender, mobile1: @enquiry.mobile1, mobile2: @enquiry.mobile2, score: @enquiry.score, source_id: @enquiry.source_id, surname: @enquiry.surname, updated_by: @enquiry.updated_by }
    assert_redirected_to enquiry_path(assigns(:enquiry))
  end

  test "should destroy enquiry" do
    assert_difference('Enquiry.count', -1) do
      delete :destroy, id: @enquiry
    end

    assert_redirected_to enquiries_path
  end
end
