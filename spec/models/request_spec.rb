require 'rails_helper'

describe Request do
  describe '.has_active_requests?' do
    let(:user) { create :user }
    let(:request) { Request.create_request(user, 1.1, 1.1) }

    subject { Request.has_active_requests?(user) }

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

  describe ".create_request" do
    let(:user) { create :user }

    subject { Request.create_request(user, latitude, longitude) }

    context "when the information is valid" do
      let(:latitude) { "19.224500" }
      let(:longitude) { "-103.741848" }

      it "creates the request successfully" do
        expect { subject }.
          to change(Request, :count).by 1
      end

      it "assigns the request to the user" do
        expect { subject }.
          to change(user.requests, :count).by 1
      end
    end

    context "when the information is invalid" do
      let(:latitude) { nil }
      let(:longitude) { nil }

      it "does not create the request" do
        expect { subject }.
          to change(Request, :count).by 0
      end

      it "returns the errors" do
        expect(subject).to_not be_valid
      end
    end
  end
end
