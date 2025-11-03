class SessionsController < ApplicationController
  before_action :require_no_authentication, only: %i[new create]
#  before_action :require_authentication, only: %i[destroy]
  
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    
    if user&.authenticate(params[:password])
      sing_in user
      remember(user) if params[:remember_me] == "1"
      redirect_to root_path
    else
      flash.now[:warning] = "Неправильная почта и/или пароль"
      render :new
    end
   
  end

  def destroy
    sing_out
    flash[:success] = "Вы вышли из системы"
    redirect_to root_path
  end
  
end
