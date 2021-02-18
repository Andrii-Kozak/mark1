class User < ApplicationRecord
  scope :ordered_by_id, -> { order("id DESC") }

  SOCIALS = {
    facebook: 'Facebook',
    google_oauth2: 'Google'
  }.freeze

  ADMIN = "admin".freeze
  SIMPLE = "simple".freeze

  ROLES = [ADMIN, SIMPLE].freeze
  enum role: ROLES

  has_many :user_groups, dependent: :destroy
  has_many :groups, through: :user_groups

  validates :first_name,
            :last_name, presence: true, length: { maximum: 50 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true, length: { maximum: 255 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  mount_uploader :image, ImageUploader
  paginates_per 10

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.from_omniauth(auth) # rubocop:disable Metrics/MethodLength
    name_split = auth.info.name.split
    user = User.find_by(email: auth.info.email)
    user ||= User.create(
      provider: auth.provider,
      uid: auth.uid,
      last_name: name_split[1],
      first_name: name_split[0],
      email: auth.info.email,
      password: Devise.friendly_token[0, 20]
    )
    user
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string(254)      not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string(50)       not null
#  image                  :string
#  last_name              :string(50)       not null
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("simple")
#  uid                    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
