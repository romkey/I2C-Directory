require "test_helper"

class ResourcesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @resource = resources(:one)
    @user = users(:admin)
  end

  test "index is public" do
    get resources_url
    assert_response :success
  end

  test "show requires authentication" do
    get resource_url(@resource)
    assert_redirected_to new_user_session_url
  end

  test "signed-in users can show a resource" do
    sign_in @user
    get resource_url(@resource)
    assert_response :success
  end

  test "new requires authentication" do
    get new_resource_url
    assert_redirected_to new_user_session_url
  end

  test "guests cannot create a resource" do
    assert_no_difference("Resource.count") do
      post resources_url, params: { resource: { title: "T", link: "https://example.com" } }
    end
    assert_redirected_to new_user_session_url
  end

  test "signed-in users can create a resource" do
    sign_in @user
    assert_difference("Resource.count", 1) do
      post resources_url, params: { resource: { title: "New", link: "https://example.com/new" } }
    end
    assert_redirected_to resource_url(Resource.last)
  end

  test "signed-in users can update a resource" do
    sign_in @user
    patch resource_url(@resource), params: { resource: { title: "Renamed" } }
    assert_redirected_to resource_url(@resource)
    assert_equal "Renamed", @resource.reload.title
  end

  test "guests cannot destroy a resource" do
    assert_no_difference("Resource.count") do
      delete resource_url(@resource)
    end
    assert_redirected_to new_user_session_url
  end

  test "signed-in users can destroy a resource" do
    sign_in @user
    assert_difference("Resource.count", -1) do
      delete resource_url(@resource)
    end
    assert_redirected_to resources_url
  end
end
