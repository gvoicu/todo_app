require 'test_helper'

class DishTypesControllerTest < ActionController::TestCase
  setup do
    @dish_type = dish_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dish_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dish_type" do
    assert_difference('DishType.count') do
      post :create, dish_type: { name: @dish_type.name }
    end

    assert_redirected_to dish_type_path(assigns(:dish_type))
  end

  test "should show dish_type" do
    get :show, id: @dish_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dish_type
    assert_response :success
  end

  test "should update dish_type" do
    put :update, id: @dish_type, dish_type: { name: @dish_type.name }
    assert_redirected_to dish_type_path(assigns(:dish_type))
  end

  test "should destroy dish_type" do
    assert_difference('DishType.count', -1) do
      delete :destroy, id: @dish_type
    end

    assert_redirected_to dish_types_path
  end
end
