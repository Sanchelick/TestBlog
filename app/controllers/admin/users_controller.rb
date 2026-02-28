class Admin::UsersController < ApplicationController
  include ZipLoader
  
  before_action :require_authentication
  before_action :set_user!, only: %i[edit update destroy]
  before_action :user_is_admin?
  
  def index
    @pagy, @users = pagy User.order(created_at: :desc)
    respond_to do |format|
      format.html do
        @users
      end
      format.zip do 
        respond_with_zipped(@users)
      end
    end
  end


  def edit
  end

  def update
    if @user.update user_params
      flash[:success] = "Пользователь обновлён"
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "Пользователь удалён"
    redirect_to admin_users_path
  end

  private

  def set_user!
    @user = User.find params[:format]
  end

  def user_params
    params.require(:user).premit(:name, :email, :password, :password_confirmation, :role
                                ).merge(admin_edit: true)
  end
    
end
