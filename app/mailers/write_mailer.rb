class WriteMailer < ApplicationMailer
  def finish_writing user, lesson
    @user = user
    @lesson = lesson
    mail to: user.email, subject: t(".finish_writing")
  end
end
