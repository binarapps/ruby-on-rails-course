class Posts::Create
  def initialize(params)
    @params = params
  end

  def call
    create_post_with_comment
  end

  private

  def create_post_with_comment
    post = Post.create!(@params)
    WellcomeCommentCreationJob.perform_later(post.id)
  end
end
