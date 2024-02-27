class Public::UsersController < ApplicationController
  before_action :authenticate_user_or_admin!
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).order(created_at: :desc)
  end

  def edit
    user = User.find(params[:id])
    @user = User.find(params[:id])
    unless user == current_user or current_admin
      redirect_to user_path(@user.id)
    end
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user_path(user.id)
  end

  def withdraw
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    if @user = current_user
      reset_session
      redirect_to  root_path
    else @user = current_admin
      redirect_to admin_users_path
    end
  end

  private

  def user_params
  params.require(:user).permit(:name, :introduce)
  end

  def authenticate_user_or_admin!
    unless user_signed_in? || admin_signed_in?
      redirect_to root_path
    end
  end

end
