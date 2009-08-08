require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post :create, :order => { }
    end

    assert_redirected_to order_path(assigns(:order))
  end

  test "should show order" do
    get :show, :id => orders(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => orders(:one).to_param
    assert_response :success
  end

  test "should update order" do
    put :update, :id => orders(:one).to_param, :order => { }
    assert_redirected_to order_path(assigns(:order))
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, :id => orders(:one).to_param
    end

    assert_redirected_to orders_path
  end
end
