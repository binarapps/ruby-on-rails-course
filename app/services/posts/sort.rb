class Posts::Sort
  def initialize(posts)
    @posts = posts
  end

  def call
    sort
  end

  private

  def sort
    @posts.order(:updated_at)
  end
end
