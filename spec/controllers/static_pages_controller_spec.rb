require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  context 'when home controller routes' do
    it 'render home#index' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'render home#about' do
      get :about
      expect(response).to have_http_status(:success)
    end
  end
end
