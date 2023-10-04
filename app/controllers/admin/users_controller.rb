class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.page(params[:page]).per(5)
  end

  def show
  end

  def edit
  end
end
