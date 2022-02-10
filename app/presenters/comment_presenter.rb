class CommentPresenter < SimpleDelegator
  def parsed_content
    content.capitalize
  end
end
