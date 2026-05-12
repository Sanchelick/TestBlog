
class PasswordResetsController < ApplicationController
  before_action :require_no_authentication
  before_action :set_user, only: %i[edit update]
  
  def create
    @user = User.find_by(email: params[:email])
    
    if @user.present?
      PasswordResetMailer.with(user: @user).reset_email.deliver_now
    end
    
    flash[:success] = t('.success')

    redirect_to new_session_path
  end

  def edit
  end

  def update
    if @user.update user_params
      flash[:success] = t('.success')
      redirect_to new_session_path
    else
      render :edit
    end
  end

  def set_user
    @user = User.find_by_token_for(:password_reset, params[:token])

    redirect_to(new_session_path, flash: {warning: t('.fail')}) unless @user
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation).merge(admin_edit: true)
  end
    
end
