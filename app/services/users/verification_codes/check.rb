module Users
  module VerificationCodes
    class Check
      def self.call(*args)
        new(*args).perform
      end

      attr_reader :code, :success, :error
      attr_accessor :verification_code

      def initialize(code, success:, error: -> {})
        @code, @success, @error = code, success, error
        @verification_code = VerificationCode.where(code: code).first
      end

      def perform
        if verification_code.present?
          verification_code.update(verified: true)
          success.call(authentication_token)
        else
          error.call("verification_code_not_exists")
        end
      end

      private

      def authentication_token
        @authentication_token ||=
          AuthenticationToken.get_valid_token(verification_code.user)
      end
    end
  end
end
