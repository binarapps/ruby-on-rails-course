class Posts::Recent
  RECENT_DAYS = 30

  def self.call
    recent_posts
  end

  private

  def self.recent_posts
    Post.where('updated_at > ?', Time.now - RECENT_DAYS.days)
  end
end
