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
    Comment.create(post_id: post.id, user_id: post.user_id, content: 'Generyczny komentarz')
  end
end
