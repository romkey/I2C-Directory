require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "renders the home page" do
    get root_url
    assert_response :success
  end

  test "renders the about page" do
    get "/about"
    assert_response :success
  end
end
