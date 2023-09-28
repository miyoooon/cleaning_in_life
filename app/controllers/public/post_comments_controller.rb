class Public::PostCommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = post.id
    comment.save!
    redirect_to post_path(post)
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = PostComment.find(params[:id])
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

end
