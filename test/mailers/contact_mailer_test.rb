require "test_helper"

class ContactMailerTest < ActionMailer::TestCase
  test "contact_email sets reply_to to the sender and includes the message" do
    contact = Contact.new(name: "Sam", email: "sam@example.com", subject: "Question", message: "How does I2C work?")
    mail = ContactMailer.contact_email(contact)

    assert_equal [ "romkey+i2c-contact@romkey.com" ], mail.to
    assert_equal [ "sam@example.com" ], mail.reply_to
    assert_equal "Question", mail.subject
    assert_match "How does I2C work?", mail.body.encoded
  end

  test "contact_email falls back to a default subject when none is given" do
    contact = Contact.new(email: "sam@example.com", message: "Hello")
    mail = ContactMailer.contact_email(contact)

    assert_equal "I2C Device Directory contact", mail.subject
  end
end
