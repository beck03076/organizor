require 'test_helper'

class StudentSourcesControllerTest < ActionController::TestCase
  setup do
    @student_source = student_sources(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:student_sources)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create student_source" do
    assert_difference('StudentSource.count') do
      post :create, student_source: { index: @student_source.index }
    end

    assert_redirected_to student_source_path(assigns(:student_source))
  end

  test "should show student_source" do
    get :show, id: @student_source
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @student_source
    assert_response :success
  end

  test "should update student_source" do
    put :update, id: @student_source, student_source: { index: @student_source.index }
    assert_redirected_to student_source_path(assigns(:student_source))
  end

  test "should destroy student_source" do
    assert_difference('StudentSource.count', -1) do
      delete :destroy, id: @student_source
    end

    assert_redirected_to student_sources_path
  end
end
