FactoryBot.define do
  factory :post do
    title { 'Post title' }
    body { 'Lorem ipsum' }
    user { create(:user) }
  end
end
