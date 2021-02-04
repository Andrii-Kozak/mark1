require 'rails_helper'

RSpec.describe UserGroup, type: :model do
  let!(:user) { create(:user) }
  let!(:group) { create(:group) }
  let!(:user_group) { create(:user_group, user: user, group: group, moderator: true) }

  describe 'associations' do
    context 'when belong_to' do
      it 'user' do is_expected.to belong_to(:user) end
      it 'group' do is_expected.to belong_to(:group) end
    end
  end

  describe '.for_user' do
    let!(:not_moderator) { create(:user) }

    it 'returns empty collection' do
      expect(described_class.for_user(not_moderator)).not_to include(not_moderator)
    end

    it 'returns not empty collection' do
      expect(described_class.for_user(user)).to include(user_group)
    end

    it 'empty collection' do
      expect(described_class.for_user(nil)).to match([])
    end
  end

  describe '.moderators' do
    it 'returns not empty collection' do
      expect(described_class.moderators).to include(user_group)
    end

    it 'returns empty collection' do
      user_group.update(moderator: false)
      expect(described_class.moderators).not_to include(user_group)
    end
  end
end

# == Schema Information
#
# Table name: user_groups
#
#  id         :bigint           not null, primary key
#  moderator  :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  group_id   :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_user_groups_on_group_id  (group_id)
#  index_user_groups_on_user_id   (user_id)
#
