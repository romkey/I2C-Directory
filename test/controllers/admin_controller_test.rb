require "test_helper"

class AdminControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:admin)
  end

  test "index requires authentication" do
    get "/admin"
    assert_redirected_to new_user_session_url
  end

  test "signed-in users can view the admin dashboard" do
    sign_in @user
    get "/admin"
    assert_response :success
  end

  test "import requires authentication" do
    post "/admin/import", params: { csv: fixture_file_upload("devices.csv", "text/csv") }
    assert_redirected_to new_user_session_url
  end

  test "signed-in users can import devices from CSV" do
    sign_in @user
    assert_difference("Device.count", 1) do
      post "/admin/import", params: { csv: fixture_file_upload("devices.csv", "text/csv") }
    end
    assert_redirected_to "/devices"
  end

  test "clear_database removes all devices" do
    sign_in @user
    assert Device.count.positive?
    get "/admin/clear_database"
    assert_equal 0, Device.count
    assert_redirected_to devices_path
  end
end
