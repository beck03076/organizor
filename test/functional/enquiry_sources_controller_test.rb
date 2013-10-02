require 'test_helper'

class EnquirySourcesControllerTest < ActionController::TestCase
  setup do
    @enquiry_source = enquiry_sources(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:enquiry_sources)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create enquiry_source" do
    assert_difference('EnquirySource.count') do
      post :create, enquiry_source: { created_by: @enquiry_source.created_by, desc: @enquiry_source.desc, name: @enquiry_source.name, updated_by: @enquiry_source.updated_by }
    end

    assert_redirected_to enquiry_source_path(assigns(:enquiry_source))
  end

  test "should show enquiry_source" do
    get :show, id: @enquiry_source
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @enquiry_source
    assert_response :success
  end

  test "should update enquiry_source" do
    put :update, id: @enquiry_source, enquiry_source: { created_by: @enquiry_source.created_by, desc: @enquiry_source.desc, name: @enquiry_source.name, updated_by: @enquiry_source.updated_by }
    assert_redirected_to enquiry_source_path(assigns(:enquiry_source))
  end

  test "should destroy enquiry_source" do
    assert_difference('EnquirySource.count', -1) do
      delete :destroy, id: @enquiry_source
    end

    assert_redirected_to enquiry_sources_path
  end
end
