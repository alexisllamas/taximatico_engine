require_relative "../../../app/services/users/send_verification_code"

describe Users::SendVerificationCode do
  let(:user) { double :user, phone_number: "+523121125642" }
  let(:verification_code) { double :verification_code, code: rand(6) }

  describe ".to" do
    subject { Users::SendVerificationCode.to(user, verification_code) }

    it "sends the message trough twilio" do
      expect(Users::SendVerificationCode).to receive(:new).
        with(user, verification_code).and_return(double(send_sms: true))
      subject
    end
  end


  describe "#send_sms" do
    subject { Users::SendVerificationCode.new(user, verification_code) }

    it "sends the message trough twilio" do
      expect(subject.send(:client)).
        to receive_message_chain(:messages, :create).
        with(from: Rails.application.secrets[:twilio_number],
             to:   user.phone_number,
             body: "¡Hola! Aquí está tu código de verificación para ingresar a taximático.mx #{verification_code.code}")

      subject.send_sms
    end
  end
end
