require 'test_helper'

class PuppetFactsControllerTest < ActionController::TestCase
  setup do
    @puppet_fact = puppet_facts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:puppet_facts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create puppet_fact" do
    assert_difference('PuppetFact.count') do
      post :create, puppet_fact: { key: @puppet_fact.key, name: @puppet_fact.name, puppet_id: @puppet_fact.puppet_id, value: @puppet_fact.value }
    end

    assert_redirected_to puppet_fact_path(assigns(:puppet_fact))
  end

  test "should show puppet_fact" do
    get :show, id: @puppet_fact
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @puppet_fact
    assert_response :success
  end

  test "should update puppet_fact" do
    patch :update, id: @puppet_fact, puppet_fact: { key: @puppet_fact.key, name: @puppet_fact.name, puppet_id: @puppet_fact.puppet_id, value: @puppet_fact.value }
    assert_redirected_to puppet_fact_path(assigns(:puppet_fact))
  end

  test "should destroy puppet_fact" do
    assert_difference('PuppetFact.count', -1) do
      delete :destroy, id: @puppet_fact
    end

    assert_redirected_to puppet_facts_path
  end
end
