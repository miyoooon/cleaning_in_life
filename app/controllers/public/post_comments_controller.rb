class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user_or_admin!
  def create
    @post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = @post.id
    if comment.save
      redirect_to post_path(@post)
    else
      @post = Post.find(params[:post_id])
      @post_comment = PostComment.new
      render 'public/posts/show'
    end
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = PostComment.find(params[:id])
    unless @comment.user == current_user or current_admin
      redirect_to post_path(@post.id)
    end
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = PostComment.find(params[:id])
    if @comment.update(post_comment_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    @comment = PostComment.find(params[:id])
    @comment.destroy
    redirect_to post_path(post)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

  def authenticate_user_or_admin!
    unless user_signed_in? || admin_signed_in?
      redirect_to root_path
    end
  end

end
