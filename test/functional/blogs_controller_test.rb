require 'test_helper'
require 'devise/test_helpers'

class BlogsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @blog = blogs(:one)
    sign_in users(:one)
    @users= User.all
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:blogs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create blog" do
    assert_difference('Blog.count') do
      post :create, :blog => { :site => Site.new({:hostname => 'foo.lvh.me'}), :name => "123blog", :authors => [User.first]}
    end

    assert_redirected_to blog_path(assigns(:blog))
  end

  test "should show blog" do
    get :show, :id => @blog.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @blog.to_param
    assert_response :success
  end

  test "should update blog" do
    put :update, :id => @blog.to_param, :blog => @blog.attributes
    assert_redirected_to blog_path(assigns(:blog))
  end

  test "should destroy blog" do
    assert_difference('Blog.count', -1) do
      delete :destroy, :id => @blog.to_param
    end

    assert_redirected_to blogs_path
  end
end
