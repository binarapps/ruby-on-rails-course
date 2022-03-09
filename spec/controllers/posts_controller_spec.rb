require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'GET #index' do
    let(:post_1) { create(:post) }
    let(:post_2) { create(:post) }
    let(:user) { create(:user) }
    before { allow(Posts::Sort).to receive_message_chain(:new, :call).and_return(Post.where(id: [post_1.id, post_2.id])) }

    subject { get :index }

    it 'shows recent posts' do
      subject
      expect(assigns(:posts).to_a).to eq([post_1, post_2])
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }
    subject { post :create, params: params }

    context 'when user is not authorized' do
      context 'valid params' do
        let(:params) { { post: { title: 'Title', body: 'Body', user_id: user.id } } }

        it 'creates post' do
          expect{ subject }.to change{ Post.count }.by(0)
        end
      end
    end

    context 'when user is authorized' do
      before { sign_in user }

      context 'valid params' do
        let(:params) { { post: { title: 'Title', body: 'Body', user_id: user.id } } }

        it 'creates post' do
          expect{ subject }.to change{ Post.count }.by(1)
        end

        it 'redirects properly' do
          expect(subject).to redirect_to(posts_path)
        end
      end

      context 'invalid params' do
        let(:params) { { post: { title: nil, body: 'Body', user_id: user.id } } }

        it 'doesnt create post' do
          expect{ subject }.not_to change{ Post.count }
        end

        it 'renders new' do
          expect(subject).to render_template(:new)
        end
      end
    end
  end

  describe 'GET #new' do
    subject { get :new }

    it 'initializes empty post' do
      subject
      expect(assigns(:post).attributes).to eq(Post.new.attributes)
    end
  end

  describe 'GET #edit' do
    let(:post) { create(:post) }
    subject { get :edit, params: { id: post.id } }

    it 'assigns proper post object' do
      subject
      expect(assigns(:post)).to eq(post)
    end
  end

  describe 'GET #show' do
    let(:post_1) { create(:post) }
    let(:post_2) { create(:post) }
    let!(:comment_1) { create(:comment, post: post_1, updated_at: 5.minutes.ago) }
    let!(:comment_2) { create(:comment, post: post_1, updated_at: 1.minute.ago) }
    let!(:comment_3) { create(:comment, post: post_2) }
    subject { get :show, params: { id: post_1.id } }

    it 'assigns proper post object' do
      subject
      expect(assigns(:post)).to eq(post_1)
    end

    it 'assigns proper comment objects' do
      subject
      expect(assigns(:comments)).to eq([comment_1, comment_2])
    end
  end

  describe 'PUT #update' do
    let(:post) { create(:post) }
    subject { put :update, params: params }

    context 'valid params' do
      let(:params) { { id: post.id, post: { title: 'New Title' } } }

      it 'updates post' do
        expect{ subject }.to change{ post.reload.title }.to('New Title')
      end
    end

    context 'invalid params' do
      let(:params) { { id: post.id, post: { title: nil } } }

      it 'doesnt update post' do
        expect{ subject }.not_to change{ post.reload.title }
      end

      it 'renders edit' do
        expect(subject).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:post) { create(:post) }
    subject { delete :destroy, params: { id: post.id } }

    it 'destroys post' do
      expect{ subject }.to change{ Post.count }.by(-1)
    end

    it 'redirects properly' do
      expect(subject).to redirect_to(posts_path)
    end

    it 'shows flash' do
      subject
      expect(flash[:notice]).to be_present
    end
  end
end
