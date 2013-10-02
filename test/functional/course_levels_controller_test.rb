require 'test_helper'

class CourseLevelsControllerTest < ActionController::TestCase
  setup do
    @course_level = course_levels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:course_levels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create course_level" do
    assert_difference('CourseLevel.count') do
      post :create, course_level: { created_by: @course_level.created_by, desc: @course_level.desc, name: @course_level.name, updated_by: @course_level.updated_by }
    end

    assert_redirected_to course_level_path(assigns(:course_level))
  end

  test "should show course_level" do
    get :show, id: @course_level
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @course_level
    assert_response :success
  end

  test "should update course_level" do
    put :update, id: @course_level, course_level: { created_by: @course_level.created_by, desc: @course_level.desc, name: @course_level.name, updated_by: @course_level.updated_by }
    assert_redirected_to course_level_path(assigns(:course_level))
  end

  test "should destroy course_level" do
    assert_difference('CourseLevel.count', -1) do
      delete :destroy, id: @course_level
    end

    assert_redirected_to course_levels_path
  end
end
