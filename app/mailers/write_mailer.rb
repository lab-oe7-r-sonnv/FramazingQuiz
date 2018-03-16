class WriteMailer < ApplicationMailer
  def finish_writing user
    @user = user
    mail to: user.email, subject: t(".finish_writing")
  end
end
