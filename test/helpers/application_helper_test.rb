require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "icon renders a Bootstrap Icons element" do
    assert_dom_equal '<i class="bi bi-rss"></i>', icon("rss")
  end

  test "icon merges additional classes" do
    assert_dom_equal '<i class="bi bi-rss text-muted"></i>', icon("rss", class: "text-muted")
  end
end
