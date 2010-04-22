require 'test_helper'

class ReplyshipsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:replyships)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create replyship" do
    assert_difference('Replyship.count') do
      post :create, :replyship => { }
    end

    assert_redirected_to replyship_path(assigns(:replyship))
  end

  test "should show replyship" do
    get :show, :id => replyships(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => replyships(:one).to_param
    assert_response :success
  end

  test "should update replyship" do
    put :update, :id => replyships(:one).to_param, :replyship => { }
    assert_redirected_to replyship_path(assigns(:replyship))
  end

  test "should destroy replyship" do
    assert_difference('Replyship.count', -1) do
      delete :destroy, :id => replyships(:one).to_param
    end

    assert_redirected_to replyships_path
  end
end
