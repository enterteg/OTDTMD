require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get destroyupdate" do
    get :destroyupdate
    assert_response :success
  end

end
