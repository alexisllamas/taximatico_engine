class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :authentication_token, presence: true

  before_validation :generate_authentication_token, on: :create

  mount_uploader :profile_picture, ProfilePictureUploader

  def self.register(attributes)
    create!(attributes)
  end

  private

  def generate_authentication_token
    new_token = SecureRandom.hex

    if User.exists?(authentication_token: new_token)
      generate_authentication_token
    else
      self.authentication_token = SecureRandom.hex
    end
  end
end
