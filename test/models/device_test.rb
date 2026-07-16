require "test_helper"

class DeviceTest < ActiveSupport::TestCase
  setup do
    @device = devices(:one)
  end

  test "generates a slug from the part number when none is given" do
    device = Device.create!(part_number: "TMP117 Sensor!", friendly_name: "Temp sensor")
    assert_equal "tmp117-sensor", device.slug
  end

  test "keeps an explicitly provided slug" do
    device = Device.create!(part_number: "ABC", friendly_name: "thing", slug: "custom-slug")
    assert_equal "custom-slug", device.slug
  end

  test "to_param returns the slug" do
    assert_equal @device.slug, @device.to_param
  end

  test "to_amazon_link includes the part number" do
    assert_includes @device.to_amazon_link, @device.part_number
  end

  test "published scope excludes suggestions" do
    assert_includes Device.published, devices(:one)
    assert_not_includes Device.published, devices(:two)
  end

  test "suggestions scope only includes suggestions" do
    assert_includes Device.suggestions, devices(:two)
    assert_not_includes Device.suggestions, devices(:one)
  end

  test "needs_datasheet scope finds devices without a datasheet" do
    assert_includes Device.needs_datasheet, devices(:two)
    assert_not_includes Device.needs_datasheet, devices(:one)
  end

  test "needs_drivers scope finds devices with no drivers" do
    assert_includes Device.needs_drivers, devices(:two)
  end

  test "as_json omits internal fields and includes addresses" do
    address = addresses(:one)
    @device.address << address

    json = @device.as_json

    assert_equal [ address.address ], json[:addresses]
    %w[id slug attribution created_at updated_at suggestion views scanned].each do |field|
      assert_not json.key?(field), "expected as_json to omit #{field}"
    end
    assert_equal @device.part_number, json["part_number"]
  end

  test "as_json drops blank values" do
    device = Device.create!(part_number: "EMPTY1", friendly_name: "x", datasheet: "")
    assert_not device.as_json.key?("datasheet")
  end

  test "import creates a device per CSV row and returns the count" do
    csv = File.open(Rails.root.join("test/fixtures/files/devices.csv"))

    assert_difference "Device.count", 1 do
      @count = Device.import(csv)
    end

    assert_equal 1, @count
    assert Device.exists?(part_number: "BMP280")
  end
end
