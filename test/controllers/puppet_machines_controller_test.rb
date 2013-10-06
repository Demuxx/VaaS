require 'test_helper'

class PuppetMachinesControllerTest < ActionController::TestCase
  setup do
    @puppet_machine = puppet_machines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:puppet_machines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create puppet_machine" do
    assert_difference('PuppetMachine.count') do
      post :create, puppet_machine: { machine_id: @puppet_machine.machine_id, puppet_id: @puppet_machine.puppet_id }
    end

    assert_redirected_to puppet_machine_path(assigns(:puppet_machine))
  end

  test "should show puppet_machine" do
    get :show, id: @puppet_machine
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @puppet_machine
    assert_response :success
  end

  test "should update puppet_machine" do
    patch :update, id: @puppet_machine, puppet_machine: { machine_id: @puppet_machine.machine_id, puppet_id: @puppet_machine.puppet_id }
    assert_redirected_to puppet_machine_path(assigns(:puppet_machine))
  end

  test "should destroy puppet_machine" do
    assert_difference('PuppetMachine.count', -1) do
      delete :destroy, id: @puppet_machine
    end

    assert_redirected_to puppet_machines_path
  end
end
