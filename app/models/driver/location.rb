class Driver::Location < ActiveRecord::Base
  belongs_to :driver
  belongs_to :driver_request, class_name: "Driver::Request"

  validates :driver, :latitude, :longitude, presence: true

  def self.create_location(driver, latitude, longitude)
    create! driver: driver, latitude: latitude, longitude: longitude
  end

  def assign_driver_request(driver_request)
    update! driver_request: driver_request
  end
end
