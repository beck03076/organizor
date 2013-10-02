require 'test_helper'

class SubAgentsControllerTest < ActionController::TestCase
  setup do
    @sub_agent = sub_agents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sub_agents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sub_agent" do
    assert_difference('SubAgent.count') do
      post :create, sub_agent: {  }
    end

    assert_redirected_to sub_agent_path(assigns(:sub_agent))
  end

  test "should show sub_agent" do
    get :show, id: @sub_agent
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sub_agent
    assert_response :success
  end

  test "should update sub_agent" do
    put :update, id: @sub_agent, sub_agent: {  }
    assert_redirected_to sub_agent_path(assigns(:sub_agent))
  end

  test "should destroy sub_agent" do
    assert_difference('SubAgent.count', -1) do
      delete :destroy, id: @sub_agent
    end

    assert_redirected_to sub_agents_path
  end
end
