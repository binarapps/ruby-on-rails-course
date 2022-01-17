class PostPresenter < SimpleDelegator
  def parsed_title
    title.upcase
  end
end
