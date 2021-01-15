class Group < ApplicationRecord
  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_group

  GROUP_TYPE = [MUSIC, FILM, SOCIAL].freeze
  enum group_type: GROUP_TYPE

  MUSIC = "music".freeze
  FILM = "film".freeze
  SOCIAL = "social".freeze
end

# == Schema Information
#
# Table name: groups
#
#  id          :bigint           not null, primary key
#  description :string
#  group_name  :string
#  group_type  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
