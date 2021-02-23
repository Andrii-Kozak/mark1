require 'rails_helper'

RSpec.describe Groups::MembersController, type: :controller do
  let!(:group) { create(:group) }
  let!(:user) { create(:user) }

  context 'when user controller routes' do
    login_user
    it 'render members#index' do
      get :index, params: { group_id: group.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'when group controller routes' do
    it 'render members#create' do
      post :create, params: { group_id: group.id }
      expect(response).to have_http_status(:redirect)
    end

    it 'render members#destroy' do
      delete :destroy, params: { group_id: group.id, id: user.id }
      expect(response).to have_http_status(:redirect)
    end
  end

  describe 'POST#create' do
    context 'when user is logged in' do
      before do
        sign_in(user)
      end

      it 'follow to group' do
        expect { post :create, params: { group_id: group.id }, xhr: true }
          .to change(group.user_groups, :count).by(1)
      end
    end

    context 'when user is not logged in' do
      it 'follow to group' do
        post :create, params: { group_id: group.id }, xhr: true
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE#destroy' do
    context 'when user is logged in' do
      before do
        sign_in(user)
      end

      it 'unfollow to group' do
        group.user_groups.create(user_id: user.id)
        expect { delete :destroy, params: { group_id: group.id, id: user.id }, xhr: true }
          .to change(group.user_groups, :count).by(-1)
      end
    end

    context 'when user is not logged in' do
      it 'unfollow to group' do
        delete :destroy, params: { group_id: group.id, id: user.id }, xhr: true
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
