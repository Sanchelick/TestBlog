class UsersController < ApplicationController
  before_action :require_no_authentication, only: %i[new create]
  before_action :require_authentication, only: %i[edit update]
  before_action :set_user!, only: %i[edit update]
  
  def new
    @user = User.new
  end

  def create
    @user = User.create user_params

    if @user.save
      flash[:success] = t('.success')
      redirect_to root_path
    else
      flash.now[:danger] = t('.danger')
      render :new
    end
  end

  def edit
  end

  def update

    if @user.update(user_params)
      flash[:success] = t('.success')
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :old_password)
  end

  def set_user!
    @user = User.find(params[:id]).decorate
  end

  
end

