require 'rails_helper'

RSpec.describe ApplicationRecord, type: :model do
  describe 'ordered_by_created_at scope' do
    let!(:user1) { FactoryBot.create(:user, created_at: 1.hour.ago) }
    let!(:user2) { FactoryBot.create(:user, created_at: 2.hours.ago) }

    it 'sort collection' do
      expect(User.ordered_by_created_at.first).to eq(user1)
      expect(User.ordered_by_created_at.last).to eq(user2)
    end
  end
end
