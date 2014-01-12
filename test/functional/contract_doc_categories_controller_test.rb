require 'test_helper'

class ContractDocCategoriesControllerTest < ActionController::TestCase
  setup do
    @contract_doc_category = contract_doc_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contract_doc_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contract_doc_category" do
    assert_difference('ContractDocCategory.count') do
      post :create, contract_doc_category: { created_by: @contract_doc_category.created_by, desc: @contract_doc_category.desc, name: @contract_doc_category.name, updated_by: @contract_doc_category.updated_by }
    end

    assert_redirected_to contract_doc_category_path(assigns(:contract_doc_category))
  end

  test "should show contract_doc_category" do
    get :show, id: @contract_doc_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contract_doc_category
    assert_response :success
  end

  test "should update contract_doc_category" do
    put :update, id: @contract_doc_category, contract_doc_category: { created_by: @contract_doc_category.created_by, desc: @contract_doc_category.desc, name: @contract_doc_category.name, updated_by: @contract_doc_category.updated_by }
    assert_redirected_to contract_doc_category_path(assigns(:contract_doc_category))
  end

  test "should destroy contract_doc_category" do
    assert_difference('ContractDocCategory.count', -1) do
      delete :destroy, id: @contract_doc_category
    end

    assert_redirected_to contract_doc_categories_path
  end
end
