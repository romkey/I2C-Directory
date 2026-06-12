require "test_helper"

class ContactsControllerTest < ActionDispatch::IntegrationTest
  include ActionMailer::TestHelper

  test "renders the contact form" do
    get "/contact"
    assert_response :success
  end

  test "a valid submission enqueues an email and redirects" do
    assert_enqueued_emails 1 do
      post "/contact", params: { contact: { name: "Sam", email: "sam@example.com", message: "Hi there" } }
    end
    assert_redirected_to root_path
  end

  test "an invalid submission re-renders the form and sends nothing" do
    assert_no_enqueued_emails do
      post "/contact", params: { contact: { name: "Sam", email: "", message: "" } }
    end
    assert_response :unprocessable_entity
  end
end
