require 'rails_helper'

RSpec.describe Groups::MembersController, type: :controller do
  let!(:group) { create(:group) }
  let!(:user) { create(:user) }

  describe 'GET#index' do
    login_user
    it 'render members' do
      get :index, params: { group_id: group.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET#create' do
    it 'do the follow to the group' do
      post :create, params: { group_id: group.id }
      expect(response).to have_http_status(:redirect)
    end
  end

  describe 'DELETE#destroy' do
    it 'render members#destroy' do
      delete :destroy, params: { group_id: group.id, id: user.id }
      expect(response).to have_http_status(:redirect)
    end
  end

  describe 'follow POST#create' do
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

  describe 'unfollow DELETE#destroy' do
    context 'when user is logged in' do
      before do
        sign_in(user)
      end

      it 'unfollow from group' do
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

  describe 'when remove_member' do
    let!(:user_remove) { create(:user) }

    login_admin

    it 'remove user from group' do
      group.user_groups.create(user: user_remove)
      expect { delete :remove_member, params: { group_id: group.id, member_id: user_remove.id } }
        .to change(group.user_groups, :count).by(-1)
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(group_members_path)
    end
  end
end
