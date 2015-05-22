require 'rails_helper'

describe Driver do
  let(:name)        { Faker::Name.name }
  let(:taxi_number) { rand(0..100) }

  describe ".create_driver" do
    subject { Driver.create_driver(name, taxi_number) }

    it "Creates the driver with the data" do
      expect { subject }.
        to change(Driver, :count).by 1
    end
  end

  describe "#update_location" do
    let(:driver) { Driver.create_driver(name, taxi_number) }
    let(:latitude) { 100.00 }
    let(:longitude) { 98.00 }

    subject { driver.update_location(latitude, longitude) }

    it "updates the driver location" do
      expect { subject }.
        to change(driver, :location).to eq({ lat: 100.0, lon: 98.0 })
    end
  end
end
