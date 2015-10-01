class CommentsController < ApplicationController
  include ApplicationHelper

  before_filter :authorize, :only => [:create, :new]

  def index
    @user = User.find(params[:user_id])
    @comments = @user.comments
  end

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)

    if @comment.save
      @post.comments << @comment
      current_user.comments << @comment
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text)
  end
end
