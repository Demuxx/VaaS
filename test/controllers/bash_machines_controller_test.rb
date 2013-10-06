require 'test_helper'

class BashMachinesControllerTest < ActionController::TestCase
  setup do
    @bash_machine = bash_machines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bash_machines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bash_machine" do
    assert_difference('BashMachine.count') do
      post :create, bash_machine: { bash_id: @bash_machine.bash_id, machine_id: @bash_machine.machine_id }
    end

    assert_redirected_to bash_machine_path(assigns(:bash_machine))
  end

  test "should show bash_machine" do
    get :show, id: @bash_machine
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bash_machine
    assert_response :success
  end

  test "should update bash_machine" do
    patch :update, id: @bash_machine, bash_machine: { bash_id: @bash_machine.bash_id, machine_id: @bash_machine.machine_id }
    assert_redirected_to bash_machine_path(assigns(:bash_machine))
  end

  test "should destroy bash_machine" do
    assert_difference('BashMachine.count', -1) do
      delete :destroy, id: @bash_machine
    end

    assert_redirected_to bash_machines_path
  end
end
