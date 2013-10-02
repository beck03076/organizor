require 'test_helper'

class ExamTypesControllerTest < ActionController::TestCase
  setup do
    @exam_type = exam_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:exam_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create exam_type" do
    assert_difference('ExamType.count') do
      post :create, exam_type: {  }
    end

    assert_redirected_to exam_type_path(assigns(:exam_type))
  end

  test "should show exam_type" do
    get :show, id: @exam_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @exam_type
    assert_response :success
  end

  test "should update exam_type" do
    put :update, id: @exam_type, exam_type: {  }
    assert_redirected_to exam_type_path(assigns(:exam_type))
  end

  test "should destroy exam_type" do
    assert_difference('ExamType.count', -1) do
      delete :destroy, id: @exam_type
    end

    assert_redirected_to exam_types_path
  end
end
