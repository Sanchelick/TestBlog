class UsersController < ApplicationController
  before_action :require_no_authentication, %i[new create]
  
  def new
    @user = User.new
  end

  def create
    @user = User.create user_params

    if @user.save
      flash[:success] = 'Пользователь зарегестрирован'
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  
end
