class PostsController < ApplicationController
  before_action :authenticate_user!, only: :create

  def index
    @posts = Posts::Sort.new(Posts::Recent.call).call.page(params[:page])
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    Posts::Create.new(post_params.merge(user: current_user)).call
    redirect_to posts_path
  rescue ActiveRecord::RecordInvalid => invalid
    @post = invalid.record
    render :new
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path
    else
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = Comments::Sort.new(Comments::Post.new(@post.id).call).call
  end

  def destroy
    @post = Post.find(params[:id])
    if Posts::Destroy.new(@post).call
      flash[:notice] = 'Post has been destroyed'
      redirect_to posts_path
    else
      flash[:alert] = 'Something went wrong'
      redirect_to posts_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id, :image)
  end
end
