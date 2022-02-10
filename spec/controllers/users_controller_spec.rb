require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET #index' do
    it 'shows all the users' do
      get :index
      expect(assigns(:users).to_a).to eq(User.all.to_a)
    end
  end

  describe 'POST #create' do
    subject { post :create, params: params }

    context 'valid params' do
      let(:params) { { user: { name: 'Name' } } }

      it 'creates user' do
        expect{subject}.to change{ User.count }.by(1)
      end
    end

    context 'invalid params' do
      let(:params) { { user: { name: nil } } }

      it 'doesnt create user' do
        expect{subject}.not_to change{ User.count }
      end
    end
  end
end
