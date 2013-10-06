require 'test_helper'

class ChefMachinesControllerTest < ActionController::TestCase
  setup do
    @chef_machine = chef_machines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:chef_machines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create chef_machine" do
    assert_difference('ChefMachine.count') do
      post :create, chef_machine: { chef_id: @chef_machine.chef_id, machine_id: @chef_machine.machine_id }
    end

    assert_redirected_to chef_machine_path(assigns(:chef_machine))
  end

  test "should show chef_machine" do
    get :show, id: @chef_machine
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @chef_machine
    assert_response :success
  end

  test "should update chef_machine" do
    patch :update, id: @chef_machine, chef_machine: { chef_id: @chef_machine.chef_id, machine_id: @chef_machine.machine_id }
    assert_redirected_to chef_machine_path(assigns(:chef_machine))
  end

  test "should destroy chef_machine" do
    assert_difference('ChefMachine.count', -1) do
      delete :destroy, id: @chef_machine
    end

    assert_redirected_to chef_machines_path
  end
end
