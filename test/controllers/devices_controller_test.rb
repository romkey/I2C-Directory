require "test_helper"

class DevicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @device = devices(:one)
    @suggestion = devices(:two)
    @user = users(:admin)
  end

  # ---- index --------------------------------------------------------------

  test "should get index" do
    get devices_url
    assert_response :success
  end

  test "index only shows published devices to guests" do
    get devices_url
    assert_match @device.part_number, @response.body
    assert_no_match @suggestion.part_number, @response.body
  end

  test "index supports searching by part number" do
    get devices_url(q: "BME")
    assert_response :success
    assert_match @device.part_number, @response.body
  end

  test "search is parameterized and safe against injection" do
    get devices_url(q: "' OR 1=1 --")
    assert_response :success
  end

  test "signed-in users can filter to suggestions" do
    sign_in @user
    get devices_url(suggestion: "1")
    assert_response :success
    assert_match @suggestion.part_number, @response.body
  end

  test "index renders json" do
    get devices_url(format: :json)
    assert_response :success
    assert_equal "application/json", @response.media_type
  end

  test "index renders the cpp scanner sketch" do
    get "/devices.cpp"
    assert_response :success
  end

  test "feed renders rss" do
    get devices_url(format: :rss)
    assert_response :success
  end

  # ---- show ---------------------------------------------------------------

  test "should show device" do
    get device_url(@device)
    assert_response :success
  end

  test "showing a device as a guest increments the view count" do
    assert_difference -> { @device.reload.views }, 1 do
      get device_url(@device)
    end
  end

  test "showing a device while signed in does not increment views" do
    sign_in @user
    assert_no_difference -> { @device.reload.views } do
      get device_url(@device)
    end
  end

  # ---- new / suggest_new --------------------------------------------------

  test "new requires authentication" do
    get new_device_url
    assert_redirected_to new_user_session_url
  end

  test "signed-in users can get new" do
    sign_in @user
    get new_device_url
    assert_response :success
  end

  test "anyone can reach the suggest_new form" do
    get "/devices/suggest_new"
    assert_response :success
  end

  # ---- create -------------------------------------------------------------

  test "guests cannot create a regular device" do
    assert_no_difference("Device.count") do
      post devices_url, params: { device: { part_number: "NEW123", friendly_name: "thing" } }
    end
    assert_redirected_to new_user_session_path
  end

  test "guests can submit a suggestion and it emails an admin" do
    assert_difference("Device.count", 1) do
      assert_emails 1 do
        post devices_url, params: { device: { part_number: "SUG123", friendly_name: "suggested", suggestion: true } }
      end
    end
  end

  test "signed-in users can create a device" do
    sign_in @user
    assert_difference("Device.count", 1) do
      post devices_url, params: { device: { part_number: "ADM123", friendly_name: "admin made" } }
    end
    assert_redirected_to device_url(Device.find_by(part_number: "ADM123"))
  end

  # ---- update / destroy ---------------------------------------------------

  test "update requires authentication" do
    patch device_url(@device), params: { device: { friendly_name: "x" } }
    assert_redirected_to new_user_session_url
  end

  test "signed-in users can update a device" do
    sign_in @user
    patch device_url(@device), params: { device: { friendly_name: "Updated name" } }
    assert_redirected_to device_url(@device)
    assert_equal "Updated name", @device.reload.friendly_name
  end

  test "destroy requires authentication" do
    assert_no_difference("Device.count") do
      delete device_url(@device)
    end
    assert_redirected_to new_user_session_url
  end

  test "signed-in users can destroy a device" do
    sign_in @user
    assert_difference("Device.count", -1) do
      delete device_url(@device)
    end
    assert_redirected_to devices_url
  end

  # ---- driver / clear_suggestions -----------------------------------------

  test "driver promotes a suggestion into the device drivers list" do
    sign_in @user
    suggestion = @device.datasheet_suggestions.create!(title: "Lib", link: "https://example.com/lib", kind: "driver")

    get "/devices/#{@device.slug}/driver/#{suggestion.id}"

    assert_not DatasheetSuggestion.exists?(suggestion.id)
    assert_equal "Lib", @device.reload.drivers.last["title"]
  end

  test "clear_suggestions removes all suggestions for a device" do
    sign_in @user
    @device.datasheet_suggestions.create!(title: "DS", link: "https://example.com/ds.pdf", kind: "datasheet")

    get "/devices/#{@device.slug}/clear_suggestions"

    assert_redirected_to "/admin"
    assert_equal 0, @device.datasheet_suggestions.count
  end
end
