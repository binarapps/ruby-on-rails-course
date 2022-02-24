require 'rails_helper'

describe Comment, type: :model do

  context 'relations' do
    it 'belongs to user' do
      expect(Comment.reflect_on_association(:user).macro).to match(:belongs_to)
    end

    it 'belongs to post' do
      expect(Comment.reflect_on_association(:post).macro).to match(:belongs_to)
    end
  end

  context 'validations' do
    let(:user) { create(:user) }
    let(:post) { create(:post) }

    context 'with invalid params' do
      context 'when content is nil' do
        let(:content) { nil }

        it 'object is not valid' do
          expect(Comment.new(content: content, user: user, post: post)).not_to be_valid
        end
      end

      context 'when content is too long' do
        let(:content) { 'a'*141 }

        it 'object is not valid' do
          expect(Comment.new(content: content, user: user, post: post)).not_to be_valid
        end
      end
    end
  end
end
