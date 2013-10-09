require 'test_helper'

class DocCategoriesControllerTest < ActionController::TestCase
  setup do
    @doc_category = doc_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:doc_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create doc_category" do
    assert_difference('DocCategory.count') do
      post :create, doc_category: { desc: @doc_category.desc, name: @doc_category.name }
    end

    assert_redirected_to doc_category_path(assigns(:doc_category))
  end

  test "should show doc_category" do
    get :show, id: @doc_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @doc_category
    assert_response :success
  end

  test "should update doc_category" do
    put :update, id: @doc_category, doc_category: { desc: @doc_category.desc, name: @doc_category.name }
    assert_redirected_to doc_category_path(assigns(:doc_category))
  end

  test "should destroy doc_category" do
    assert_difference('DocCategory.count', -1) do
      delete :destroy, id: @doc_category
    end

    assert_redirected_to doc_categories_path
  end
end
