class Comments::Sort
  def initialize(comments)
    @comments = comments
  end

  def call
    sort
  end

  private

  def sort
    @comments.order(:updated_at)
  end
end
