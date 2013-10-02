require 'test_helper'

class TodoTopicsControllerTest < ActionController::TestCase
  setup do
    @todo_topic = todo_topics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:todo_topics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create todo_topic" do
    assert_difference('TodoTopic.count') do
      post :create, todo_topic: { desc: @todo_topic.desc, name: @todo_topic.name }
    end

    assert_redirected_to todo_topic_path(assigns(:todo_topic))
  end

  test "should show todo_topic" do
    get :show, id: @todo_topic
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @todo_topic
    assert_response :success
  end

  test "should update todo_topic" do
    put :update, id: @todo_topic, todo_topic: { desc: @todo_topic.desc, name: @todo_topic.name }
    assert_redirected_to todo_topic_path(assigns(:todo_topic))
  end

  test "should destroy todo_topic" do
    assert_difference('TodoTopic.count', -1) do
      delete :destroy, id: @todo_topic
    end

    assert_redirected_to todo_topics_path
  end
end
