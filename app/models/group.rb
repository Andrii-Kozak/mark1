class Group < ApplicationRecord
  MUSIC = "music".freeze
  FILM = "film".freeze
  SOCIAL = "social".freeze
  OTHER = "other".freeze

  GROUP_TYPE = [OTHER, MUSIC, FILM, SOCIAL].freeze
  enum group_type: GROUP_TYPE

  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_group

  validates :group_name,  presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 120 }
  validates :group_type, presence: true, inclusion: { in: GROUP_TYPE }

  paginates_per 10
end

# == Schema Information
#
# Table name: groups
#
#  id          :bigint           not null, primary key
#  description :string
#  group_name  :string
#  group_type  :integer          default("other")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
