require 'test_helper'

class ProgrammesControllerTest < ActionController::TestCase
  setup do
    @programme = programmes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:programmes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create programme" do
    assert_difference('Programme.count') do
      post :create, programme: { city_id: @programme.city_id, country_id: @programme.country_id, created_by: @programme.created_by, end_date: @programme.end_date, enquiry_id: @programme.enquiry_id, institution_id: @programme.institution_id, level_id: @programme.level_id, start_date: @programme.start_date, subject_id: @programme.subject_id, type_id: @programme.type_id, updated_by: @programme.updated_by }
    end

    assert_redirected_to programme_path(assigns(:programme))
  end

  test "should show programme" do
    get :show, id: @programme
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @programme
    assert_response :success
  end

  test "should update programme" do
    put :update, id: @programme, programme: { city_id: @programme.city_id, country_id: @programme.country_id, created_by: @programme.created_by, end_date: @programme.end_date, enquiry_id: @programme.enquiry_id, institution_id: @programme.institution_id, level_id: @programme.level_id, start_date: @programme.start_date, subject_id: @programme.subject_id, type_id: @programme.type_id, updated_by: @programme.updated_by }
    assert_redirected_to programme_path(assigns(:programme))
  end

  test "should destroy programme" do
    assert_difference('Programme.count', -1) do
      delete :destroy, id: @programme
    end

    assert_redirected_to programmes_path
  end
end
