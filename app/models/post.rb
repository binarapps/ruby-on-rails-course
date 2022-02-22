class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates :title, :body, presence: true

  def capitalized_title
    title.capitalize
  end

  def self.titles
    Post.all.pluck(:title)
  end
end
