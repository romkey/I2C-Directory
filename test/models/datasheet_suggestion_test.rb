require "test_helper"

class DatasheetSuggestionTest < ActiveSupport::TestCase
  test "belongs to a device" do
    suggestion = DatasheetSuggestion.new(title: "Datasheet", link: "https://example.com/ds.pdf")
    assert_not suggestion.valid?, "should require a device"

    suggestion.device = devices(:one)
    assert suggestion.valid?
  end

  test "is reachable through the device association" do
    device = devices(:one)
    device.datasheet_suggestions.create!(title: "DS", link: "https://example.com/ds.pdf", kind: "datasheet")

    assert_equal 1, device.datasheet_suggestions.count
  end
end
