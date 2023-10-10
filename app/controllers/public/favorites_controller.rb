class Public::FavoritesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: post.id)
    favorite.save
    redirect_to post, notice: "投稿にいいねをしました。"
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: post.id)
    favorite.destroy
    redirect_to post
  end

  def index
    user = User.find(params[:id])
    favorites = Favorite.where(user_id: user.id).pluck(:post_id)
    @favorite_posts = Post.where(id: favorites).page(params[:page]).per(5)
  end
end
