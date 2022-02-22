require 'rails_helper'

describe Posts::Recent do
  describe '.call' do
    let!(:post_1) { create(:post, updated_at: 31.days.ago) }
    subject { described_class.call }

    context 'without recent posts present' do
      it 'returns empty collection' do
        expect(subject).to eq([])
      end
    end

    context 'with recent posts present' do
      let!(:post_2) { create(:post, updated_at: 1.minutes.ago) }
      let!(:post_3) { create(:post, updated_at: 5.minutes.ago) }

      it 'returns posts collection' do
        expect(subject).to match_array([post_2, post_3])
      end
    end
  end
end
