require 'test_helper'

class EnglishLevelsControllerTest < ActionController::TestCase
  setup do
    @english_level = english_levels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:english_levels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create english_level" do
    assert_difference('EnglishLevel.count') do
      post :create, english_level: {  }
    end

    assert_redirected_to english_level_path(assigns(:english_level))
  end

  test "should show english_level" do
    get :show, id: @english_level
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @english_level
    assert_response :success
  end

  test "should update english_level" do
    put :update, id: @english_level, english_level: {  }
    assert_redirected_to english_level_path(assigns(:english_level))
  end

  test "should destroy english_level" do
    assert_difference('EnglishLevel.count', -1) do
      delete :destroy, id: @english_level
    end

    assert_redirected_to english_levels_path
  end
end
