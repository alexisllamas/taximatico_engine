require 'rails_helper'

describe Driver::Location do
  describe ".create_location" do
    let(:driver) { create :driver }

    subject { Driver::Location.create_location(driver, 100, 100) }

    it "stores the location for the driver" do
      expect { subject }.
        to change(driver.locations, :count).by 1
    end
  end

  describe "#assign_request" do
    let(:driver)          { create :driver          }
    let(:driver_request)  { create :driver_request  }
    let(:driver_location) { driver.current_location }

    before { Driver::Location.create_location(driver, 100, 100) }

    subject { driver_location.assign_driver_request(driver_request) }

    it "assigns the location to a request" do
      expect { subject }.
        to change { driver_location.reload ; driver_location.driver_request }.to eq driver_request
    end
  end
end
