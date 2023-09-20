class PostsController < ApplicationController
  def index
    @posts =Post.with_attached_images.includes(:user).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      #show.html.erbにリダイレクト
      redirect_to post_path（@post）, success: '投稿しました'
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end

  def update
  end

  def delete
  end

  private
  def post_params
    params.require(:post).permit(:body, images:[])
  end
end
