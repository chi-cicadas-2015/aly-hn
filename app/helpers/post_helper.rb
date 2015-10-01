module PostHelper
  def find_post
    @post = Post.find(params[:id])
  end
end