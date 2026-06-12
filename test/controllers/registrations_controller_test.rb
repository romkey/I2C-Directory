require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "registration is closed to guests once a user exists" do
    assert User.exists?
    get new_user_registration_url
    assert_redirected_to new_user_session_path
  end

  test "signed-in users are sent home instead of registering" do
    sign_in users(:admin)
    get new_user_registration_url
    assert_redirected_to root_path
  end

  test "registration is open when there are no users yet" do
    User.delete_all
    get new_user_registration_url
    assert_response :success
  end
end
