require 'test_helper'

class YolksControllerTest < ActionController::TestCase
  setup do
    @yolk = yolks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:yolks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create yolk" do
    assert_difference('Yolk.count') do
      post :create, yolk: { name: @yolk.name }
    end

    assert_redirected_to yolk_path(assigns(:yolk))
  end

  test "should show yolk" do
    get :show, id: @yolk
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @yolk
    assert_response :success
  end

  test "should update yolk" do
    put :update, id: @yolk, yolk: { name: @yolk.name }
    assert_redirected_to yolk_path(assigns(:yolk))
  end

  test "should destroy yolk" do
    assert_difference('Yolk.count', -1) do
      delete :destroy, id: @yolk
    end

    assert_redirected_to yolks_path
  end
end
