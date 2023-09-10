class Public::PostsController < ApplicationController

def new
  @post = Post.new
end

def create
  @post = Post.new(posts_params)
end

def index
end

def show
end

def edit
end

def update
end

def destroy
end

private

def posts_params
  params.require(:post).permit(:title, :text)
end

end
