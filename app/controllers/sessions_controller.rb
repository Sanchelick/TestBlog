class SessionsController < ApplicationController
  before_action :require_no_authentication, only: %i[new create]
  before_action :require_authentication, only: %i[destroy]
  
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    
    if @user&.authenticate(params[:password])
      sign_in @user
      remember(@user) if params[:remember_me] == "1"
      respond_to do |format|
        format.html { redirect_to root_path }
      end
    else
      flash[:warning] = "Неправильная почта и/или пароль"
      respond_to do |format|
        format.html { render :new }
      end
    end
    
  end

  def destroy
    sign_out
    flash[:success] = "Вы вышли из системы"
    redirect_to root_path
  end
  
end
