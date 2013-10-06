require 'test_helper'

class PuppetOptionsControllerTest < ActionController::TestCase
  setup do
    @puppet_option = puppet_options(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:puppet_options)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create puppet_option" do
    assert_difference('PuppetOption.count') do
      post :create, puppet_option: { name: @puppet_option.name, option: @puppet_option.option, puppet_id: @puppet_option.puppet_id }
    end

    assert_redirected_to puppet_option_path(assigns(:puppet_option))
  end

  test "should show puppet_option" do
    get :show, id: @puppet_option
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @puppet_option
    assert_response :success
  end

  test "should update puppet_option" do
    patch :update, id: @puppet_option, puppet_option: { name: @puppet_option.name, option: @puppet_option.option, puppet_id: @puppet_option.puppet_id }
    assert_redirected_to puppet_option_path(assigns(:puppet_option))
  end

  test "should destroy puppet_option" do
    assert_difference('PuppetOption.count', -1) do
      delete :destroy, id: @puppet_option
    end

    assert_redirected_to puppet_options_path
  end
end
