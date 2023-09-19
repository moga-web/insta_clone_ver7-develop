class PostsController < ApplicationController
  def index
    @posts =Post.with_attached_images.includes(:user).order(created_at: :desc)
  end
  
  def new
    @post = Post.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def delete
  end
end
