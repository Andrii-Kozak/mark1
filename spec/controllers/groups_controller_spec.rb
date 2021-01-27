require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  let!(:group) { create(:group) }
  let!(:valid_params) { attributes_for(:group) }
  let!(:invalid_params) { { group_name: '' } }

  login_admin

  describe 'GET#index' do
    it 'assigns group and renders template' do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template('index')
    end
  end

  describe 'GET#show' do
    it 'returns success and assigns group' do
      get :show, params: { id: group.id }
      expect(response).to have_http_status(:success)
      expect(assigns(:group)).to eq(group)
    end

    context 'with invalid params' do
      it 'returns error and assigns group' do
        get :show, params: { id: Group.last.id + 1 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'GET#new' do
    it 'returns success and assigns group' do
      get :new
      expect(response).to have_http_status(:success)
      expect(assigns(:group)).to be_a_new(Group)
    end
  end

  describe 'POST#create' do
    context 'with valid params' do
      it 'creates a new group' do
        expect do
          post :create, params: { group: valid_params }
        end.to change(Group, :count).by(1)
      end

      it 'redirects to the created group' do
        post :create, params: { group: valid_params }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(group_path(Group.last))
      end
    end

    context 'with invalid params' do
      it 'do not create a new group' do
        expect do
          post :create, params: { group: invalid_params }
        end.not_to change(Group, :count)
      end
    end
  end

  describe 'GET#edit' do
    before do
      get :edit, params: { id: group.id }
    end

    it 'returns http success and assign group' do
      expect(response).to have_http_status(:success)
      expect(assigns(:group)).to eq(group)
    end
  end

  describe 'PUT#update' do
    context 'with valid params' do
      before do
        put :update, params: { id: group.id,
                               group: valid_params.merge!(group_name: 'Example',
                                                          description: 'some description',
                                                          group_type: 'film') }
      end

      it 'assigns the group' do
        expect(assigns(:group)).to eq(group)
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(group_path(group))
      end

      it 'updates group attributes' do
        group.reload
        expect(group.group_name).to eq(valid_params[:group_name])
        expect(group.description).to eq(valid_params[:description])
        expect(group.group_type).to eq(valid_params[:group_type])
        expect(flash[:success]).to be_present
      end
    end

    context 'with invalid params' do
      it 'does not change group' do
        expect do
          put :update, params: { id: group.id, group: invalid_params }
        end.not_to change { group.reload.updated_at }
      end
    end

    context 'with valid params as simple user' do
      login_user

      before do
        put :update, params: { id: group.id, group: valid_params }
      end

      it 'does not change group' do
        expect { group }.not_to change(group, :reload)
        expect(response).to render_template(:show)
      end
    end
  end

  describe 'DELETE#destroy' do
    it 'destroys the group and redirects to index' do
      expect { delete :destroy, params: { id: group.id } }
        .to change(Group, :count).by(-1)
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(groups_path)
      expect(flash[:warning]).to be_present
    end
  end
end
