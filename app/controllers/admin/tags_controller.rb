class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to admin_tags_path
    else
      render :new
    end
  end

  def index
    @tags = Tag.page(params[:page]).per(10)
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      redirect_to admin_tags_path
    else
      render :edit
    end
  end

  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    redirect_to admin_tags_path
  end

private

  def tag_params
   params.require(:tag).permit(:name)
  end

  def authenticate_admin!
    unless admin_signed_in?
      redirect_to root_path
    end
  end

end
