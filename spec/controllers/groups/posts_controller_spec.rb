require 'rails_helper'

RSpec.describe Groups::PostsController, type: :controller do
  describe 'Post#Сreate' do
    let!(:group) { create(:group) }
    let!(:user) { create(:user) }
    let(:new_post) { create(:post, body: "Something", postable: group, creator: user) }
    let(:invalid_post) { '' }

    it 'with valid parameters' do
      post :create, params: { group_id: group.id, post: new_post }
      expect(group.posts.last).to eq(new_post)
      expect(response).to have_http_status(:redirect)
    end

    it 'Post#create' do
      expect do
        post :create, params: { group_id: group.id, post: new_post }
      end.to change(Post, :count).by(1)
    end

    it 'Post#create with invalid parameters' do
      expect do
        post :create, params: { group_id: group.id, post: invalid_post }
      end.to change(Post, :count).by(0)
    end
  end
end
