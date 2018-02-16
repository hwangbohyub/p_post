class PostsController < ApplicationController
  before_action :set_post, only: [:show,:edit,:update,:destroy]
  before_action :authenticate_user!, except: [:show,:index]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:alert] = "성공적으로 글을 작성했습니다!"
      redirect_to @post
    else
      flash[:alert] = "글을 작성하지 못했습니다"
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:alert] = "성공적으로 글을 수정했습니다!"
      redirect_to @post
    else
      flash[:alert] = "글을 수정하지 못했습니다"
      render :edit
    end
  end

  def destroy
    @post.destroy!

    redirect_to root_path
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end
  def post_params
    params.require(:post).permit(:title,:content,:user_id)
  end
end
