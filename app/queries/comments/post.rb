class Comments::Post
  def initialize(post_id)
    @post_id = post_id
  end

  def call
    comments
  end

  private

  def comments
    Comment.where(post_id: @post_id)
  end
end
