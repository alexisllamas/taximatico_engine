require "rails_helper"

describe Users::VerificationCodes::Send do
  let(:user) { double :user, phone_number: "+523121125642" }
  let(:verification_code) { double :verification_code, code: rand(6) }

  describe ".call" do
    subject { Users::VerificationCodes::Send.(user, verification_code) }

    it "sends the message trough twilio" do
      expect(Users::VerificationCodes::Send).to receive(:new).
        with(user, verification_code).and_return(double(perform: true))
      subject
    end
  end


  describe "#perform" do
    subject { Users::VerificationCodes::Send.new(user, verification_code) }

    it "sends the message trough twilio" do
      expect(subject.send(:client)).
        to receive_message_chain(:messages, :create).
        with(from: Rails.application.secrets[:twilio_number],
             to:   user.phone_number,
             body: "¡Hola! Aquí está tu código de verificación para ingresar a taximático.mx #{verification_code.code}")

        subject.perform
    end
  end
end
