require 'rails_helper'

RSpec.describe Groups::PostsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:group) { create(:group) }

  before { sign_in user }

  describe 'Post#Сreate' do
    context 'when parameters is valid' do
      let(:valid_parameters) { { body: 'Something' } }

      it 'create new post' do
        post :create, params: { group_id: group.id, post: valid_parameters }
        expect(group.posts.last.body).to eq(valid_parameters[:body])
        expect(response).to have_http_status(:redirect)
      end

      it 'post was created' do
        expect do
          post :create, params: { group_id: group.id, post: valid_parameters }
        end.to change(Post, :count).by(1)
      end
    end

    context 'when parameters is invalid' do
      let(:invalid_parameters) { { body: 'aa' } }

      it 'does not create new post' do
        expect do
          post :create, params: { group_id: group.id, post: invalid_parameters }
        end.to change(Post, :count).by(0)
      end
    end
  end
end
