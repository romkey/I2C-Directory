require "test_helper"
require "I2CappSearch/search_for_drivers"

class SuggestDriversJobTest < ActiveSupport::TestCase
  # Temporarily replaces I2CappSearch.search_for_drivers so the job never makes
  # a real network request, then restores the original implementation.
  def stub_driver_search(result)
    original = I2CappSearch.method(:search_for_drivers)
    I2CappSearch.define_singleton_method(:search_for_drivers) { |*| result }
    yield
  ensure
    I2CappSearch.define_singleton_method(:search_for_drivers, original)
  end

  test "creates driver suggestions and marks the device scanned_drivers" do
    device = Device.create!(part_number: "NODRV01", friendly_name: "needs a driver")
    pages = [ { title: "NODRV01 arduino library", link: "https://github.com/example/nodrv01" } ]

    stub_driver_search(pages) do
      SuggestDriversJob.perform_now
    end

    device.reload
    assert device.scanned_drivers, "expected the device to be marked scanned_drivers"
    suggestion = device.datasheet_suggestions.find_by(kind: "driver")
    assert_equal "NODRV01 arduino library", suggestion.title
  end
end
