require 'rails_helper'

RSpec.describe Users::PostsController, type: :controller do
  let!(:user) { create(:user) }

  before { sign_in user }

  describe 'POST#create' do
    context 'when parameters is valid' do
      let(:valid_parameters) { attributes_for(:post).slice(:body) }

      it 'create new post' do
        post :create, params: { user_id: user.id, post: valid_parameters }
        expect(user.posts.last.body).to eq(valid_parameters[:body])
        expect(response).to have_http_status(:redirect)
      end

      it 'post was created' do
        expect do
          post :create, params: { user_id: user.id, post: valid_parameters }
        end.to change(Post, :count).by(1)
      end
    end

    context 'when parameters is invalid' do
      let(:invalid_parameters) { { body: 'aa' } }

      it 'does not create new post' do
        expect do
          post :create, params: { user_id: user.id, post: invalid_parameters }
        end.not_to change(Post, :count)
      end
    end
  end
end
