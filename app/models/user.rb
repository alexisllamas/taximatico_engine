class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable

  mount_uploader :profile_picture, ProfilePictureUploader

  validates :phone_number, presence: true, uniqueness: true
  validates :phone_number, format: /\+(?:[0-9]●?){6,14}[0-9]/

  has_many :verification_codes
  has_many :authentication_tokens
  has_many :requests

  def self.find_by_authentication_token(token)
    User.joins(:authentication_tokens).
      where(authentication_tokens: { token: token, expired: false }).first
  end
end
