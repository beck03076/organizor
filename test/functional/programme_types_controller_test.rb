require 'test_helper'

class ProgrammeTypesControllerTest < ActionController::TestCase
  setup do
    @programme_type = programme_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:programme_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create programme_type" do
    assert_difference('ProgrammeType.count') do
      post :create, programme_type: { created_by: @programme_type.created_by, name: @programme_type.name, updated_by: @programme_type.updated_by }
    end

    assert_redirected_to programme_type_path(assigns(:programme_type))
  end

  test "should show programme_type" do
    get :show, id: @programme_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @programme_type
    assert_response :success
  end

  test "should update programme_type" do
    put :update, id: @programme_type, programme_type: { created_by: @programme_type.created_by, name: @programme_type.name, updated_by: @programme_type.updated_by }
    assert_redirected_to programme_type_path(assigns(:programme_type))
  end

  test "should destroy programme_type" do
    assert_difference('ProgrammeType.count', -1) do
      delete :destroy, id: @programme_type
    end

    assert_redirected_to programme_types_path
  end
end
