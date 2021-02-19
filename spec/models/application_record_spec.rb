require 'rails_helper'

RSpec.describe ApplicationRecord, type: :model do
  describe 'ordered_by_created_at scope' do
    before do
      create_list(:user, 3)
    end

    it 'sort collection by DESC id' do
      max_id = User.maximum('id')
      min_id = User.minimum('id')
      expect(User.ordered_by_created_at.first).to eq(User.find(max_id))
      expect(User.ordered_by_created_at.last).to eq(User.find(min_id))
    end
  end
end
