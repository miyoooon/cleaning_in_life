class Public::PostsController < ApplicationController
  before_action :authenticate_user_or_admin!, except: :index

def new
  @post = Post.new
end

def create
  @post = Post.new(post_params)
  @post.user_id = current_user.id
  if @post.save
    redirect_to posts_path
  else
    render :new
  end
end

def index
  @post_comment = PostComment.new
  if params[:word].present?
    @posts = Post.where("title LIKE ? OR text LIKE ?", "%#{params[:word]}%", "%#{params[:word]}%").page(params[:page])
  else
    @posts = Post.page(params[:page])
  end
  if params[:tag_id].present?
    @posts = @posts.joins(:tag).where(tags: { id: params[:tag_id] })
  end
end

def show
  @post = Post.find(params[:id])
  @post_comment = PostComment.new
end

def edit
  @post = Post.find(params[:id])
  unless @post.user == current_user or current_admin
      redirect_to post_path(@post.id)
  end
end

def update
  @post = Post.find(params[:id])
  @post.update(post_params)
  redirect_to post_path(@post.id)
end

def destroy
  @post = Post.find(params[:id])
  @post.destroy
  redirect_to posts_path
end

private

def post_params
  params.require(:post).permit(:title, :text, :tag_id)
end

def authenticate_user_or_admin!
    unless user_signed_in? || admin_signed_in?
      redirect_to root_path
    end
end

end
