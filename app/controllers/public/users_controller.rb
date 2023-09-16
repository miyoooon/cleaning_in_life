class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
  end

  def edit
    user = User.find(params[:id])
    @user = User.find(params[:id])
    unless user.id == current_user.id
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
    reset_session
    redirect_to  new_user_registration_path
  end

  private
  def user_params
  params.require(:user).permit(:name, :introduce)
  end

end
