require 'rails_helper'

describe Posts::Sort do
  describe '#call' do
    subject { described_class.new(posts).call }

    context 'without posts provided' do
      let(:posts) { Post.all }

      it 'returns empty collection' do
        expect(subject).to eq([])
      end
    end

    context 'with posts provided' do
      let(:post_1) { create(:post, updated_at: Time.zone.now - 1.minutes) }
      let(:post_2) { create(:post, updated_at: Time.zone.now - 5.minute) }
      let(:posts) { Post.all }

      it 'returns posts collection ordered by updated at' do
        expect(subject).to eq([post_2, post_1])
      end
    end
  end
end
