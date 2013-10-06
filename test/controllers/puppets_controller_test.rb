require 'test_helper'

class PuppetsControllerTest < ActionController::TestCase
  setup do
    @puppet = puppets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:puppets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create puppet" do
    assert_difference('Puppet.count') do
      post :create, puppet: { manifest_file: @puppet.manifest_file, manifest_path: @puppet.manifest_path, modules_path: @puppet.modules_path, name: @puppet.name }
    end

    assert_redirected_to puppet_path(assigns(:puppet))
  end

  test "should show puppet" do
    get :show, id: @puppet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @puppet
    assert_response :success
  end

  test "should update puppet" do
    patch :update, id: @puppet, puppet: { manifest_file: @puppet.manifest_file, manifest_path: @puppet.manifest_path, modules_path: @puppet.modules_path, name: @puppet.name }
    assert_redirected_to puppet_path(assigns(:puppet))
  end

  test "should destroy puppet" do
    assert_difference('Puppet.count', -1) do
      delete :destroy, id: @puppet
    end

    assert_redirected_to puppets_path
  end
end
