class PostsController < ApplicationController
  include ApplicationHelper

  before_filter :authorize, :only => [:create, :new]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      current_user.posts << @post
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
