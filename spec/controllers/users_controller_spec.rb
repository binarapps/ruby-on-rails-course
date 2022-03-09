require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET #index' do
    subject { get :index }

    it 'shows all the users' do
      subject
      expect(assigns(:users).to_a).to eq(User.all.to_a)
    end
  end

  describe 'POST #create' do
    subject { post :create, params: params }

    context 'valid params' do
      let(:params) { { user: { name: 'Name', email: 'valid@email.com', password: "somepassword" } } }

      it 'creates user' do
        expect{ subject }.to change{ User.count }.by(1)
      end

      it 'redirects properly' do
        expect(subject).to redirect_to(users_path)
      end
    end

    context 'invalid params' do
      let(:params) { { user: { name: nil, email: 'valid@email.com', password: "somepassword" } } }

      it 'doesnt create user' do
        expect{ subject }.not_to change{ User.count }
      end

      it 'renders new' do
        expect(subject).to render_template(:new)
      end
    end
  end

  describe 'GET #new' do
    subject { get :new }

    it 'initializes empty user' do
      subject
      expect(assigns(:user).attributes).to eq(User.new.attributes)
    end
  end

  describe 'GET #edit' do
    let!(:user) { create(:user) }
    subject { get :edit, params: { id: user.id } }

    it 'assigns proper user object' do
      subject
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'GET #show' do
    let!(:user) { create(:user) }
    subject { get :show, params: { id: user.id } }

    it 'assigns proper user object' do
      subject
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'PUT #update' do
    let!(:user) { create(:user) }
    subject { put :update, params: params }

    context 'valid params' do
      let(:params) { { id: user.id, user: { name: 'Name' } } }

      it 'updates user' do
        expect{ subject }.to change{ user.reload.name }.to('Name')
      end
    end

    context 'invalid params' do
      let(:params) { { id: user.id, user: { name: nil } } }

      it 'doesnt update user' do
        expect{ subject }.not_to change{ user.reload.name }
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { create(:user) }
    subject { delete :destroy, params: { id: user.id } }

    it 'destroys user' do
      expect{ subject }.to change{ User.count }.by(-1)
    end

    it 'redirects properly' do
      expect(subject).to redirect_to(users_path)
    end

    it 'shows flash' do
      subject
      expect(flash[:notice]).to be_present
    end
  end
end
