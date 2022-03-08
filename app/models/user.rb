class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts

  has_one_attached :avatar

  validates :name, presence: true
  validates :name, format: /[A-Z][a-z]*/

  scope :created_today, -> { where("created_at > ?", Date.today.beginning_of_day) }
  scope :with_name, ->(name) { where("name LIKE ?", "#{name}%")}
end
