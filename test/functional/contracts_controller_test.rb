require 'test_helper'

class ContractsControllerTest < ActionController::TestCase
  setup do
    @contract = contracts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contracts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contract" do
    assert_difference('Contract.count') do
      post :create, contract: { commission_rate: @contract.commission_rate, current_contract_end_date: @contract.current_contract_end_date, current_contract_start_date: @contract.current_contract_start_date, desc: @contract.desc, initiate_date: @contract.initiate_date, institution_id: @contract.institution_id, internal_target: @contract.internal_target, invoicing_deadline: @contract.invoicing_deadline, name: @contract.name, partners_target: @contract.partners_target, recruitment_territories: @contract.recruitment_territories, renewal_reminder_date: @contract.renewal_reminder_date }
    end

    assert_redirected_to contract_path(assigns(:contract))
  end

  test "should show contract" do
    get :show, id: @contract
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contract
    assert_response :success
  end

  test "should update contract" do
    put :update, id: @contract, contract: { commission_rate: @contract.commission_rate, current_contract_end_date: @contract.current_contract_end_date, current_contract_start_date: @contract.current_contract_start_date, desc: @contract.desc, initiate_date: @contract.initiate_date, institution_id: @contract.institution_id, internal_target: @contract.internal_target, invoicing_deadline: @contract.invoicing_deadline, name: @contract.name, partners_target: @contract.partners_target, recruitment_territories: @contract.recruitment_territories, renewal_reminder_date: @contract.renewal_reminder_date }
    assert_redirected_to contract_path(assigns(:contract))
  end

  test "should destroy contract" do
    assert_difference('Contract.count', -1) do
      delete :destroy, id: @contract
    end

    assert_redirected_to contracts_path
  end
end
