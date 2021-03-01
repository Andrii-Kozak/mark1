class Post < ApplicationRecord
  belongs_to :postable, polymorphic: true
  belongs_to :creator, class_name: 'User'
  scope :with_creator, -> { includes(:creator) }
  mount_uploader :image, ImageUploader

  # def user_creator?(user)
  #   creator == user
  # end
end

# == Schema Information
#
# Table name: posts
#
#  id            :bigint           not null, primary key
#  body          :text
#  image         :string
#  postable_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  creator_id    :integer
#  postable_id   :bigint
#
# Indexes
#
#  index_posts_on_postable  (postable_type,postable_id)
#
