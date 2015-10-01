class PostsController < ApplicationController
  include ApplicationHelper
  include PostHelper

  before_filter :authorize, :only => [:create, :new, :edit, :update]
  before_filter :find_post, :only => [:show, :edit, :update]
  before_filter(only: [:edit, :update]) { allowed?(@post) }

  def index
    @posts = Post.order("created_at desc")
  end

  def show
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      current_user.posts << @post
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit
    if request.xhr?
      render :edit, layout: false
    else
      render :edit
    end
  end

  def update
    if @post.update_attributes(post_params)
      if request.xhr?
        render json: @post, include: :tags
      else
        redirect_to post_path(@post)
      end
    else
      if request.xhr?
        render :edit, layout: false
      else
        render :edit
      end
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :all_tags)
  end
end
