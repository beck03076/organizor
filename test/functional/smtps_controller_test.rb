require 'test_helper'

class SmtpsControllerTest < ActionController::TestCase
  setup do
    @smtp = smtps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:smtps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create smtp" do
    assert_difference('Smtp.count') do
      post :create, smtp: {  }
    end

    assert_redirected_to smtp_path(assigns(:smtp))
  end

  test "should show smtp" do
    get :show, id: @smtp
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @smtp
    assert_response :success
  end

  test "should update smtp" do
    put :update, id: @smtp, smtp: {  }
    assert_redirected_to smtp_path(assigns(:smtp))
  end

  test "should destroy smtp" do
    assert_difference('Smtp.count', -1) do
      delete :destroy, id: @smtp
    end

    assert_redirected_to smtps_path
  end
end
