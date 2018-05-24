require "application_system_test_case"

class DevicesTest < ApplicationSystemTestCase
  setup do
    @device = devices(:one)
  end

  test "visiting the index" do
    visit devices_url
    assert_selector "h1", text: "Devices"
  end

  test "creating a Device" do
    visit devices_url
    click_on "New Device"

    fill_in "Adafruit", with: @device.adafruit
    fill_in "Addresses", with: @device.addresses
    fill_in "Amazon", with: @device.amazon
    fill_in "Datasheet", with: @device.datasheet
    fill_in "Friendly Name", with: @device.friendly_name
    fill_in "Part Number", with: @device.part_number
    fill_in "Sparkfun", with: @device.sparkfun
    click_on "Create Device"

    assert_text "Device was successfully created"
    click_on "Back"
  end

  test "updating a Device" do
    visit devices_url
    click_on "Edit", match: :first

    fill_in "Adafruit", with: @device.adafruit
    fill_in "Addresses", with: @device.addresses
    fill_in "Amazon", with: @device.amazon
    fill_in "Datasheet", with: @device.datasheet
    fill_in "Friendly Name", with: @device.friendly_name
    fill_in "Part Number", with: @device.part_number
    fill_in "Sparkfun", with: @device.sparkfun
    click_on "Update Device"

    assert_text "Device was successfully updated"
    click_on "Back"
  end

  test "destroying a Device" do
    visit devices_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Device was successfully destroyed"
  end
end
