require 'test_helper'

class DevicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @device = devices(:one)
  end

  test "should get index" do
    get devices_url
    assert_response :success
  end

  test "should get new" do
    get new_device_url
    assert_redirected_to new_user_session_url
#    assert_response :success
  end

  test "should create device" do
    assert_difference('Device.count') do
      post devices_url, params: { device: { adafruit: @device.adafruit, amazon: @device.amazon, datasheet: @device.datasheet, friendly_name: @device.friendly_name, part_number: @device.part_number, sparkfun: @device.sparkfun, slug: @device.slug, obsolete: @device.obsolete, suggestion: @device.suggestion, is_5v: @device.is_5v, is_3v: @device.is_3v, is_standard_speed: @device.is_standard_speed, is_full_speed: @device.is_full_speed, is_high_speed: @device.is_high_speed, is_ultra_fast_speed: @device.is_ultra_fast_speed, is_spi: @device.is_spi, release_date: @device.release_date, scanned_drivers: @device.scanned_drivers, views: @device.views } }
    end

    assert_redirected_to device_url(Device.last)
  end

  test "should show device" do
    get device_url(@device)
    assert_response :success
  end

  test "should get edit" do
    get edit_device_url(@device)
    assert_redirected_to new_user_session_url
#    assert_response :success
  end

  test "should update device" do
    patch device_url(@device), params: { device: { adafruit: @device.adafruit, amazon: @device.amazon, datasheet: @device.datasheet, friendly_name: @device.friendly_name, part_number: @device.part_number, sparkfun: @device.sparkfun, slug: @device.slug, obsolete: @device.obsolete, suggestion: @device.suggestion, is_5v: @device.is_5v, is_3v: @device.is_3v, is_standard_speed: @device.is_standard_speed, is_full_speed: @device.is_full_speed, is_high_speed: @device.is_high_speed, is_ultra_fast_speed: @device.is_ultra_fast_speed, is_spi: @device.is_spi, release_date: @device.release_date, scanned_drivers: @device.scanned_drivers, views: @device.views } }
    assert_redirected_to new_user_session_url
#    assert_redirected_to device_url(@device)
  end

  test "should destroy device" do
    assert_difference('Device.count', 0) do
#    assert_difference('Device.count', -1) do
      delete device_url(@device)
    end

    assert_redirected_to new_user_session_url
#    assert_redirected_to devices_url
  end
end
