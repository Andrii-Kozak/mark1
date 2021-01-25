class UserGroup < ApplicationRecord
  belongs_to :user
  belongs_to :group
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
