require "test_helper"

class SitemapControllerTest < ActionDispatch::IntegrationTest
  test "renders the sitemap as XML" do
    get sitemap_url
    assert_response :success
    assert_equal "application/xml", @response.media_type
  end
end
