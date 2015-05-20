class Driver::Request < ActiveRecord::Base
  belongs_to :user
  belongs_to :driver

  has_many   :driver_locations,
    class_name: "Driver::Location", foreign_key: :driver_request_id

  validates :latitude, :longitude, presence: true

  before_create :set_expiration_date

  enum status: [ :pending, :in_progress, :finished ]

  def self.has_active_driver_requests?(user)
    where(user: user, expires_at: Time.current..3.minutes.from_now).any?
  end

  def self.create_driver_request(user, latitude, longitude)
    create(user:      user,
           latitude:  latitude,
           longitude: longitude)
  end

  def assign_driver(driver)
    update! driver: driver
    driver.busy!
    assign_driver_last_location!
    in_progress!
  end

  private

  def assign_driver_last_location!
    driver.current_location.assign_driver_request(self)
  end

  def set_expiration_date
    self.expires_at = 3.minutes.from_now
  end
end
