require "test_helper"
require "I2CappSearch/search_for_datasheets"

class SuggestDatasheetsJobTest < ActiveSupport::TestCase
  # Temporarily replaces I2CappSearch.search_for_datasheets so the job never
  # makes a real network request, then restores the original implementation.
  def stub_datasheet_search(result)
    original = I2CappSearch.method(:search_for_datasheets)
    I2CappSearch.define_singleton_method(:search_for_datasheets) { |*| result }
    yield
  ensure
    I2CappSearch.define_singleton_method(:search_for_datasheets, original)
  end

  test "creates datasheet suggestions and marks the device scanned" do
    device = Device.create!(part_number: "NODS01", friendly_name: "needs a datasheet")
    pages = [ { title: "NODS01 datasheet", link: "https://example.com/nods01.pdf" } ]

    stub_datasheet_search(pages) do
      SuggestDatasheetsJob.perform_now
    end

    device.reload
    assert device.scanned, "expected the device to be marked scanned"
    suggestion = device.datasheet_suggestions.find_by(kind: "datasheet")
    assert_equal "NODS01 datasheet", suggestion.title
  end

  test "still marks the device scanned when the search returns nothing" do
    device = Device.create!(part_number: "NODS02", friendly_name: "no results")

    stub_datasheet_search(nil) do
      SuggestDatasheetsJob.perform_now
    end

    assert device.reload.scanned
    assert_equal 0, device.datasheet_suggestions.count
  end
end
