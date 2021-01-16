require 'rails_helper'

RSpec.describe UserGroup, type: :model do
  describe 'associations' do
    context 'when belong_to' do
      it 'user' do is_expected.to belong_to(:user) end
      it 'group' do is_expected.to belong_to(:group) end
    end
  end
end

# == Schema Information
#
# Table name: user_groups
#
#  id         :bigint           not null, primary key
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
