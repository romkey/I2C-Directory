require "test_helper"

class ResourceTest < ActiveSupport::TestCase
  test "is valid with a title and link" do
    resource = Resource.new(title: "Datasheet archive", link: "https://example.com")
    assert resource.valid?
  end

  test "persists title and link" do
    resource = Resource.create!(title: "T", link: "https://example.com/t")
    assert_equal "T", resource.reload.title
  end
end
