require 'test_helper'

class ChefJsonsControllerTest < ActionController::TestCase
  setup do
    @chef_json = chef_jsons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:chef_jsons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create chef_json" do
    assert_difference('ChefJson.count') do
      post :create, chef_json: { chef_id: @chef_json.chef_id, key: @chef_json.key, value: @chef_json.value }
    end

    assert_redirected_to chef_json_path(assigns(:chef_json))
  end

  test "should show chef_json" do
    get :show, id: @chef_json
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @chef_json
    assert_response :success
  end

  test "should update chef_json" do
    patch :update, id: @chef_json, chef_json: { chef_id: @chef_json.chef_id, key: @chef_json.key, value: @chef_json.value }
    assert_redirected_to chef_json_path(assigns(:chef_json))
  end

  test "should destroy chef_json" do
    assert_difference('ChefJson.count', -1) do
      delete :destroy, id: @chef_json
    end

    assert_redirected_to chef_jsons_path
  end
end
