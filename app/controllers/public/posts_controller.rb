class Public::PostsController < ApplicationController

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
  if params[:word].present?
    @posts = Post.where("title LIKE ? OR text LIKE ?", "%#{params[:word]}%", "%#{params[:word]}%").page(params[:page])
  else
    @posts = Post.page(params[:page])
  end
  if params[:tag_id].present?
    @posts = @posts.joins(:tags).where(tags: { id: params[:tag_id] })
  end
end

def show
  @post = Post.find(params[:id])
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
  params.require(:post).permit(:title, :text)
end

end
