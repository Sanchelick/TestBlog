class PasswordResetMailer < ApplicationMailer
  def reset_email
    @user = params[:user]
    @token = @user.generate_token_for(:password_reset)
    mail to: @user.email, subject: t('.subject')
  end
end
