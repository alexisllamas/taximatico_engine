require 'rails_helper'

describe Driver::Request do
  describe '.has_active_driver_requests?' do
    let(:user) { create :user }
    let(:request) { Driver::Request.create_driver_request(user, 1.1, 1.1) }

    subject { Driver::Request.has_active_driver_requests?(user) }

    context "when the relationship is empty" do
      it { expect(subject).to eq false }
    end

    context "when active requests present" do
      before { request }

      it { expect(subject).to eq true }
    end

    context "when active request is older than 3 minutes" do
      before { Timecop.freeze(4.minutes.ago) { request } }

      it { expect(subject).to eq false }
    end
  end

  describe ".create_driver_request" do
    let(:user) { create :user }

    subject { Driver::Request.create_driver_request(user, latitude, longitude) }

    context "when the information is valid" do
      let(:latitude) { "19.224500" }
      let(:longitude) { "-103.741848" }

      it "creates the request successfully" do
        expect { subject }.
          to change(Driver::Request, :count).by 1
      end

      it "assigns the request to the user" do
        expect { subject }.
          to change(user.driver_requests, :count).by 1
      end
    end

    context "when the information is invalid" do
      let(:latitude) { nil }
      let(:longitude) { nil }

      it "does not create the request" do
        expect { subject }.
          to change(Driver::Request, :count).by 0
      end

      it "returns the errors" do
        expect(subject).to_not be_valid
      end
    end
  end

  describe '#assign_driver' do
    let(:user) { create :user }
    let(:driver) { create :driver }
    let(:request) { Driver::Request.create_driver_request(user, 1.1, 1.1) }

    before { Driver::Location.create_location(driver, 100, 100) }

    subject { request.assign_driver(driver) }

    it "assigns the driver" do
      expect { subject }.
        to change(request, :driver).to eq driver
    end

    it "updates the driver status" do
      expect { subject }.
        to change(driver, :busy?).to eq true
    end

    it "changes the status from pending to in progress" do
      expect { subject }.
        to change(request, :in_progress?).to be true
    end

    it "creates the first request progress with the last driver's position" do
      expect { subject }.
        to change(request.driver_locations, :count).by 1
    end
  end
end
