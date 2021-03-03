require 'rails_helper'

RSpec.describe Users::PostsController, type: :controller do
  describe 'Post#Сreate' do
    let!(:user) { create(:user) }
    let!(:creator) { create(:user) }
    let(:new_post) { create(:post, body: "Something", postable: user, creator: creator) }
    let(:invalid_post) { '' }

    it 'with valid parameters' do
      post :create, params: { user_id: user.id, post: new_post }
      expect(user.posts.last).to eq(new_post)
      expect(response).to have_http_status(:redirect)
    end

    it 'Post#create' do
      expect do
        post :create, params: { user_id: user.id, post: new_post }
      end.to change(Post, :count).by(1)
    end

    it 'Post#create with invalid parameters' do
      expect do
        post :create, params: { user_id: user.id, post: invalid_post }
      end.to change(Post, :count).by(0)
    end
  end
end
