module Users
  module VerificationCodes
    class Send
      def self.call(*args)
        new(*args).perform
      end

      attr_reader :user, :verification_code

      def initialize(user, verification_code)
        @user, @verification_code = user, verification_code
      end

      def perform
        client.messages.create(from: from,
                               to:   user.phone_number,
                               body: sms_body)
      end

      private

      def sms_body
        @sms_body ||= "¡Hola! Aquí está tu código de verificación para ingresar a taximático.mx #{verification_code.code}"
      end

      def from
        @from ||= Rails.application.secrets[:twilio_number]
      end

      def client
        @client ||= Twilio::REST::Client.new
      end
    end
  end
end
