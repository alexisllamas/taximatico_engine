class AuthenticationToken < ActiveRecord::Base
  belongs_to :user

  validates :token, presence: true, uniqueness: true

  before_validation :generate_token, on: :create

  def self.get_valid_token(user)
    existing_token = user.authentication_tokens.where(expired: false).first
    return existing_token.token if existing_token.present?
    create!(user: user).token
  end

  private

  def generate_token
    new_token = SecureRandom.hex

    if AuthenticationToken.exists?(token: new_token)
      generate_token
    else
      self.token = new_token
    end
  end
end
