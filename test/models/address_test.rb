require "test_helper"

class AddressTest < ActiveSupport::TestCase
  test "to_s formats the address as a two-digit hex string" do
    assert_equal "0x68", addresses(:one).to_s
    assert_equal "0x1c", addresses(:two).to_s
  end

  test "generates a slug from the hex representation when none is given" do
    address = Address.create!(address: 0x42)
    assert_equal "0x42", address.slug
  end

  test "to_param returns the slug" do
    assert_equal addresses(:one).slug, addresses(:one).to_param
  end

  test "can be associated with devices" do
    address = addresses(:one)
    address.device << devices(:one)

    assert_includes address.device, devices(:one)
    assert_includes devices(:one).address, address
  end
end
