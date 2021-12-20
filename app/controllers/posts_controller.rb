class PostsController < ApplicationController
  def index
    @posts = Post.all
    @message = 'Cześć'
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def show
    @param = params[:custom_param]
  end

  def destroy
  end
end
