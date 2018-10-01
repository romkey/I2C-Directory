class SuggestionMailer < ApplicationMailer
  default from: 'donotreply@i2cdevices.org'

  def new_suggestion
    @device = params[:device]
    mail(to: 'romkey+i2caddr+suggestion@romkey.com', subject: 'New I2Caddr suggestion')
  end
end
