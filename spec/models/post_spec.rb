require 'rails_helper'

describe Post, type: :model do

  context 'relations' do
    it 'belongs to user' do
      expect(Post.reflect_on_association(:user).macro).to match(:belongs_to)
    end

    it 'has many comments' do
      expect(Post.reflect_on_association(:comments).macro).to match(:has_many)
    end
  end

  context 'validations' do
    let(:user) { create(:user) }

    it 'not valid without title' do
      expect(Post.new(title: nil, body: 'body', user: user)).not_to be_valid
    end

    it 'not valid without body' do
      expect(Post.new(title: 'title', body: nil, user: user)).not_to be_valid
    end

    it 'valid with title and body' do
      expect(Post.new(title: 'title', body: 'body', user: user)).to be_valid
    end
  end

  describe '#capitalized_title' do
    let(:post) { create(:post, title: 'to be capitalized') }
    subject { post.capitalized_title }

    it 'returns capitalized title' do
      expect(subject).to eq('To be capitalized')
    end
  end

  describe '.titles' do
    let!(:post_1) { create(:post) }
    let!(:post_2) { create(:post) }
    subject { Post.titles }

    it 'returns array of titles' do
      expect(subject).to match_array([post_1.title, post_2.title])
    end
  end
end
