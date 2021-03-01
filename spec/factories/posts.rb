FactoryBot.define do
  factory :post do
    body { Faker::Lorem.paragraph }
    association :creator, factory: :user
    association :postable, factory: :group

    trait :with_image do
      image { File.open("#{Rails.root}/app/assets/images/dog.jpg") }
    end

    trait :for_group do
      association :postable, factory: :group
    end

    trait :for_user do
      association :postable, factory: :user
    end
  end
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
