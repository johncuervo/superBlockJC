class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :is_user?, except: [:index, :show, :new, :create]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to posts_path, notice: 'Post creado correctamente.'
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path, notice: 'Post editado correctamente.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: 'Post eliminado correctamente.'
  end

private

  def set_post
    @post = Post.find(params[:id])
  end

  def is_user?
    @post = Post.find(params[:id])
    unless current_user.id == @post.user_id
      flash[:alert] = "No tienes permiso"
      redirect_to posts_path
    end
  end

  def post_params
    params.require(:post).permit(:title, :content, :user_id)
  end

end
