require "test_helper"

class AddressesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @address = addresses(:one)
    @user = users(:admin)
  end

  test "should get index" do
    get addresses_url
    assert_response :success
  end

  test "should show address" do
    get address_url(@address)
    assert_response :success
  end

  test "showing an address as a guest increments the view count" do
    assert_difference -> { @address.reload.views }, 1 do
      get address_url(@address)
    end
  end

  test "new requires authentication" do
    get new_address_url
    assert_redirected_to new_user_session_url
  end

  test "signed-in users can get new" do
    sign_in @user
    get new_address_url
    assert_response :success
  end

  test "guests cannot create an address" do
    assert_no_difference("Address.count") do
      post addresses_url, params: { address: { address: 0x4a } }
    end
    assert_redirected_to new_user_session_url
  end

  test "signed-in users can create an address" do
    sign_in @user
    assert_difference("Address.count", 1) do
      post addresses_url, params: { address: { address: 0x4a } }
    end
    assert_redirected_to address_url(Address.last)
  end

  test "edit requires authentication" do
    get edit_address_url(@address)
    assert_redirected_to new_user_session_url
  end

  test "guests cannot update an address" do
    patch address_url(@address), params: { address: { reserved: true } }
    assert_redirected_to new_user_session_url
  end

  test "signed-in users can update an address" do
    sign_in @user
    patch address_url(@address), params: { address: { reserved: true } }
    assert_redirected_to address_url(@address)
    assert @address.reload.reserved
  end

  test "guests cannot destroy an address" do
    assert_no_difference("Address.count") do
      delete address_url(@address)
    end
    assert_redirected_to new_user_session_url
  end

  test "signed-in users can destroy an address" do
    sign_in @user
    assert_difference("Address.count", -1) do
      delete address_url(@address)
    end
    assert_redirected_to addresses_url
  end
end
