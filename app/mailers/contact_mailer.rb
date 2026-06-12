class ContactMailer < ApplicationMailer
  # Accepts either a Contact passed directly or serializable attributes via
  # `.with(...)`, so the mailer can be enqueued with `deliver_later` (ActiveJob
  # cannot serialize a plain ActiveModel object).
  def contact_email(contact = nil)
    @contact = contact || Contact.new(params.slice(:name, :email, :subject, :message))
    mail(
      to: "romkey+i2c-contact@romkey.com",
      reply_to: @contact.email,
      subject: @contact.subject.presence || "I2C Device Directory contact"
    )
  end
end
