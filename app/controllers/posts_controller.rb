class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
    
  def index
    @posts = Post.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find_by_id(params[:id])
      return render_not_found if @post.blank?
  end

  def edit
    @post = Post.find_by_id(params[:id])
      return render_not_found if @post.blank?
  end

  def update
    @post = Post.update_attributes(post_params)
  end

  def create
    @post = current_user.posts.create(post_params)
    if @post.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :message)
  end

  def render_not_found
    render text: 'Not found', status: :not_found
  end
end
