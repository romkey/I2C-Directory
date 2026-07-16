require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "is valid with an email and password" do
    user = User.new(email: "new@example.com", password: "password123")
    assert user.valid?
  end

  test "requires an email" do
    user = User.new(password: "password123")
    assert_not user.valid?
    assert_includes user.errors.attribute_names, :email
  end

  test "requires a password" do
    user = User.new(email: "nopass@example.com")
    assert_not user.valid?
    assert_includes user.errors.attribute_names, :password
  end

  test "rejects duplicate emails" do
    User.create!(email: "dupe@example.com", password: "password123")
    duplicate = User.new(email: "dupe@example.com", password: "password123")
    assert_not duplicate.valid?
  end

  test "authenticates the fixture user with the known password" do
    assert users(:admin).valid_password?("password123")
  end
end
