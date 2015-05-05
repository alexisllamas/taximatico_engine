class Request < ActiveRecord::Base
  belongs_to :user

  validates :latitude, :longitude, presence: true

  before_create :set_expiration_date

  def self.has_active_requests?(user)
    where(user: user, expires_at: Time.current..3.minutes.from_now).any?
  end

  def self.create_request(user, latitude, longitude)
    create(user:      user,
           latitude:  latitude,
           longitude: longitude)
  end

  private

  def set_expiration_date
    self.expires_at = 3.minutes.from_now
  end
end
