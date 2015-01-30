require 'test_helper'

class TaskTopicsControllerTest < ActionController::TestCase
  setup do
    @task_topic = task_topics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:task_topics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create task_topic" do
    assert_difference('TaskTopic.count') do
      post :create, task_topic: { desc: @task_topic.desc, name: @task_topic.name }
    end

    assert_redirected_to task_topic_path(assigns(:task_topic))
  end

  test "should show task_topic" do
    get :show, id: @task_topic
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @task_topic
    assert_response :success
  end

  test "should update task_topic" do
    put :update, id: @task_topic, task_topic: { desc: @task_topic.desc, name: @task_topic.name }
    assert_redirected_to task_topic_path(assigns(:task_topic))
  end

  test "should destroy task_topic" do
    assert_difference('TaskTopic.count', -1) do
      delete :destroy, id: @task_topic
    end

    assert_redirected_to task_topics_path
  end
end
