class VerificationCode < ActiveRecord::Base
  belongs_to :user

  validates :user, :code, presence: true
  validates :code, uniqueness: true

  before_validation :generate_code, on: :create

  def self.generate_verification_code(user)
    existing_code = user.verification_codes.where(verified: false).first
    return existing_code if existing_code.present?
    create!(user: user)
  end

  def self.find_by_code(code)
    where(code: code, verified: false).first
  end

  def verify!
    update(verified: true)
  end

  private

  def generate_code
    new_code = rand(10**10)

    if VerificationCode.exists?(code: new_code)
      generate_code
    else
      self.code = new_code
    end
  end
end
