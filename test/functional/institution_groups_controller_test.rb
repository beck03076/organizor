require 'test_helper'

class InstitutionGroupsControllerTest < ActionController::TestCase
  setup do
    @institution_group = institution_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:institution_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create institution_group" do
    assert_difference('InstitutionGroup.count') do
      post :create, institution_group: {  }
    end

    assert_redirected_to institution_group_path(assigns(:institution_group))
  end

  test "should show institution_group" do
    get :show, id: @institution_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @institution_group
    assert_response :success
  end

  test "should update institution_group" do
    put :update, id: @institution_group, institution_group: {  }
    assert_redirected_to institution_group_path(assigns(:institution_group))
  end

  test "should destroy institution_group" do
    assert_difference('InstitutionGroup.count', -1) do
      delete :destroy, id: @institution_group
    end

    assert_redirected_to institution_groups_path
  end
end
