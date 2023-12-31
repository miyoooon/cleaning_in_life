class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.page(params[:page]).per(5)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_user_path(@user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduce, :is_deleted)
  end

  def authenticate_admin!
    unless admin_signed_in?
      redirect_to root_path
    end
  end
  
end
