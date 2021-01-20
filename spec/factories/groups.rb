FactoryBot.define do
  factory :group do
    group_name { Faker::Company.name }
    description { Faker::Lorem.paragraph }
    group_type { Group::GROUP_TYPE.sample }
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
