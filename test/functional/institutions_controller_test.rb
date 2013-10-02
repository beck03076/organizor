require 'test_helper'

class InstitutionsControllerTest < ActionController::TestCase
  setup do
    @institution = institutions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:institutions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create institution" do
    assert_difference('Institution.count') do
      post :create, institution: { city_id: @institution.city_id, country_id: @institution.country_id, created_by: @institution.created_by, name: @institution.name, poc: @institution.poc, type_id: @institution.type_id, updated_by: @institution.updated_by }
    end

    assert_redirected_to institution_path(assigns(:institution))
  end

  test "should show institution" do
    get :show, id: @institution
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @institution
    assert_response :success
  end

  test "should update institution" do
    put :update, id: @institution, institution: { city_id: @institution.city_id, country_id: @institution.country_id, created_by: @institution.created_by, name: @institution.name, poc: @institution.poc, type_id: @institution.type_id, updated_by: @institution.updated_by }
    assert_redirected_to institution_path(assigns(:institution))
  end

  test "should destroy institution" do
    assert_difference('Institution.count', -1) do
      delete :destroy, id: @institution
    end

    assert_redirected_to institutions_path
  end
end
