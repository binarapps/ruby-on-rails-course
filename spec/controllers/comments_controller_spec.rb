require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe 'GET #index' do
    let!(:comment_1) { create(:comment) }
    let!(:comment_2) { create(:comment) }
    let(:user) { create(:user) }
    subject { get :index }

    it 'shows all comments' do
      subject
      expect(assigns(:comments).to_a).to match_array([comment_1, comment_2])
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:post_obj) { create(:post) }
    subject { post :create, params: params }

    context 'when user is not authorized' do
      context 'valid params' do
        let(:params) { { comment: { content: 'Content', post_id: post_obj.id, user_id: user.id } } }

        it 'creates comment' do
          expect{ subject }.to change{ Comment.count }.by(0)
        end
      end
    end

    context 'when user is authorized' do
      before { sign_in user }

      context 'valid params' do
        let(:params) { { comment: { content: 'Content', post_id: post_obj.id, user_id: user.id } } }

        it 'creates comment' do
          expect{ subject }.to change{ Comment.count }.by(1)
        end

        it 'redirects properly' do
          expect(subject).to redirect_to(comments_path)
        end
      end

      context 'invalid params' do
        let(:params) { { comment: { content: nil, post_id: post_obj.id, user_id: user.id } } }

        it 'doesnt create comment' do
          expect{ subject }.not_to change{ Comment.count }
        end

        it 'renders new' do
          expect(subject).to render_template(:new)
        end
      end
    end
  end

  describe 'GET #new' do
    subject { get :new }

    it 'initializes empty comment' do
      subject
      expect(assigns(:comment).attributes).to eq(Comment.new.attributes)
    end
  end

  describe 'GET #edit' do
    let!(:comment) { create(:comment) }
    subject { get :edit, params: { id: comment.id } }

    it 'assigns proper comment object' do
      subject
      expect(assigns(:comment)).to eq(comment)
    end
  end

  describe 'GET #show' do
    let!(:comment) { create(:comment) }
    subject { get :show, params: { id: comment.id } }

    it 'assigns proper comment object' do
      subject
      expect(assigns(:comment)).to eq(comment)
    end
  end

  describe 'PUT #update' do
    let!(:comment) { create(:comment) }
    subject { put :update, params: params }

    context 'valid params' do
      let(:params) { { id: comment.id, comment: { content: 'New Content' } } }

      it 'updates comment' do
        expect{ subject }.to change{ comment.reload.content }.to('New Content')
      end
    end

    context 'invalid params' do
      let(:params) { { id: comment.id, comment: { content: nil } } }

      it 'doesnt update comment' do
        expect{ subject }.not_to change{ comment.reload.content }
      end

      it 'renders edit' do
        expect(subject).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:comment) { create(:comment) }
    subject { delete :destroy, params: { id: comment.id } }

    it 'destroys comment' do
      expect{ subject }.to change{ Comment.count }.by(-1)
    end

    it 'redirects properly' do
      expect(subject).to redirect_to(comments_path)
    end

    it 'shows flash' do
      subject
      expect(flash[:notice]).to be_present
    end
  end
end
