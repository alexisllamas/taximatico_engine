require 'rails_helper'

describe Users::VerificationCodes::Create, vcr: "twilio_sms" do
  let(:phone_number) { "+523121125642" }
  let(:error)        { double :error,   call: true }
  let(:success)      { double :success, call: true }
  let(:arguments)    { [ phone_number, { success: success, error: error } ] }

  subject { Users::VerificationCodes::Create.(*arguments) }

  describe ".call" do
    context "when providing a new phone number" do
      it "creates the user if it's not created" do
        expect { subject }.
          to change(User, :count).by 1
      end

      it "calls the success method" do
        expect(success).to receive(:call)
        subject
      end

      it "generates a new verification_code" do
        expect { subject }.
          to change(VerificationCode, :count).by 1
      end

      it "sends the message" do
        expect(Users::SendVerificationCode).to receive(:to)
        subject
      end
    end

    context "when providing an existing phone number" do
      let!(:user) { create(:user, phone_number: phone_number) }

      it "does not create a new user" do
        expect { subject }.
          to change(User, :count).by 0
      end

      it "calls the success method" do
        expect(success).to receive(:call)
        subject
      end

      it "generates a new verification_code" do
        expect { subject }.
          to change(user.verification_codes, :count).by 1
      end

      it "sends the message" do
        expect(Users::SendVerificationCode).to receive(:to)
        subject
      end
    end

    context "when provided number is not correct" do
      let(:phone_number) { nil }

      it "calls the error method" do
        expect(error).to receive(:call)
        subject
      end
    end
  end
end
