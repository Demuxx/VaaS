require 'test_helper'

class BashesControllerTest < ActionController::TestCase
  setup do
    @bash = bashes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bashes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bash" do
    assert_difference('Bash.count') do
      post :create, bash: { file: @bash.file, raw: @bash.raw }
    end

    assert_redirected_to bash_path(assigns(:bash))
  end

  test "should show bash" do
    get :show, id: @bash
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bash
    assert_response :success
  end

  test "should update bash" do
    patch :update, id: @bash, bash: { file: @bash.file, raw: @bash.raw }
    assert_redirected_to bash_path(assigns(:bash))
  end

  test "should destroy bash" do
    assert_difference('Bash.count', -1) do
      delete :destroy, id: @bash
    end

    assert_redirected_to bashes_path
  end
end
