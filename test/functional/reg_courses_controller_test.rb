require 'test_helper'

class RegCoursesControllerTest < ActionController::TestCase
  setup do
    @reg_course = reg_courses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reg_courses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reg_course" do
    assert_difference('RegCourse.count') do
      post :create, reg_course: { app_status_id: @reg_course.app_status_id, city_id: @reg_course.city_id, country_id: @reg_course.country_id, course_level_id: @reg_course.course_level_id, course_subject: @reg_course.course_subject, end_date: @reg_course.end_date, ins_ref_no: @reg_course.ins_ref_no, institution_id: @reg_course.institution_id, programme_type_id: @reg_course.programme_type_id, start_date: @reg_course.start_date }
    end

    assert_redirected_to reg_course_path(assigns(:reg_course))
  end

  test "should show reg_course" do
    get :show, id: @reg_course
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reg_course
    assert_response :success
  end

  test "should update reg_course" do
    put :update, id: @reg_course, reg_course: { app_status_id: @reg_course.app_status_id, city_id: @reg_course.city_id, country_id: @reg_course.country_id, course_level_id: @reg_course.course_level_id, course_subject: @reg_course.course_subject, end_date: @reg_course.end_date, ins_ref_no: @reg_course.ins_ref_no, institution_id: @reg_course.institution_id, programme_type_id: @reg_course.programme_type_id, start_date: @reg_course.start_date }
    assert_redirected_to reg_course_path(assigns(:reg_course))
  end

  test "should destroy reg_course" do
    assert_difference('RegCourse.count', -1) do
      delete :destroy, id: @reg_course
    end

    assert_redirected_to reg_courses_path
  end
end
