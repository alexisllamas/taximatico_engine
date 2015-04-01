class User < ActiveRecord::Base
  class AuthenticationError < StandardError; end

  mount_uploader :profile_picture, ProfilePictureUploader

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  validates :authentication_token,
    :phone_number,
    presence: true

  before_validation :generate_authentication_token, on: :create

  def self.register!(attributes)
    create!(attributes)
  end

  def self.authenticate!(attributes)
    user = User.find_by!(email: attributes[:email])
    unless user.valid_password? attributes[:password]
      raise AuthenticationError.new("Invalid password")
    end
    return user
  end

  def self.destroy_authentication_token!(user)
    user.send(:generate_authentication_token)
    user.save!
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
