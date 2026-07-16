require "test_helper"

class SuggestionMailerTest < ActionMailer::TestCase
  test "new_suggestion is addressed to the admin and mentions the device" do
    device = devices(:one)
    mail = SuggestionMailer.with(device: device).new_suggestion

    assert_equal "New I2Caddr suggestion", mail.subject
    assert_equal [ "romkey+i2caddr+suggestion@romkey.com" ], mail.to
    assert_equal [ "donotreply@i2cdevices.org" ], mail.from
    assert_match device.part_number, mail.body.encoded
  end
end
