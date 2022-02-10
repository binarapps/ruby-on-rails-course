class Posts::Destroy
  def initialize(post)
    @post = post
  end

  def call
    destroy_post_with_comment
  end

  private

  def destroy_post_with_comment
    @post.comments.delete_all
    @post.destroy
  end
end
