# require 'rails_helper'
#
# RSpec.describe Post, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

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
