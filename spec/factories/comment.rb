FactoryBot.define do
  factory :comment do
    content { 'Lorem ipsum' }
    user { create(:user) }
    post { create(:post) }
  end
end
