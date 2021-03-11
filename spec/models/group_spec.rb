require 'rails_helper'

RSpec.describe Group, type: :model do
  let!(:group) { FactoryBot.build(:group, group_name: 'Music', description: 'Oleg Vinnik') }

  context 'when valid Factory' do
    it 'has a valid factory' do
      expect(group).to be_valid
    end
  end

  describe 'length is valid' do
    describe 'group name' do
      it { is_expected.to allow_value('a' * 49).for(:group_name) }
      it { is_expected.to allow_value('a' * 119).for(:description) }
    end
  end

  describe 'length is invalid' do
    describe 'group name' do
      it { is_expected.not_to allow_value('a' * 51).for(:group_name) }
      it { is_expected.not_to allow_value('a' * 121).for(:description) }
    end
  end

  describe 'associations' do
    context 'when have_many' do
      it 'user_groups' do is_expected.to have_many(:user_groups) end
      it 'users' do is_expected.to respond_to(:users) end
    end
  end

  describe 'when user' do
    let(:user_group) { FactoryBot.create(:user_group, :moderator) }

    it 'is moderator' do
      expect(user_group.group.user_moderator?(user_group.user)).to be(true)
    end

    it 'is not moderator' do
      expect(group.user_moderator?(user_group.user)).to be(false)
    end
  end
end

# == Schema Information
#
# Table name: groups
#
#  id          :bigint           not null, primary key
#  description :string
#  group_name  :string
#  group_type  :integer          default("other")
#  image       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
