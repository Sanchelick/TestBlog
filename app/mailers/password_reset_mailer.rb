class PasswordResetMailer < ApplicationMailer
  def reset_email
    @user = params[:user]
    mail to: @user.email, subject: t('.subject')
  end
end
