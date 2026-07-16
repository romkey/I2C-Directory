require "test_helper"

class ContactTest < ActiveSupport::TestCase
  test "is valid with an email and message" do
    contact = Contact.new(email: "person@example.com", message: "Hello there")
    assert contact.valid?
  end

  test "requires an email" do
    contact = Contact.new(message: "Hello")
    assert_not contact.valid?
    assert_includes contact.errors.attribute_names, :email
  end

  test "requires a well-formed email" do
    contact = Contact.new(email: "not-an-email", message: "Hello")
    assert_not contact.valid?
    assert_includes contact.errors.attribute_names, :email
  end

  test "requires a message" do
    contact = Contact.new(email: "person@example.com")
    assert_not contact.valid?
    assert_includes contact.errors.attribute_names, :message
  end
end
