class WellcomeCommentCreationJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    sleep(60)
    post = Post.find(post_id)
    Comment.create(post_id: post.id, user_id: post.user_id, content: 'Hello post')
  end
end
