require 'test_helper'

class AllowIpsControllerTest < ActionController::TestCase
  setup do
    @allow_ip = allow_ips(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:allow_ips)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create allow_ip" do
    assert_difference('AllowIp.count') do
      post :create, allow_ip: { desc: @allow_ip.desc, from: @allow_ip.from, to: @allow_ip.to }
    end

    assert_redirected_to allow_ip_path(assigns(:allow_ip))
  end

  test "should show allow_ip" do
    get :show, id: @allow_ip
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @allow_ip
    assert_response :success
  end

  test "should update allow_ip" do
    put :update, id: @allow_ip, allow_ip: { desc: @allow_ip.desc, from: @allow_ip.from, to: @allow_ip.to }
    assert_redirected_to allow_ip_path(assigns(:allow_ip))
  end

  test "should destroy allow_ip" do
    assert_difference('AllowIp.count', -1) do
      delete :destroy, id: @allow_ip
    end

    assert_redirected_to allow_ips_path
  end
end
